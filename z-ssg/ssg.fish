#!/usr/bin/fish

# TODO: Redo based on pandoc

function parse_headings -a post_file
    set -g -a headings (grep \# ./input/$post_file)
end

function make_html_headings -a headingsArg
    for heading in $headingsArg
        set -g -a html_headings "<h1>$heading</h1>"
    end	
end

# modified italics parsing because its easier
function parse_italics -a post_file
    # variable expansion still takes place with double quotes
    # so since there are no vars in our regex we should use single quotes
    set -g -a italics (grep -E '(_.*_)' ./input/$post_file)
end

# modified bold parsing because its easier
function parse_bolds -a post_file
    set -g -a bolds (grep -E '(\*.*\*)' ./input/$post_file)
end

set posts (ls ./input) 

for post in $posts
    parse_headings $post
    make_html_headings $headings
    parse_italics $post
    parse_bolds $post
    echo $headings
    echo $html_headings
    echo $italics
    echo $bolds
    set -e headings
    set -e html_headings
    set -e italics
    set -e bolds
end

# TODO: If I parse into vars how will I keep content order....?
