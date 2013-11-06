# Includes
. ~/.config/fish/z.fish

# rbenv configuration
set PATH $HOME/.rbenv/shims $PATH
. (rbenv init -|psub)

# Go configuration
set -x GOPATH $HOME/Documents/go
set -x GOROOT /usr/local/Cellar/go/1.1.2/libexec

# Customize to your needs...
set PATH $GOPATH/bin $PATH
set PATH $GOROOT/bin $PATH

# Java configuration
set -x JAVA_HOME (/usr/libexec/java_home)
set PATH $JAVA_HOME/bin $PATH

# Scala configuration
set -x SCALA_HOME /usr/local/Cellar/scala/2.10.3/libexec

# Play framework installation
set PATH $HOME/play-2.2.0 $PATH

# Customize the directory
set fish_git_dirty_color red
set fish_git_not_dirty_color green

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
    printf '%s%s%s (%s)> ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (parse_git_branch)
  else
    printf '%s%s%s> ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
  end
  z --add "$PWD"
end
