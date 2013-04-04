function prompt_char {
	if [ $UID -eq 0 ]; then echo "#"; else echo "$"; fi
}

# PROMPT='%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%}%n@)%m %{$fg_bold[blue]%}%(!.%1~.%~) $(git_prompt_info)%_$(prompt_char)%{$reset_color%} '
PROMPT='%F{36}%n%f@%F{34}%m:%f%F{3}%B%~%b%f%(!|#|$) '

