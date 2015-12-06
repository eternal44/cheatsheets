// kata
var bowlingScore = function(rolls) {
  var score = 0, i = 0, frame = 1;
  while(frame <= 10) {
    score += rolls[i] + rolls[i+1];
    if(rolls[i] + rolls[i+1] >= 10) score += rolls[i+2];
    if(rolls[i] !== 10) i++;
    i++;
    frame++;
  }
  return score;
};

console.log(bowlingScore([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]) );
console.log(bowlingScore([9,1, 9,1, 9,1, 9,1, 9,1, 9,1, 9,1, 9,1, 9,1, 9,1, 9]) );
console.log(bowlingScore([10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]) );
console.log(bowlingScore([0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 10,1,0]) );
console.log(bowlingScore([0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 10, 1,0]) );

// console.log( 0 == bowlingScore([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]) );
// console.log( 190 == bowlingScore([9,1, 9,1, 9,1, 9,1, 9,1, 9,1, 9,1, 9,1, 9,1, 9,1, 9]) );
// console.log( 300 == bowlingScore([10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]) );
// console.log( 11 == bowlingScore([0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 10,1,0]) );
// console.log( 12 == bowlingScore([0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 10, 1,0]) );





# Higher-order functions

Functions that operate on other functions, either by taking them as
arguments or by returning them, are called higher-order functions.

# Named functions
Good for recursions

# Anonymous functions
- Chaining functions?
- Higher order call backs

# Function declarations VS function expressions
```js
  // function declaration
  var foo = function() return 'hi there'
```

```js
  // function expression
  function foo () return 'hi there'
```

# function ouput:  side effect Vs value
side effect:  console.log
value ex: return





###################
# HANDY FUNCTIONS #
###################

# range = Array.apply(null, Array(1000)).map(function (_, i) {return i;});

# reduce 

```js
console.log(ancestry.reduce(function(min, cur) {
  if (cur.born < min.born) return cur;
  else return min;
}));
// → {name: "Pauwels van Haverbeke", born: 1535, …}
```




########
# JSON #
########

JSON.stringify - converts value -> JSON-encoded string
JSON.parse - converts JSON-encoded string -> value
it encodes

#############
# FUNCTIONS #
#############

# function declarations #
can be called from even BEFORE their location.
  ex:
  ```js
    console.log("The future says:", future());

    function future() {
      return "We STILL have no flying cars.";
    }
  ```
but don't nest them in an 'if' or 'loop' statement - may cause problems
with other versions of JS.

# pure function
a function that doesn't affect the original object
  ex:  map

###########
# METHODS #
###########

Properties that contain functions are generally called methods

###########
# CLOSURE #
###########

When assigning 'twice' as a variable of 'multiplier(2)' - imagine
"freezing" the code in it's body and wrapping it into a package.  That
way you can pass it more arguments like it does with 'twice(3)'


```js
function multiplier(factor) {
  return function(number) {
    return number * factor;
  };
}

var twice = multiplier(2);
console.log(twice(3));
// console.log(twice(5));
// → 10
```


##############
# RECURSION #
##############
Recursions are prettier than writing loops but are much slower and more
costly.


# simple example (you wouldn't use recursion for this)
```js
function power(base, exponent) {
  if (exponent == 0)
    return 1;
  else
    return base * power(base, exponent - 1);
}

console.log(power(2, 3));
// → 8
```

# better example (good example of recursion)
```js
function findSolution(target) {
  function find(start, history) {
    if (start == target)
      return history;
    else if (start > target)
      return null;
    else
      return find(start + 5, "(" + history + " + 5)") ||
             find(start * 3, "(" + history + " * 3)");
  }
  return find(1, "1");
}

console.log(findSolution(24));
// → (((1 * 3) + 5) * 3)
```

// this is how the recurssion above works.  Indentations describe how
deep into the call stack the function is:

```js
find(1, "1")
  find(6, "(1 + 5)")
    find(11, "((1 + 5) + 5)")
      find(16, "(((1 + 5) + 5) + 5)")
        too big
      find(33, "(((1 + 5) + 5) * 3)")
        too big
    find(18, "((1 + 5) * 3)")
      too big
  find(3, "(1 * 3)")
    find(8, "((1 * 3) + 5)")
      find(13, "(((1 * 3) + 5) + 5)")
        found!
```

# 2 basic types:  side-effect generating(ex: console.log) VS value returning (... return)

#############
# OPERATORS #
#############


# Unary operators #
+, -, /, etc.

# Binary operators #
From highest to lowest priority

all others
comparison( <,>, ==, etc.)
&&
||

Example:
  > 1 + 1 == 2 && 10 * 10 > 50

  2 == 2 && 100 > 50
  true && true
  true

# Ternary operators #
> true ? 1 : 2

# Undefined Operators #
'null' & 'undefined' are usually the same / interchangeable

# Short Circuiting of Logical Operators
' || '
If the LEFT SIDE is false it defaults to whatever is on the right side.

' && '
If the RIGHT SIDE is true it defaults to whatever is on the right side


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
#########
# LOOPS #
#########

# do loop #
do {
  var yourName = prompt("Who are you?");
} while (!yourName);
console.log(yourName

# breaking a loop #
for (var current = 20; ; current++) {
  if (current % 7 == 0)
    break;
}
console.log(current);



################
# CONSTRUCTORS #
################

Starts with a capital letter.
  ex: Number();
