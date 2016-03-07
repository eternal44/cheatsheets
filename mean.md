ng-bind has one-way data binding ($scope --> view). It has a shortcut {{
val }} which displays the scope value $scope.val inserted into html
where val is a variable name.

ng-model is intended to be put inside of form elements and has two-way
data binding ($scope --> view and view --> $scope) e.g. <input
ng-model="val"/>.


###########
# ROUTING #
###########

Use 'Express' & 'Angular' to handle routing from servier & client sides

Express - serves up static pages and UI-view partials (index.html), images, js / css, and exposes
REST api's

Angular - interacts with that api to get data from Mongo

###########
# FILE IO #
###########

# module.exports vs exports
  default to 'module.exports'. It can export functions and values more
  dynamically than 'exports'.  'exports' will not export everything like
  'module.exports' will.

  still not sure what the big difference is though.


# require
This is for requiring files.  Note the extra './'
```js
var config = require('./config')
```

Do './[file name/' to require whole folders

This is for requiring modules (like 'fs', 'mongoose', etc.).
```js
var mongoose = require('mongoose')
```


# NEW NOTES #
############
# MONGO DB #
############
Document oriented DB vs Relational DB

Can use a schema to give document objects structure

###########
# EXPRESS #
###########
# rendering views
1. app.render() - render the view and then pass the HTML to a callback
   function.  Use this to output the HTML.

2. res.render() - render the view locally & send the HTML as a response.
   This is normally used and is for rendering the HTML

# res vs req
res - 'response': return something to client? STDOUT?
req - 'request': request something from client? STDIN?


Connect module - delivers a set of wrappers around the NodeJS low-level
APIs to enable the development of rich web application frameworks.
  KEY:  Connect middleware is basically a bunch of callback functiosn
        which get executed when a HTTP request occurs.Th middleware can then
        perform some logic, return a response, or call the next registered
        middleware.  Can write your own but also comes with it's own.

Express is based on Connect's middleware approach and is a NodeJS
framework.

CommonJS - project with a goal of specifying an ecosystem for JS outside of the
browser (like the server)

# Design Patterns:
Horizontal project structure - based around functional role (rails)
Vertical project structure - based on feature (job couch)

app folder - where we'll keep our Express application logic and is
divided into the following folders that represent a separation of
functionality to comply with the MVC pattern:

  controllers - contains Express application controllers
  models - contains Express application models
  routes - contains Express application routing middleware
  views - contains Express application views

config folder - where we'll keep our Express application
configuration files.

  env - contains Express application environment configuration files
  config.js file - contains configuration code of our Express application
  express.js file - contains initialization code of our Express
  application

# 'module' vs 'export'
'module' is just a plain JS objct with an exports property.
'exports' is a plain JS variable that happens to be set to 'module.exports'
at the end of the file nodeJS will return 'module.exports' to the requre function.

################
# JS CALLBACKS #
################
source: http://stackoverflow.com/questions/9596276/how-to-explain-callbacks-in-plain-english-how-are-they-different-from-calling-o

BLOCKING EXAMPLE
  fileObject = open(file)
  # now that we have WAITED for the file to open, we can write to it
  fileObject.write("We are writing to the file.")
  # now we can continue doing the other, totally unrelated things our program does

  Here, we WAIT for the file to open, before we write to it. This "blocks"
  the flow of execution, and our program cannot do any of the other things
  it might need to do! What if we could do this instead:

NONBLOCKING EXAMPLE
  # we pass writeToFile (A CALLBACK FUNCTION!) to the open function
  fileObject = open(file, writeToFile)
  # execution continues flowing -- we don't wait for the file to be opened
  # ONCE the file is opened we write to it, but while we wait WE CAN DO OTHER THINGS!

source: https://www.youtube.com/watch?v=8aGhZQkoFbQ
1.) code is run
2.) gets put on to the call stack
3.) can get delegated to a web API
4.) gets cued in the callback queue
5.) event loop starts executing code from the callback queue once call
stack is empty
6.) render que - is another cue to check if event handlers have been
executed (ex:  click, scroll).  However, if the callback cue gets
flooded ....  i don't know?

###########
# NODE JS #
###########
# MODULES - each is written in a separate file and has an isolated
scope.  This is key because otherwise scopes would get dirty every time
another module that had the same variable name was introducted.

- require() - method used to load the module into your code

- exports - object contained in each module and allows you to expose
pieces of your code when the module is loaded

- module - object originally used to provide metadata information about
the module. It also contains the pointer to an exports object as a
property

# MODULES EXAMPLE

file 'howdy.js':
```js
var message = 'Howdy';

exports.sayHello = function(){
    console.log(message);
}
```
    -or-

```js
module.exports = function() {
    var message = 'Howdy';
    console.log(message);
}
```

file 'server.js':
```js
var hello = require('hello');
hello.sayHello();
```
    -or-

```js
var hello = require('hello');
hello();
```

####################
# MONGODB COMMANDS #
####################
start mongo
$ mongod

open mongo CLI after you start mongo.  If no optional db name is
selected it'll automatically connect to the default 'test' db
$ mongo [optional db name]

switch to another db.  note:  db's are lazily created.
$ use [db name]

ls dbs
$ show dbs

show collection.  collection is like a SQL table
$ show collections

show current db
$ db

# WRITE
insert
$ db.todos.insert({"title": "Write a blog post", "user": "james"})
$ db.users.save([{ name: 'Chris' }, { name: 'Holly' }]);
$ db.users.save({ name: 'Holly' });

insert-alternative
# $ curl -X POST -H "Content-Type: application/json" -d '{"name": "Kevin", "email": "kevin@mitnick.com", "username": "Condor", "password": "AintNoBodyGotTimeForGoodPa$words!!!"}' localhost:1337/users

update. note:  use the 'upsert' flag to create document if it doesn't exist
$ db.todos.update({
        "user": "nikola"
        },
        {
            "title": "Buy Bitcoins",
            "user": "nikola"
        },
        {
            upsert: true
        }
    )

save - creates a new document even if the exact one (content wise) exists.
$ db.todos.save({"title":"Write a post", "user": "james"})

# READ
find
$ db.todos.find()

find with parameters
$ db.todos.find({"user": "james"})

find all todos that were created by either nikola *OR* josipa
$ db.todos.find({ "user": { $in: ["josipa", "nikola"] } })
    alternatate way:
$ db.todos.find( {$or: [{ "user": "nikola" }, { "user": "josipa" }] })

find all with two search parameters (created by nikola and with a
priority greater than 3)
$ db.todos.find({ "user": "nikola", "priority": { $gt: 3} })

# UPDATE
Requires:
1. selection that indicates which document to update
2. update statement
3. options object

$ db.todos.update({
  "user": "nikola" # (1)
  },
  {
    $set: { # (2)
      "title": "postpone blog post"
    }
  },
  {
    multi: true # (3)
  }
)

update-alternative:
# $ curl -X PUT -H "Content-Type: application/json" -d '{"name": "UpdatedName"}' localhost:1337/users/[_id]


# DELETE
remove all documents from todo
$ db.todos.remove()

remove only the first document from todos collection made by Nikola
$ db.todos.remove({ "user": "nikola"}, true)
  NOTE:  to remove all by Nikola just remove 'true'

remove alternative:
# $ curl -X DELETE localhost:1337/users/564a742bc8e928746cd7db70



# CONNECT TO MONBODB
$npm install mongoose --save
# if in production
mongodb://username:password@hostname:port/database

# if local
mongodb://localhost/todos

#######
# NPM #
#######
Initiate setup when making a new app
$ npm init

Instead of adding dependencies straight to 'package.json' you can
add it from the CLI:
$ npm install express --save


#########
# BOWER #
#########





















############
# BACK END #
############
# new project:
$ npm init
$ npm install express --save

# create index.html
# create package.json
# add this to server.js
var express = require('express'),
    app     = express(),
    path    = require('path');

app.get('/', function(req, res) {
  res.sendFile(path.join(__dirname + '/index.html'));
});

app.listen(1337);

console.log('Visit me at http://localhost:1337');


# start node server
$ node server.js
    or
$ nodemon server.js

# add package
# method 1
$ npm install express@~4.8.6


# using MonoDB
#start
$ sudo service mongod start
$ mongod

#stop
$ sudo service mongod stop

$ ps -edaf | grep mongo
$ kill <pid>

#restart
$ sudo service mongod restart


#mongo console
#show current db
$ db

#select db
$ use <db_name>

#list dbs
$ show databases

#CRUD
db.users.save()
db.users.find()
db.users.update()
db.users.remove()

#backend packages
- express is the Node framework.
- morgan allows us to log all requests to the console so we can see exactly what is going on.
- mongoose is the ODM we will use to communicate with our MongoDB database.
- body-parser will let us pull POST content from our HTTP request so that we can do things like create a user.
- bcrypt-nodejs will allow us to hash our passwords since it is never safe to store passwords plaintext in our databases

###########
# Angular #
###########

# Factory

when would you want to persist data in the factory instead of the db?
  ex: form value.  you can navigate away and come back later to review

# Digest Cycle




# Angular services
Used to save persistent data.  Note:  controllers SHOULD NOT store
persistent data - they are only a mechanism to connect the other parts
of our app.  Any time we switch routes or reload the page Angular cleans
up the current controller.  Services however provide a means for keeping
data around for the lifetime of an app and can be used across different
controllers in a consistent manner.
[source](http://tylermcginnis.com/angularjs-factory-vs-service-vs-provider/)

Good Summary:
1) When you’re using a Factory you create an object, add properties to
it, then return that same object. When you pass this service into your
controller, those properties on the object will now be available in that
controller through your factory.

2) When you’re using Service, it’s instantiated with the ‘new’ keyword.
Because of that, you’ll add properties to ‘this’ and the service will
return ‘this’. When you pass the service into your controller, those
properties on ‘this’ will now be available on that controller through
your service.

3) Providers are the only service you can pass into your .config()
function. Use a provider when you want to provide module-wide
configuration for your service object before making it available.

dependency injection - like packaged bits of code?

directives - like partials

# Angular modules
$location will be the module that we use to redirect users. This is how
we redirect while still using
the Angular routing mechanisms. This means that our user will be
redirected without a page refresh.

$q is the module used to return promises. It will allow us to run
functions asynchronously and return
their values when they are done processing. In the previous chapter, we
used success(), error(),
and then() to act on a promise; we will be able to use those functions
when returning a $q.

$http - references http RESTful calls

ng-token-auth:  use it for login / logout


# this vs $scope
use this instead of $scope - it allows for referencing like:

    main.myVariable

instead of just

    myVariable

# always use dots with ng-model
When using ng-model to bind a parent and child scope use the following
on both:

    ng-model = something.value

Instead of:

    ng-model = value



#######################
# SCOTCH MEAN MACHINE #
#######################
use nodemon to start server





#############
# DEV TOOLS #
#############
console
ctrl + j

general dev tool
ctrl + i

inspect element
ctrl + c

# in console
$ document
all html elements stored as properties of document?

# html element lookup
$ document.querySelector('#title')
    or
$ $('#title')

finds that DOM in our 'element' panel
$ inspect($('#title')[0])

and in reverse, if you want to play with a DOM from the 'element' panel
- click on it in the 'element' panel and in console:
$ $0

remove that item
$ $0.remove

# source panel
press `esc` to toggle console when you want to manipulate in debugger mode


##########
# JQUERY #
##########

# selectors
select element
$("[element]")

select element attribute
$("[element]").text();

change element attribute
$("[element]").text("type changes here");

selecting specific selectors
$(".container");

select direct decendants.  It won't select it's children's childrens
$("#destinations > li");

select multiple items
$(".promo, #france");

select first item
$("#destinations li:first");

select every other item
$("#destinations li:odd");


# traversing (faster than selectors)

$("#destinations").find("li");
$("#destinations").find("li").first();
$("#destinations").find("li").first().next();
$("#destinations").find("li").first().next().prev();

get parent DOM
$("#destinations").find("li").first().parent();


get children DOM
$("#destinations").children("li");

# appending to the DOM

var price = $('<p>From $399.99</p>');  < create a node
$('.vacation').append(price); < attach above node to DOM

attach above node to DOM
.append(<element>) < adds as first element in DOM
.after(<element>) < adds after the element
.prepend(<element>) < adds as last element in DOM
.before(<element>) < adds before the element

remove node
$('button').remove();


like attach methods above but reverse order
.appendTo(<element>);
.prependTo(<element>);
.insertAfter(<element>);
.insertBefore(<element>);

$price.appendTo($('.vacation'));



# event handler

$('button').on('click', function(){
  var price = $('<p>From $399.99<p>');
  $('.vacation').append(price);
  $('button').remove();
});



# this
if there are a lot of '.vacation'

$('button').on('click', function(){
  var price = $('<p>From $399.99<p>');
  < this refers to the specific '.vacation.' element we're in.
  < 'closest' will find the closest parent element
  $(this).closest.('.vacation').append(price);
  $(this).remove();
});

parent() vs closest()
parent will find ALL ancestor classes
closest will find ONE or NO ancestor classes



# data-[data name]
ex: `<li class="vacation onsale" data-price='399.99'>`

$('button').on('click', function(){
  var price = $('<p>From $399.99<p>'); < add the 2 lines below here
  $(this).closest.('.vacation').append(price);
  $(this).remove();
});

var amount = $(this).closest('.vacation').data('price');
var price = $('<p>From $' + amount + '</p>');

$('button').on('click', function(){
  var vacation = $(this).closest('.vacation');
  var amount = vacation.data('price');
  var price = $('<p>From $' + amount + '</p>');

  vacation.append(price);
  $(this).remove();
});


# event delegation
the click event will trigger on any 'button' on our page.
the code below will only trigger on 'vacation button'.

$('.vacation').on('click', 'button', function() {});

# filter
ex: `<li class="vacation onsale" data-price='399.99'>`

Finds elements with a class of vacation & onsale and add a class
$('.vacation').filter('.onsale').addClaslic('highlighted');

$('#filters').on('click', '.onsale-filter', function(){
  $('.highlighted').removeClass('highlighted');
  $('.vacation').filter('.onsale').addClass('highlighted');
});


#########
# REGEX #
#########

# []
matches a single letter
ex:  [cmf]an

Match can
Match man
Match fan
Skip dan
Skip ran
Skip pan

# [^]
does the opposite of above

# [A-Z]
matches all words that have a capital first letter

# [z]{3}
matches any word with 3 'z's in a row

# a+
matches any word with more than 1 'a'j

# a{2,4}b*c
# [a]{2}
Match aaaabcc
Match aabbbbc
Match aacc
Skip  a

# find every instance of a class in string
```
var regexp = /class="(.*?)"/g;
htmlStrings[6].match(regexp)
```

# regexp for .match() on class name in element
```
var regexp =/class="(.*?)"/g;
```


# RECURSION
```
// Here is the array we will store results in
var multiples = [];

function multiplesOf(base, i) {
  // Base case
  if (i === 0) {
  // Write the  array multiples to the console
  console.log(multiples)
  }
  // Recursive case
  else {
    multiples[i - 1] = base * i;
  // Add a recursive functionunction call
  multiplesOf(base, i -1);
  }
}

multiplesOf(3, 4);

```

# VALUES VS REFERENCES
var a = 7;
var b = 7;
a === b

var a = [1,2];
var b = [1,2];
a !== b

var a = [1,2];
b = a;
b === a; // note:  b points to the reference ID, not to 'a'
a[0] = 42;
console.log(b); // [42,2];


- LHS VS RHS
var a = 3; // a gets wiped and reassigned

var notFav = myFavNumber + 3;

example:
var val = 7;

var f = function(n) {
  n += 1;
};

f(val);

console.log(val); // 7
because `f(val)` gets passed in the VALUE of 'val', not it's reference

var arr = [1,2];

var f = function(a){
  a[0] = 'hi';
  // a = 'hi'; <- this won't change the arr above... whY???
  //           <- because 'a' used to point to the array but
                  by itself it's just a variable pointer
};

console.log(arr); // ['hi', 2];

```
RULES:
- when we assign a primitive value to a variable it holds it's value
- but when we assign an object value to a variable it holds it's
  memory address
- remember exception:  null acts as a primitive and can be considered such
- when we pass a primitive parameter to a function it passes a copy of
  the value to it.
- when we pass an object parameter to a function it passes a reference
  of the object to it.
```


#########
# MYSQL #
#########
# mysql CLI
$ mysql -u root -p
mysql> show databases;
mysql> use [table name];
mysql> show tables;

mysql-workbench


#######################
# DEPLOYMENT PITFALLS #
#######################

# hard coded assumptions
  problem: port numbers - host may have your server listen on another port
  solution: app.isten(process.env.PORT);

  problem: in app: 'localhost:3000/posts'
  solution: use relative paths '/posts'

  problem: dependencies you use aren't in your packages
  solution: use '--save';

  problem: pathing
  solution:
    ```bash
    echo PATH.///// lookup later
    ```

# failure to design a debuggable app
  ex:  if app breaks:  how do you track that bug down

  problem: no error handling.  Server will die & you won't know where
  the error occured?
    ```js
    function(err, user) {
      // if(err) console.error('this broke'); // no error handling
      res.end(user.name);
    }
    ```

    problem: db connection errors ignored

    ```js
      db.connect();
    ```

    ```js
      res.end('error aunthenticating'); // no logging
    ```
# lack of deployment automation
  take out the guess work to prop up an app.
    - install bower / npm components
    - run grunt task
    - touch a log file

  publish from source control (github to heroku);
    - Procfile

# inability to scale by (unconcious design)
  ex: don't worry too much about scaling until you get users
