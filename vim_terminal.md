```
# LINK DOT FILES

Ex: ln -s ~/code/dotfiles/vimrc ~/.vimrc

############
# TERMINAL #
############

acpi -t
see how hot the computer is.  anything below 70 is ok

$ reboot
$ poweroff


# NAVIGATING

lists files with added details
$ ls -l

list hidden files
$ ls -a

finds all files that end with '.md'
$ ls -l *.md

finds all files that start with 'ch' & ends with '.md'
$ ls -l ch*.md

see file with line numbers
cat -b [filename.txt]

autocreate nonexistant parent files
$ mkdir -p /tmp/amrood/test > if 'amrood' didn't exist

###  say 'directory' instead of 'folder'

# dots
'.' - represents current working directory
'..' - represents directory below current directory


# GREP #
v - Print all lines that do not match pattern.
n - Print the matched line and its line number.
l - Print only the names of files with matching lines (letter "l")
c - Print only the count of matching  lines.
i - Match either upper- or lowercase

search single directory
$ grep -irn "[search word]" [directory]

search multiple directories
$ grep -irn "[search word]" [directory] [directory] [directory]

pipe searches with filters (exclude searches by keywords)
$ grep -irn "[search word]" [directory] | grep -v "[exluded words]"

#######
# VIM #
#######

Search & replace
  :s/old/new/g = changes all "old" to "new" in that line

  :#,#s/old/new/g = "#,#' defines line ranges to find and replace text

  :%s/old/new/gc = find every occurence in the whole file with prompt


