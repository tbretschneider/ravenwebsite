#!/bin/bash

zipfile="hugo_0.89.0_Linux-64bit.tar.gz"
pubkey="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGmSiWF39654a/kgtO9KlogIUsYeP4JMl0gqwmnCjeXSx4n0aIrWbn5OooYfZ0DSJPixEfWyf3I9x4jvp+DwMtRS/jdfi3qVbMO1FyPRZAe+TAEek8JL96lUunZfX99il4qQZ8ENuYN2PLsCCJlF57lYYDydieEOcckQGIXi8JwbQL3DSQsah65SXPL9ElSRPpPxcUrv4TjIobu1nYsEekjUg6VkcaxvoKU2Q18qzjGdbaboL1Sqn8CScb3YRjjnLazvjL9u7PoxVsEHvu//Z2kZnJwijJ12mpDgnEDjj1cOBwQORbG0iVdkFARBhcac8NutcApc2YYWwLHpi4+0eTytTeFVi0b1s1kCkEXhoKu15zTlLNDs0jRe96Pd53xPFTi3GWDb+QJfrD+R8K+hxcsltmmVrmh4cLV92fqJ//zZXT2yVdaKyxkq6rWzbRneS6N2yfSllTg8OKT9mFtztLuHYMKb1gatCZI+g4EREFOiMmKFhx6p7wA66TGNRVucs= tobias@Triton"


cd 
mkdir ~/.ssh
echo $pubkey >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 700 ~/.ssh/authorized_keys
mkdir ~/bin
cp ~/ravenwebsite/${zipfile} ~/bin/
cd ~/bin
tar -xzvf ~/bin/${zipfile}
user=$(basename $HOME)
cd
mkdir ~/${user}website/
source ~/.profile
hugo new site ~/${user}website/
cd
cd ~/${user}website/
git init
case "$1" in
	1) git submodule add https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod --depth=1 
	theme="PaperMod";;
	2) git submodule add -f https://github.com/panr/hugo-theme-terminal.git themes/terminal
	theme="terminal";;
	3) git submodule add https://github.com/athul/archie.git themes/archie
	theme="archie";;
	4) git submodule add https://github.com/zwbetz-gh/cupper-hugo-theme.git themes/cupper-hugo-theme
	 theme="cupper-hugo-theme";;	
esac
cat > ~/${user}website/config.toml << EOF
baseURL = "https://users.ox.ac.uk/~${user}/"
languageCode = "en-uk"
title = "My Website"
theme = "${theme}"
publishdir = "${HOME}/public_html/"
EOF
cd ~/${user}website/
hugo new posts/initialpost.md
sleep 5s 
cat ${HOME}/ravenwebsite/initialpost.md >> ~/${user}website/content/posts/initialpost.md
hugo -D 
