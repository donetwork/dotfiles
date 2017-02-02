# Virsh Completion
_virsh_vm_name()
{
  virsh list --all --name "${@}" 
}

_virsh_vol_name()
{
  virsh vol-list default  | sed '1,2d' | awk '{print $1}'
}

_virsh()
{
  local cur prev

  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"

  case "${prev}" in
    list)
      COMPREPLY=( $(compgen -W "--all --inactive --state-running --state-paused --state-shutoff --state-other --autostart --no-autostart --with-managed-save --without-managed-save --with-snapshot --without-snapshot" -- ${cur} ) ) 
      return 0 
      ;;
    autostart)
      COMPREPLY=( $(compgen -W "$(_virsh_vm_name --no-autostart)" -- ${cur}) ) 
      return 0 
      ;;
    start)
      COMPREPLY=( $(compgen -W "$(_virsh_vm_name --state-shutoff)" -- ${cur} ) ) 
      return 0 
      ;;
    shutdown|console|domid|domname|send-key|managedsave|migrate|reboot|reset|save|suspend|vncdisplay)
      COMPREPLY=( $(compgen -W "$(_virsh_vm_name --state-running)" -- ${cur} ) ) 
      return 0 
      ;;
    edit|destroy|desc|dumpxml|managedsave-remove|restore|resume|setmem|setvcpus|undefine)
      COMPREPLY=( $(compgen -W "$(_virsh_vm_name)" -- ${cur} ) ) 
      return 0 
      ;;
    vol-delete|vol-info)
      COMPREPLY=( $(compgen -W "$(_virsh_vol_name --pool default)" -- ${cur} ) ) 
      return 0 
      ;;
    *)
      COMPREPLY=( $(compgen -W "autostart start shutdown console domid domname send-key migrate reboot reset save suspend vncdisplay managedsave edit destroy desc dumpxml managedsave-remove restore resume list sysinfo vol-list vol-info" -- ${cur}) ) 
      return 0 
    ;;
  esac
}
complete -F _virsh virsh
