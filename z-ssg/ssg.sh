#!/usr/bin/sh
# Author: Richard Zins
# Note this shell script is for arch systems
# And remember since this installs pandoc you need to chmod u+s ssg.sh

if ! command -v pandoc &> /dev/null
then
    echo "pandoc not installed..."
    echo "installing now"
    pacman -Sy pandoc
fi

# get all posts
posts=($(ls input))

# run pandoc for all posts
for post in "${posts[@]}" 
do
    # remove .md suffix
    post_no_md=${post%.md}
    pandoc --standalone --template blog-template.html "input/$post" -o "output/$post_no_md.html"
done