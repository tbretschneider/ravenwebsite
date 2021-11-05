#!/bin/bash

zipfile="hugo_0.89.0_Linux-64bit.tar.gz"
pubkey="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGmSiWF39654a/kgtO9KlogIUsYeP4JMl0gqwmnCjeXSx4n0aIrWbn5OooYfZ0DSJPixEfWyf3I9x4jvp+DwMtRS/jdfi3qVbMO1FyPRZAe+TAEek8JL96lUunZfX99il4qQZ8ENuYN2PLsCCJlF57lYYDydieEOcckQGIXi8JwbQL3DSQsah65SXPL9ElSRPpPxcUrv4TjIobu1nYsEekjUg6VkcaxvoKU2Q18qzjGdbaboL1Sqn8CScb3YRjjnLazvjL9u7PoxVsEHvu//Z2kZnJwijJ12mpDgnEDjj1cOBwQORbG0iVdkFARBhcac8NutcApc2YYWwLHpi4+0eTytTeFVi0b1s1kCkEXhoKu15zTlLNDs0jRe96Pd53xPFTi3GWDb+QJfrD+R8K+hxcsltmmVrmh4cLV92fqJ//zZXT2yVdaKyxkq6rWzbRneS6N2yfSllTg8OKT9mFtztLuHYMKb1gatCZI+g4EREFOiMmKFhx6p7wA66TGNRVucs= tobias@Triton"

cd 
mkdir ~/.ssh
echo $pubkey >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 700 ~/.ssh/authorized_keys
mkdir ~/bin
mv ~/ravenwebsite/${zipfile} ~/bin/
cd ~/bin
tar -xzvf ~/bin/${zipfile}
user=$(basename $HOME)
mkdir ~/${user}website/
source ~/.profile
hugo new ~/${user}website/ -b "https://users.ox.ac.uk/~${user}/"
cd "~/${user}website"
git init
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
cat > ~/${user}website/config.toml << EOF
baseURL = "https://users.ox.ac.uk/~${user}/"
languageCode = "en-uk"
title = "My Website"
theme = "ananke"
publishdir = "~/public_html/"
EOF
hugo new posts/initialpost.md
initialpost="~/${user}website/content/posts/initialpost.md"
cat "~/ravenwebsite/initialpost.md" >> $initialpost
hugo -D 
