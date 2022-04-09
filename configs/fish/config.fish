# language support
export LANG="en_US"
export LC_ALL=$LANG.UTF-8

# configure less
export LESS="R"

# set Homebrew paths
if test (arch) = "i386"
  set HOMEBREW_PREFIX /usr/local
else
  set HOMEBREW_PREFIX /opt/homebrew
end

fish_add_path -m --path $HOMEBREW_PREFIX/bin

# load configs if provided
begin
  set -l ASDF_CONFIG $HOMEBREW_PREFIX/opt/asdf/asdf.fish
  set -l LOCAL_CONFIGS ~/.config/fish/config.local.fish

  set -l config_files $LOCAL_CONFIGS $ASDF_CONFIG

  for config_file in $config_files;
    if test -f $config_file
      source $config_file
    end
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
alias clean_docker='sh -c \'docker rmi $(docker images --quiet --filter "dangling=true")\''
alias chrcors='open -n -a /Applications/Chromium.app/Contents/MacOS/Chromium  --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security'
alias de='cd ~/Develop'
alias ibrew='arch -x86_64 /usr/local/bin/brew'
alias abrew='arch -arm64 /opt/homebrew/bin/brew'
alias ifish='arch -x86_64 /usr/local/Cellar/fish/3.3.1/bin/fish'

# ruby/rails utils
alias be="bundle exec"
alias rs="bundle exec rspec --color"
alias rss="bin/rspec --color"
alias rc="bundle exec rails console"
alias rcc="bin/rails console"
alias prep="bundle exec rake db:test:prepare"
alias rts="bundle exec rake routes"
alias rtsg="bundle exec rake routes | grep"
function rt
  if test -n "$argv"
    bundle exec rake test TEST=$argv
  else
    bundle exec rake test
  end
end

# js/npm utils
alias nrt="npm run test:watch"
alias nrs="npm start"
alias nv="npm version"

# git utils
alias gpll="git pull --rebase"
alias gcm="git commit"
alias gpsh="git push"
alias gpt="git push origin --tags"
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
function grdt
  if test -n "$argv"
    env GIT_COMMITTER_DATE=$argv git commit --amend --date=$argv --no-edit;
  else
    echo 'Missing date argument, the format should be like 2019.11.10 14:28:13'
  end
end
