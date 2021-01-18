#! /bin/bash
# Replace with version to install
python_version="3.7.3"

# Uncomment following if pyenv is not installed yet
# brew install pyenv

pyenv install python_version

# Uncomment following if python version should installed as global version
pyenv global python_version
# Check manually if python version was set correctly
pyenv version

# Add pyenv to configuration file
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc
# Comment above and uncomment below if .bash_profile is used instead of .zshrc
#echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile