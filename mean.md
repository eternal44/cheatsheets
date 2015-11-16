TODO:  figure out what the diff is for:
- exports
- module.exports
play with the simple example we made just now

# NEW NOTES #
############
# MONGO DB #
############
Document oriented DB vs Relational DB

###########
# EXPRESS #
###########
# rendering views
1. app.render() - render the view and then pass the HTML to a callback
   function.  Us this to output the HTML.

2. res.render() - render the view locally & send the HTML as a response.
   This is normally used and is for rendering the HTML


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

# WRITE
insert
$ db.todos.insert({"title": "Write a blog post", "user": "james"})

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

# DELETE
remove all documents from todo
$ db.todos.remove()

remove only the first document from todos collection made by Nikola
$ db.todos.remove({ "user": "nikola"}, true)
  NOTE:  to remove all by Nikola just remove 'true'

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





















#############
# OLD NOTES #
#############

##############
# JAVASCRIPT #
##############
# always use semicolon after each statement
Statement - think of "if" or "loop" statements
Expression - x = 3

# precedence from lowest to highest
    ||
    &&
    comparison operators (>, ==, etc.)
    all others

# debug
# in JS file type:
  console.debug(data)

# go to webdev page and click on console.  All values for 'data' will be dumped here

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

# Angular services
- Service: The simplest type. Services are instantiated with the new keyword. You have the ability to add properties to a service and call those properties from within your controllers.
- Factory: The most popular type. In a Factory, you create an object, add properties to that object, and then return it. Your properties and functions will be available in your controllers.
- Provider: Providers are the most complex of the services. They are the only service that can be passed into the config() function to declare application-wide settings


Service - responsible for grabbing data from an API
Controller - responsible for facilitating data for view
databindig - whatever is binded in model is bound in views
  and vice versa

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



