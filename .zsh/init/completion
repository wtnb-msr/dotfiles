# Enable completion
autoload -Uz compinit
compinit

# Selection of completion with highlight
zstyle ':completion:*:default' menu select=1

# Match lower case to upper case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Skip completion after `../`
zstyle ':completion:*' ignore-parents parent pwd ..

# Enable completion after sudo
zstyle ':completion:*:sudo:*' command-path \
  /sbin /bin /usr/bin /usr/sbin \
  /usr/local/bin /usr/local/sbin

