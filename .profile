export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

# If you installed the SDK via Homebrew, otherwise ~/Library/Android/sdk
export ANDROID_HOME=/usr/local/opt/android-sdk

export REACT_EDITOR=/usr/local/bin/emacs

PATH=$HOME/.nodebrew/current/bin:$PATH

touch ~/.gradle/gradle.properties && echo "org.gradle.daemon=true" >> ~/.gradle/gradle.properties

alias emacs='/usr/local/Cellar/emacs/25.2/bin/emacs'
alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
alias tree='tree -N'

export PATH="$HOME/.rbenv/bin:$PATH"
# $ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# for Docker toolbox
# eval $(docker-machine env default)
