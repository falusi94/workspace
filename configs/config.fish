# language support
export LANG="en_US"
export LC_ALL=$LANG.UTF-8

# configure less
export LESS="R"

# load local config if provided
begin
  set -l LOCAL_CONFIG ~/.config/fish/config.local.fish
  if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
  end
end

# clang aliases
alias cl++11="clear; clang++ -std=c++11 -Wall -Wdeprecated -pedantic"
alias cl++="clear; clang++ -std=c++99 -Wall -Wdeprecated -pedantic"
alias cl11="clear; clang -std=c11 -Wall -Wdeprecated -pedantic"
alias cl="clear; clang -std=c99 -Wall -Wdeprecated -pedantic"

# utils
alias u1="cd .."
alias u2="cd ../.."
alias u3="cd ../../.."
alias u4="cd ../../../.."
alias f="fuck"
alias enablevnc="sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -clientopts -setvnclegacy -vnclegacy yes -clientopts -setvncpw -vncpw mypasswd -restart -agent -privs -all"
alias disablevnc="sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -configure -access -off"
alias pwdgenerate="openssl rand -base64 32"
alias aa="atom ."
alias ll="ls -lahLG"
alias lls="ls -lahLSG"

# ruby/rails utils
alias be="bundle exec"
alias rs="bundle exec rspec --colour"
alias rss="bin/rspec --colour"
alias ft="bundle exec rake test; bundle exec rake db:test:prepare; bundle exec rspec --colour"
alias rc="bin/spring stop; bundle exec rails console"
alias prep="bundle exec rake db:test:prepare"
alias rts="bundle exec rake routes"
function rt
  bundle exec rake test TEST=$argv
end

# js/npm utils
alias nrt="npm run test:watch"
alias nrs="npm start"
function init_module
  touch $argv.constants.js
  touch $argv.redux.js
  touch $argv.redux.test.js
  touch $argv.service.js
end

# git utils
alias gpll="git pull --rebase"
alias gcm="git commit"
alias gpsh="git push"
alias g="git"
alias gf="git fetch -p"
alias gst="git stash --include-untracked"
alias gsta="git stash apply"
alias gpf="git push --force-with-lease"
alias gdrc="git ls-files -m | xargs ls -1 2>/dev/null | grep '\.rb\$' | xargs rubocop"
alias gcan="git commit --amend --no-edit"
alias grc="git rebase --continue"
alias gra="git rebase --abort"
alias grs="git rebase --skip"
alias grm="git rebase origin/master"
function gri
  git rebase -i "$argv^"
end
function grtc
  git add --all
  git commit --fixup=$argv
  git rebase --interactive --autosquash $argv^
end
alias gcx="git cherry-pick -x"
alias gca="git commit --amend"
alias gcp="git cherry-pick"

# asdf init
source /usr/local/opt/asdf/asdf.fish
