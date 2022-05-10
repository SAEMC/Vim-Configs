
cmd="$1"

if [[ "$cmd" == "-a" || "$cmd" == "--all" ]]; then
  echo "ALL"
elif [[ "$cmd" == "-p" || "$cmd" == "--plugins" ]]; then
  echo "Plugins"
elif [[ "$cmd" == "s" || "$cmd" == "--script" ]]; then
  echo "Script"
else
  echo "The way you install SAEMC Vim Settings
  -a, --all: Force the installation plugins and writing \$HOME/.vimrc
  -p, --plugins: Force the installation plugins
  -s, --script: Force the writing \$HOME/.vimrc"
fi
