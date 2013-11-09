if [[ -d $HOME/.nvm ]]; then
  [ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh  # This loads NVM
else
  echo ""
  echo "You don't have nvm installed. Get at it, buddy!"
fi
