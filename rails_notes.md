*************
* ruby code *
*************

******************
* PHILOSOPHY     *
******************
"It is confusing to me to even think about methods returning objects unless you are using that as a very specific shorthand for saying that methods return *references* to objects. That is the unifying idea that helped me understand how Ruby manipulates data -- it is all references and not the objects themselves. The objects themselves are almost completely hidden from the programmer (excluding C extensions) in Ruby. Everything is a reference to an object."



@variable ||= "default value"
  same thing as:
    @variable = @variable || "default value"

  sets a value only if it hasn't already been set


if a = f(x) and b = f(y) and c = f(z) then d = g(a,b,c) end
  * values will keep getting set until it reaches a false value
  * this wouldn't be possible if I used '&&' instead of 'and'


puts `ls`
  * enters this into terminal where my program is

system("tar xzf test.tgz)
  * same as above but using kernel's system method

***************
* ASSIGNMENTS *
***************
x,y = y,x
  will exchange values

*************
* BANGS     *
*************

*************
* ARRAY     *
*************


class & modules are constants so they start with an upper case letter


****************
* METHOD       * - for local variables just set to new name or symbol
****************

* alias will retain it's form even after the original method gets changed

  def oldmtd
    "old method"
  end
  alias newmtd oldmtd
  def oldmtd
    "changes"
  end


***********
* IRB HELP*
***********
http://www.caliban.org/ruby/rubyguide.shtml

** HELP **
ri Hash
ri 'Array#<<'

debug
benchmark
profile = kind of like benchmark?
test

Organize:
  * invoke script with:
    #!/usr/bin/ruby -w

  * header block with:
      author's name
      perforce tag id
      brief description of program

  * require statements
  * include statements
  * class & module definitions
  * main program section
  * testing code

  * exceptions
      make sure script closes with something like this:

      begin
      file = open("/tmp/some_file", "w")
        # do stuff here
      ensure
        file.close
      end


spacing
  * default parameters
    def foo(a, b=0, c="zip") <- notice no space between equal sign
      ...
    end
  * initialisation
    foo = {}
    foo = Hash.new <- this is better because you can initialize with default values

  * line length
    80 characters max.  if you need to break line use:  \

  * blank lines
    2 blank lines between clas & module definitions
    1 blank line between each method definition

  * white space
    foo = 1
      not: foo=1

    def foo(bar, baz=0)
      not: def foo(bar, baz = 0)

    foo.bar( baz )
      not: foo.bar(baz)

naming
  class
    use nouns
    camelcase:
      class BigFatObject

  modules
    use adjectives:
      Enumerable, Comparable

  constants
    use all caps & underscores:
      BigFatObject::MAX_SIZE

  methods
    use verbs
    lowercase & underscores:
      BIGFATOBJECT#DOWN_SIZE


