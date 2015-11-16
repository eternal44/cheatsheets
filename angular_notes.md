##########################
# STARTING A NEW PROJECT #
##########################
can usually start with ngApp but in advance (and usually rare) cases use
the imperative / manual way.

ngApp does the following:
1. The injector that will be used for dependency injection is created.

2. The injector will then create the root scope that will become the
context for the model of our application.

3. Angular will then "compile" the DOM starting at the ngApp root element,
processing any directives and bindings found along the way.

################
# CLI commands #
################

### If starting a new project
download tools with:
 $ bower install

### Issuing commands
Start local dev web server
$ npm start

start Kamra unit test runner. leave running in the background like guard
$ npm test

install drivers needed by Protractor
$ npm run update-webdriver

run Protractor end to end (E2E) tests - like my selenium integration test on rails
run before commits & testing changes that affect views
$ npm run protactor

########################
# ANGULAR STYLE GUIDES #
########################

custom attributes use: spinal-case
  corresponding directives: camelCase

double curly brackets for binding:
```
{{ }}
```
##############
# DIRECTIVES #
##############
ng-repeat
```
<html ng-app="phonecatApp">
<head>
  ...
  <script src="bower_components/angular/angular.js"></script>
  <script src="js/controllers.js"></script>
</head>
<body ng-controller="PhoneListCtrl">

// note here
  <ul>
    <li ng-repeat="phone in phones">
      <span>{{phone.name}}</span>
      <p>{{phone.snippet}}</p>
    </li>
  </ul>

</body>
</html>
```

########
# TEST #
########
unit tests - good for controllers and (?)
e2e tests - good for DOM manipulation.
