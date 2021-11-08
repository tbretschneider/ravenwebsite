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
firstname=$2
secondname=$3
cat > ~/${user}website/config.yaml << EOF
baseURL: "https://users.ox.ac.uk/~${user}/"
title: ${firstname}'s Website
paginate: 5
theme: PaperMod
publishdir: ${HOME}/public_html/

enableRobotsTXT: true
buildDrafts: false
buildFuture: false
buildExpired: false

minify:
    disableXML: true
    minifyOutput: true

params:
    env: production # to enable google analytics, opengraph, twitter-cards and schema.
    title: ${firstname}'s Website
    description: "This is my blog post."
    keywords: [Blog, Portfolio, PaperMod]
    author: ${firstname} ${secondname}
    # author: ["Me", "You"] # multiple authors
    images: ["https://www.ballioljcr.org/sites/default/files/BUMS-logo-hoodie_0.png"]
    DateFormat: "January 2, 2006"
    defaultTheme: auto # dark, light
    disableThemeToggle: false

    ShowReadingTime: true
    ShowShareButtons: true
    ShowPostNavLinks: true
    ShowBreadCrumbs: true
    ShowCodeCopyButtons: false
    disableSpecial1stPost: false
    disableScrollToTop: false
    comments: true
    hidemeta: false
    hideSummary: false
    showtoc: true
    tocopen: true

    assets:
        # disableHLJS: true # to disable highlight.js
        # disableFingerprinting: true
        favicon: "https://www.ballioljcr.org/sites/default/files/favicon.ico"
        favicon16x16: "<link / abs url>"
        favicon32x32: "<link / abs url>"
        apple_touch_icon: "<link / abs url>"
        safari_pinned_tab: "<link / abs url>"

    label:
        text: "Home"
        icon: logogoeshere
        iconHeight: 35

    # profile-mode
    profileMode:
        enabled: true # needs to be explicitly set
        title: ${firstname}'s Website
        subtitle: "This is my blog."
        imageUrl: "https://www.ballioljcr.org/sites/default/files/BUMS-logo-hoodie_0.png"
        imageWidth: 120
        imageHeight: 120
        imageTitle: Balliol Maths Soc
        buttons:
            - name: Posts
              url: posts
            - name: Oxford Matrix
              url: https://chat.cs.ox.ac.uk
            - name: My Matrix
              url: https://matrix.to/#/@${firstname}.${secondname}:cs.ox.ac.uk

    # home-info mode
    homeInfoParams:
        Title: "Hi, there user"
        Content: Welcome to my blog

    socialIcons:
        - name: matrix
          url: "https://matrix.to/#/@${firstname}.${secondname}:cs.ox.ac.uk"
        - name: email
          url: "mailto:${firstname}.${secondname}@balliol.ox.ac.uk"

    cover:
        hidden: true # hide everywhere but not in structured data
        hiddenInList: true # hide on list pages and home
        hiddenInSingle: true # hide on single page

    editPost:
        URL: "https://github.com/<path_to_repo>/content"
        Text: "Suggest Changes" # edit text
        appendFilePath: true # to append file path to Edit link

    # for search
    # https://fusejs.io/api/options.html
    fuseOpts:
        isCaseSensitive: false
        shouldSort: true
        location: 0
        distance: 1000
        threshold: 0.4
        minMatchCharLength: 0
        keys: ["title", "permalink", "summary", "content"]
menu:
    main:
        - identifier: chat.ox.ac.uk
          name: chat.ox.ac.uk
          url: https://chat.ox.ac.uk
          weight: 30
# Read: https://github.com/adityatelange/hugo-PaperMod/wiki/FAQs#using-hugos-syntax-highlighter-chroma
# pygmentsUseClasses: true
# markup:
#     highlight:
#         # anchorLineNos: true
#         codeFences: true
#         guessSyntax: true
#         lineNos: true
#         style: monokai
EOF
rm ~/${user}website/config.toml
cd ~/${user}website/
hugo new posts/initialpost.md
sleep 5s 
cat ${HOME}/ravenwebsite/initialpost.md >> ~/${user}website/content/posts/initialpost.md
hugo -D 
