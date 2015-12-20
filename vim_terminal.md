```
# LINK DOT FILES

Ex: ln -s ~/code/dotfiles/vimrc ~/.vimrc

precompile / watch SCSS file
sass --watch input.scss:output.css

############
# TERMINAL #
############


to extract
$ tar -zxvf prog-1-jan-2005.tar.gz -C /tmp

to comopress
$ tar -zcvf prog-1-jan-2005.tar.gz /tmp


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

make multipe directories under nonexistant parent file
$ mkdir -p public/todos/{controllers,views,services,config}

create mutliple files in directory
$ touch directory/{file1,file2,file3}

move multiple files into directory
$ mv -t DESTINATION file1 file2 file3

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

exclude files from grep
$ grep -inR --exclude="\bootstrap.min.css" panel* .

copy all files in subdirectory
$ cp -a /mnt/dvd/data/* /home/tom/data
$ touch {'index.html','app.js}



# tree #
exclude directory
tree -I 'node_modules'


#######
# VIM #
#######

# NERD TREE

t: Open the selected file in a new tab
i: Open the selected file in a horizontal split window
s: Open the selected file in a vertical split window
I: Toggle hidden files
m: Show the NERD Tree menu
R: Refresh the tree, useful if files change outside of Vim
?: Toggle NERD Tree's quick help


Search & replace
  :s/old/new/g = changes all "old" to "new" in that line

  :#,#s/old/new/g = "#,#' defines line ranges to find and replace text

  :%s/old/new/gc = find every occurence in the whole file with prompt

#######
# GIT #
#######
$ git type [sha]
shows type of sha

$ git dump [sha]
- dumps meta data bout the sha
- if the sha points to a specific file it'll dump the file

$ git mv
use instead of just `mv`

$ git tag [tag_name]
tags current sha with tag name

$ git tag -d oops
drops tag name

$ git reset HEAD hello.rb
unstages files from staging area.  Same as below?

$ git reset [sha]
resets all branches to that hash.

$ git co -- hello.rb
simply unstages it

$ git reset --hard
undoes working directory and?  How is this different from
  `git reset HEAD hello.rb`?

$ git revert [sha]
$ git revert HEAD
reverts/undoes commit

$ git reset --hard v1
resets git history to that tag.  should work with a sha

$ git branch -a
shows all local & remote branches

$ git branch --track greet origin/greet
track remote branch called greet in local repo

# merging
when upstream repo has changes and you're in your local repo :
$ git fetch   > upstream's history will show in your local git history as 'upstream/master'
x - can i checkout upstream sha's? 
$ git merge upstream/master    > merges upstream's changes

