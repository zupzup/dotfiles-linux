function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function battery_charge {
    echo `$BAT_CHARGE` 2>/dev/null
}

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

PROMPT='%{$FG[082]%}mz%{$reset_color%}%{$FG[015]%}:%{$reset_color%}%{$FG[123]%}$(collapse_pwd)%{$reset_color%}$(git_prompt_info) $ '


ZSH_THEME_GIT_PROMPT_PREFIX=" (%{$fg[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
