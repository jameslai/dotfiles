# We like vim

set EDITOR /usr/local/bin/vim

# Includes
. ~/.config/fish/z.fish

pyenv init - | source

# Local config
set PATH /usr/local/bin /usr/local/go/bin $PATH
set -x GOPATH $HOME/go

# rbenv configuration
if test -d $HOME/.rbenv/shims
	set PATH $HOME/.rbenv/shims $PATH
	rbenv rehash > /dev/null ^&1
end

# Customize the directory
set fish_git_dirty_color yellow
set fish_git_not_dirty_color cyan
set fish_color_cwd blue
set fish_color_command green

function fish_greeting
    fortune
end

function parse_git_branch
  set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
  set -l git_diff (git diff)

  if test -n "$git_diff"
    echo (set_color $fish_git_dirty_color)$branch(set_color normal)
  else
    echo (set_color $fish_git_not_dirty_color)$branch(set_color normal)
  end
end

function fish_prompt
  if test -d .git
    printf '%s➜  %s%s%s %s %s$ %s' (set_color green) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (parse_git_branch) (set_color magenta) (set_color normal)
  else
    printf '%s➜  %s%s%s $ %s' (set_color green) (set_color $fish_color_cwd) (prompt_pwd) (set_color magenta) (set_color normal)
  end
  z --add "$PWD"
end
