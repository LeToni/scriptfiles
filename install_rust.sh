# if no xcode tools installed, uncommrnz following line
# brew install gcc

# add following lines alias to .zshrc/ .bash_profile if you want to use brew gcc instead of apple gcc
# alias gcc='gcc-10'
# alias cc='gcc-10'
# alias g++='g++-10'
# alias c++='c++-10' 
# (if gcc is version 10 else modify version accordingly)

# use following if facing issues with installation instructions given on official rust page
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path
echo -e 'source "$HOME/.cargo/env"' >> ~/.zshrc
#echo -e 'source "$HOME/.cargo/env"' >> ~/.bash_profile