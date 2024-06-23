if status is-interactive
  # Commands to run in interactive sessions can go here
  function safe_source
    if test -f $argv[1]; source $argv[1]; end
  end

  function run_if_executable_exists
    if which $argv[1] >/dev/null; set cmd $argv[2..-1]; $cmd; end
  end

  function init_brew_packages
    safe_source "$(brew --prefix asdf)"/libexec/asdf.fish
    safe_source "$(brew --prefix)/share/google-cloud-sdk/path.fish.inc"
  end

  run_if_executable_exists brew init_brew_packages
  run_if_executable_exists atuin atuin init fish | source

  safe_source ~/.config/fish/config.local.fish

  fish_add_path ~/bin

  # Set up mocword data https://github.com/high-moctane/mocword
  if test -f ~/mocword.sqlite
    export MOCWORD_DATA=$(readlink -f ~/mocword.sqlite)
  end

  export GPG_TTY=$(tty)
  export EDITOR=vim
  export LESS=R
  export LANG=en_US
  export LC_ALL=$LANG.UTF-8
  export LC_CTYPE=$LANG.UTF-8

  # General utils
  alias u1='cd ..'
  alias u2='cd ../..'
  alias u3='cd ../../..'
  alias u4='cd ../../../..'
  alias pwdgenerate='openssl rand -base64 32 | pbcopy'
  alias ll='ls -lahLG'
  alias lls='ls -lahLSG'
  alias de='cd ~/Develop'
  alias unquarantine='xattr -d com.apple.quarantine'

  # 🐳 stuff
  alias ld='lazydocker'
  alias clean_docker='sh -c \'docker rmi $(docker images --quiet --filter "dangling=true")\''
  alias k='kubectl'
  function kdescyml
    kubectl describe $argv | bat -l yaml
  end
  function kgetyml
    kubectl get $argv -o yaml | bat -l yaml
  end

  # Terreform stuff
  alias clean_up_terragrunt='find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \;'

  # Ruby/Rails utils
  alias be='bundle exec'
  alias br='bin/rails'
  alias rs='bundle exec rspec'
  alias rss='bin/rspec'
  alias rc='bundle exec rails console'
  alias rcc='bin/rails console'
  alias prep='bundle exec rake db:test:prepare'
  alias rts='bundle exec rails routes'
  alias rtsg='bundle exec rails routes | grep'

  # JS/npm utils
  alias nrt='npm run test:watch'
  alias nrs='npm start'
  alias nv='npm version'

  # Git utils
  alias lg='lazygit'
  alias g='git'
  alias gpll='git pull --rebase'
  alias gf='git fetch -p'
  alias gpsh='git push'
  alias gpf='git push --force-with-lease'
  alias gpt='git push origin --tags'
  alias gst='git stash --include-untracked'
  alias gsta='git stash apply'
  alias gdrc="git ls-files -m | xargs ls -1 2>/dev/null | grep '\.rb\$' | xargs rubocop"
  alias gcm='git commit'
  alias gcan='git commit --amend --no-edit'
  alias grc='git rebase --continue'
  alias gra='git rebase --abort'
  alias grs='git rebase --skip'
  alias grm='git rebase origin/master'
  alias gcx='git cherry-pick -x'
  alias gca='git commit --amend'
  alias gcp='git cherry-pick'
  alias gup='git stash --include-untracked && git pull --rebase && git stash pop'
  alias gch='git checkout'
  function gri
    git rebase -i "$argv^"
  end
  function grtc
    git add --all
    git commit --fixup=$argv
    git rebase --interactive --autosquash $argv^
  end
  function grdt
    if test -n "$argv"
      env GIT_COMMITTER_DATE=$argv git commit --amend --date=$argv --no-edit;
    else
      echo 'Missing date argument, the format should be like 2019.11.10 14:28:13'
    end
  end
end
