# Clear screen
clear

# Alias
if [ -f ~/.bash/bashrc.alias ]
then
  source ~/.bash/bashrc.alias
fi

# Completion
for file in $(ls -1 ~/.bash_completion.d)
do
  source ~/.bash_completion.d/$file
done

# Color files
export LS_OPTIONS='--color=auto'
eval `dircolors -b`

# Global Alias
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -alh'
alias l=ll

# Prompt
if [[ `whoami` == "root" ]]
then
  export PS1='\[\033[01;31m\]\u\[\033[00m\]@\H\[\033[01;34m\] \w \$\[\033[00m\] '
else
  export PS1='\[\033[01;33m\]\u\[\033[00m\]@\H\[\033[01;34m\] \w \$\[\033[00m\] '
fi
