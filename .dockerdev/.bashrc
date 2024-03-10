alias be="bundle exec"

# For ssh-agent availability in docker container
if [ -z "$SSH_AUTH_SOCK" ]; then
   RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
   if [ "$RUNNING_AGENT" = "0" ]; then
        ssh-agent -s &> $HOME/.ssh/ssh-agent
   fi
   eval `cat $HOME/.ssh/ssh-agent`
fi

peco_search_history() {
   local l=$(HISTTIMEFORMAT= history | \
   sort -r | sed -E s/^\ *[0-9]\+\ \+// | \
   peco --query "$READLINE_LINE")
   READLINE_LINE="$l"
   READLINE_POINT=${#l}
}
bind -x '"\C-r": peco_search_history'