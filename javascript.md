###############
# Random bits #
###############

# Evaluating RHS
> an assignment can be an expression that represents a value
var i = 7;
i = i + 1;

> Same as i = i + 1;
i += 1;

> Evaluates 'i' and then increments by '1' ('evaluates' === 'return'?);
i++;

> increments by '1' and evaluates 'i' ('evaluates' === 'return'?);
++i
(i + 1);

# loop semantics
for (var i = 0; i< arr.length; i++){
  if(arr[i].type !== english){
    continue; // goes to next loop - for readability
  }
  // do something
}


for (var i = 0; i< arr.length; i++){
  if(arr[i].type !== english){
    break; // stops loop but doesn't return from the function this loop might be in
  }
  // do something
}




#################
# 4 cores to JS #
#################
Async code execution - read kyle simpson's book


########
# NODE #
########
module.exports = obj

exports.func = func;


#######
# ES6 #
#######

npm install -g bable ?
babel src --watch --out-dir es6

# activate on chrome
chrome://flags/#enable-javascript-harmony

####################
# EVENTING SYSTEMS #
####################
// learn this.  GOod for understanding and may come up on interviews

var addEventSystem = function(target) {
  target.reactionsTo = {};
  target.on = function(e, cb){
    this.reactionsTo[e] = this.reactionsTo[e] || [];
    this.reactionsTo[e].push(cb);
  };
  target.trigger = function(e){
    _.each(this.reactionsTo[e], function(cb){
      cb();
    });
  };
};

##############
# CALL STACK #
##############
# keeps track of:
where have i been
what was the state of the program I left it in?

# what does this return?
* always know what something returns

outcomes = [];
return outcomes.push(playedSoFar); // this doesn't return anything -
  just terminates the block to go to the next item in the stack



############
# N QUEENS #
############
//backbone board initializer method
var board = new Board({n: 8});

########################
# CHALLENGE REFERENCES #
########################
challenge.makerpass.com
checkpoint.makerpass.com
authorize.makerpass.com?

Array.prototype.slice.call(arguments)
Dancer.apply(this, arguments);

# undefined Vs null
undefined - for variables, properties, and methods
null - for objects
  but to be null, remember an object has to atleast be defined first

###################
# HANDY FUNCTIONS #
###################

# range = Array.apply(null, Array(1000)).map(function (_, i) {return i;});

##############
# RECURSION #
##############
Recursions are prettier than writing loops but are much slower and more
costly.

# better example (good example of recursion)
# CALL #

```js
var uniqueInOrder = function (iterable)
{
  // observe how they use 'call' on filter.  It's being called on a
string
  return [].filter.call(iterable, (function (a, i) {
    return iterable[i - 1] !== a;
  }));
};

console.log(uniqueInOrder('AAAABBBCCDAABBB'));
```

################
# CONSTRUCTORS #
################

/*
 * ##########################
 * # FUNCTIONAL CONSTRUCTOR #
 * ##########################
 */

var Car = function(loc){
  var obj = { loc:loc};
  obj.move = function() {
    obj.loc++;
  };
  return obj;
};

var Van = function(loc) {
  var obj = Car(loc);
  obj.grab = function(){};// this method left blank.  only for demo
  return obj;
};

var Cop = function(loc) {
  var obj = Car(loc);
  obj.call = function(){}; // this method left blank.  only for demo
  return obj;
};

// // examples of how to use functional constructrs
// var ben = Van(9);
// ben.grab();
// var cal = Cop(2);
// cal.call();


/*
 * ###############################
 * # PSEUDOCLASSICAL CONSTRUCTOR #
 * ###############################
 */
// pseudoclassical constructor
// review: slide 23
//         slide 28 - true value of 'this'
//         slide 50 - instance similarity code VS instance differntiation code?
//         slide 71 & 72 - what's going on at the top?
var Car = function(loc){
  // after we declare this function:  it creates an object here
  // x - figure out how this is different from functional constructors where
  //  we need to declare an object literal
  this.loc = loc;
};

Car.prototype.move = function(){
  this.loc++;
};

var Van = function(loc){
  // this = Object.create(Van.prototype);  // this line is autogenerated by pseudoclassical

  // Car(3) - sets 'this' to window.  Line below sets 'this' to Van:  this line decorates the Van instances
  Car.call(this, loc);
  // return this; // this line is autogenerated by pseudoclassical
};

// start with the RHS operation.
// makes a reference to the Car.prototyope and assigns it to Van.prototype
// RHS:
// {
//  __proto__ : Car.pototype
//  }
Van.prototype = Object.create(Car.prototype); // this line needs to come before the next line.
                                              // If it doesn't:  Car.prototype isn't available to Van.prototype
Van.prototype.constructor = Van;

// add a unique method to Van
Van.prototype.grab = function(){};


var audi = new Van(4);

// will return undefined because function instantiators return undefined if we don't call a specific return
var audi = Van(4);

##############
# JAVASCRIPT #
##############
# precedence from lowest to highest
    ||
    &&
    comparison operators (>, ==, etc.)
    all others

# named IIFE
```
var a = 2;

(function IIFE( global ){

    var a = 3;
    console.log( a ); // 3
    console.log( global.a ); // 2

})( window ); <- passing in an argument!

console.log( a ); // 2
```

##################
# CLASS / OBJECT #
##################
only difference with decorator is:  it CREATES the obj instead of auging it


#############
# DECORATOR #
#############

var flies = function(obj){
  var fly = function() {
    console.log("Flap, flap");
  };
  obj.numWings = 2; // even though 'numWings' doesn't exist it'll create it
  obj.fly = fly;
  console.log(chris === obj); // returns 'true' because it runs after obj gets assigned to chris @ `chris = flies(chris);
  return obj;
};

var chris = {};
console.log('before: ', chris);

// RHS gets executed first.  LHS is simply a memory address - no need to
// worry it's state or what it currently stores.
chris = flies(chris);
console.log('after: ', chris);
chris.fly();


#################
# HASH FUNCTION #
#################
insert, update, remove - fastest with hash

1 - hash value is fully determined by the data being used
2 - the hash function uses all of the input data
3 - the has funciton 'uniformly' distributes the data scross the entire set
    of possible hash values.

# hashing strategies
open addressing - if the target address is occupied will traverse the
  array to the next available open address
  * on lookup: it'll keep traversing until it finds the requested key.
    - it'll happen in constant + n.  however:  n is only for a small
      portion of the array

linked list addressing - if the target address is occupied:  will add
  the object as a tail node to the existing list
  * keep resizing to about 3~4 nodes deep


# resizing
the hash table function needs to reorganize all of the existing keys
before adding additional keys.


hashKey function
relative O(n) - this is going to be a lot less than the count of
  elements in our hash.
  ex:  - 'n' of 4 elements in a name is relatively smaller than 'n' of 5
       billion names in a phone book
       - so even though we have '2n', since hashKey is not going to
         affect the order of magnitude we simply say 'n'.
       *** remember about relative 'n'

amortized O(n) - as the table continues to grow it won't need to
  redistribute the keys to the list as often


#########################
# CODING BEST PRACTICES #
#########################

Seperation of concerns
# modular - things that should be together are put together
# isolation / decoupling - opposite of above

# thin interfaces (APIs)
# abstractions
  ex:  using higher-level constructs / definitions
  * you can potentially abstract too much.  be sure to balance it out.
    Too much abstraction can be bad (ex:  6 functions are too much)
  * trades complexity / control  for usability


###########################
# Common problem pitfalls #
###########################

# Read and reread the READMEs
# think about the intentions
  - what is the intent of the README

# Don't confuse data structures
# Try to write a few simple test cases for your code


##############
# ALGORITHMS #
##############
Algorithms is a set.  Funciton / script is a subset of algorithms

Def'n - step by step solution to a generic problem

# Rules:
1) Establish the rules of the problem (inputs, outputs, constraints)
 - writing code is the LAST thing I should do.
 - define the inputs and outputs
   (ex:  to make a PBJ sandwich:
    inputs:  peanut butter, jelly, bread
    output:  PBJ sandwich
 - carefully establish the constraints of the problem
    what type of inputs do we have: (type of bread? smooth or crunchy
    peanut butter)
 * clarify the parameters of the problem

2) TDD - start with the most generic assumptions:
 * is it a function?
 * expect a general return

3) explore the problem space and discover techniques
  - consider edge cases (any surprising or unlikely situations)
  - identify archetypes and common patters

4) generate a simple plan that should solve the problem
 - YOU MUST be able to articulate the solution to a problem in plain
   language and come up with a plan before you even start trying to code

5.) elaborate the plan into steps
  Pseudo code
    - start with instructions in plain english. indentation to signify
      suboordnation

6.)  Veryify each step in the proccess manually
  the chance that I write a thorough pseudo code the first time is rare.

7.) Debug your algorithm first
  if your pseudocode is thorough - writing a solution with code for the problem is trivial.

###############
# OPEN SOURCE #
###############
- always follow the code conventions of the repo in question
- always follow the commit message conventions of the repo in question
- changes should be contained within a single commit
- well written merge comment will ALWAYS make or break your PR
  * be clear about what you've changed and why it's an improvement
  * make your change as easy as possible to understand
  * include images - to give them an easy look at your changes
  * assuage potential fears explicitly - describe how your PR won't
    break their code

#################
# FOR VS FOR IN #
#################
'for' is faster

'for in' - order of keys returned is not gauranteed
  this is when we get to millions of keys though

'for in' loop will skip empty indexes in an array
'for' loop will not
  ex: [1,2, ,3]

#############
# FUNCTIONS #
#############
* say "invoke" a function instead of "call"

                parameter list
                     |
var fun = function(input){
  console.log(input);
}

argument list
      |
fun('hi')


# scope
execution scope: in-memory scope (aka: execution context);
lexical scope: ex: variable access in a nested function

function scope vs blocking scope:
                  --------
                  ex:
                  if...
                  while...
                  for...
