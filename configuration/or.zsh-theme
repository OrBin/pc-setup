k8s_prompt_info() {
    context=$(kubectl config current-context 2>&1)
    if [ "$context" != "error: current-context is not set" ]; then
        echo " %{$fg[blue]%}%D{⎈ ${context}}"
    fi
}


PROMPT='%{$fg[green]%}%D{%H:%M:%S}\
 %{$fg[white]%}%n@%m\
$(k8s_prompt_info)\
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
