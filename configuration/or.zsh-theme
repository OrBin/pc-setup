PROMPT='%{$fg[green]%}%D{%H:%M:%S}\
 %{$fg[white]%}%n@%m\
 %{$fg[blue]%}%D{⎈ $(kubectl config current-context)}\
 %{$fg[yellow]%}🐍$(pyenv_prompt_info)\
 $(git_prompt_info)\
%{$fg[cyan]%}%~%{$reset_color%}\
 %(?:%{$fg_bold[green]%}➜:%{$fg_bold[red]%}➜)%{$reset_color%}\
 '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}✗ "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%} "

ZSH_PYENV_VIRTUALENV=true
