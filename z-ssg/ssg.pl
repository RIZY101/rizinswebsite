#!/usr/bin/perl
# Author: Richard Zins
# Need to chmod u+s the script for its install features to work

use strict;
use warnings;

# TODO Make install checking more robust
my $installed = `/usr/bin/bash -c command -v pandoc`;
if (!defined($installed))
{
	print "pandoc not installed\n";
	print "installing now\n";
	`pacman -Sy pandoc`;
}

# get all posts
my @posts = `ls input`;

# run pandoc for all posts
foreach my $post (@posts)
{
	my $post_no_md = substr($post, 0, -4);
	print "processing $post_no_md\n";
	system('pandoc', '--standalone', '--template', 'blog-template.html', "/home/rizins/rizinswebsite/z-ssg/input/$post", '-o', "/home/rizins/rizinswebsite/z-ssg/output/$post_no_md.html");
}
