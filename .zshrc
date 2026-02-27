for rc in ${HOME}/.zsh/init/*.sh ; do
  source ${rc}
done

for rc in ${HOME}/.zsh/opt/*.sh ; do
  source ${rc}
done


# bun completions
[ -s "/Users/a13613/.bun/_bun" ] && source "/Users/a13613/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

. "$HOME/.local/bin/env"

alias claude-mem='/Users/a13613/.bun/bin/bun "/Users/a13613/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"'

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
