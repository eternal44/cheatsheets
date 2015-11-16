checkboxes
http://www.sitepoint.com/save-multiple-checkbox-values-database-rails/

glgga
###################
# PUNDIT & DEVISE #
###################
follow documentation for install
rails g pundit:install
Include this in application controller:
  inlcude Pundit

Options:
Make sure each action is authorized
  after_action :verify_authorized

authorize under set_object for 

w/ devise:
  if after_action :verify_authorized, unless: :devise_controller?

  in job_policy.rb.  example code:

  def show?
    user.present? && user == record.user
  end

  def job
    record
  end

  in user.rb

  def admin?
    role == 'Admin'
  end

  can now add this to job_policy to test true or false on policies


################
# MAKE GEMS    #
################
gem build <filename>.gempsec

gem install ./<filename>-0.0.0.gem

curl -u jyoun44 https://rubygems.org/api/v1/api_key.yaml >~/.gem/credentials; chmod 0600 ~/.gem/credentials
# if in a new environment add api_key.hml to ~/.gem/credentials

gem push <gemname>-0.0.0.gem

IN DEVELOPMENT:
Before releasing new gem developments:

bump version:
  ..../version.rb

Release
$ bundle exec rake release

https://quickleft.com/blog/engineering-lunch-series-step-by-step-guide-to-building-your-first-ruby-gem/
################
# Git commands #
################

# Work flow models:
  Fork & Pull Model
    For the origin
    make a branch
    add commits
    then pull to review code w/ the code reviewer
    if my changes are approved i can deploy my branch in production
    if everything works in production in can merge it with master
  Shared Repository Model

git clean -df
removes all unstaged files & directories

git revert <commit>
Generate a new commit that undoes all of the changes introduced in <commit>, then apply it to the current branch.

git revert --no-commit b28d438..HEAD
git commit -m "Reverted back to b28d438"
if you really mess up with commits do this to undo :)

##############
# DEF'N #
##############

################
# Git / Heroku #
################


$ heroko run console --sandbox

/# when you're on master #/
heroku pg:reset DATABASE
heroku run rake db:migrate
heroku run rake db:seed

# if the css or styling doesn't match with the local host:
bundle exec rake assets:precompile

# set access keys
heroku config:set [variable name]=[key] (remove brackets)

##############################
# Push commit to remote repo #
##############################



###########################
# Multiple index item edits #
###########################
http://www.ksimmons.org/edit-multiple-records-using-a-bootstrap-modal-and-ruby-on-rails

###################
# Undo migration  #
###################

$ bundle exec rake db:migrate

We can undo a single migration step using
$ bundle exec rake db:rollbac/


###########
# Testing #
###########
see for reference
  http://guides.rubyonrails.org/testing.html#unit-testing-your-models
  home/james/lab/practice/test_practice/
    integration
    controller
    model
    routes

write controller and model tests first and integration tests (which test functionality across models, views, and controllers) second

bundle exec rake test

when schema changes do this before running tests
rake db:test:prepare

debugger
add to code where you want to search params, etc.


################################
# Automated testing with Guard #
################################
known working gem combo:

rails 4.2.0

group :test do
  gem 'minitest-reporters', '1.0.5'
  gem 'mini_backtrace'
  gem 'guard-minitest',     '2.3.1'
end

$ bundle exec guard init

Change file to this:
# Defines the matching rules for Guard.
guard :minitest, spring: true, all_on_start: false do
  watch(%r{^test/(.*)/?(.*)_test\.rb$})
  watch('test/test_helper.rb') { 'test' }
  watch('config/routes.rb')    { integration_tests }
  watch(%r{^app/models/(.*?)\.rb$}) do |matches|
    "test/models/#{matches[1]}_test.rb"
  end
  watch(%r{^app/controllers/(.*?)_controller\.rb$}) do |matches|
    resource_tests(matches[1])
  end
  watch(%r{^app/views/([^/]*?)/.*\.html\.erb$}) do |matches|
    ["test/controllers/#{matches[1]}_controller_test.rb"] +
    integration_tests(matches[1])
  end
  watch(%r{^app/helpers/(.*?)_helper\.rb$}) do |matches|
    integration_tests(matches[1])
  end
  watch('app/views/layouts/application.html.erb') do
    'test/integration/site_layout_test.rb'
  end
  watch('app/helpers/sessions_helper.rb') do
    integration_tests << 'test/helpers/sessions_helper_test.rb'
  end
  watch('app/controllers/sessions_controller.rb') do
    ['test/controllers/sessions_controller_test.rb',
     'test/integration/users_login_test.rb']
  end
  watch('app/controllers/account_activations_controller.rb') do
    'test/integration/users_signup_test.rb'
  end
  watch(%r{app/views/users/*}) do
    resource_tests('users') +
    ['test/integration/microposts_interface_test.rb']
  end
end

# Returns the integration tests corresponding to the given resource.
def integration_tests(resource = :all)
  if resource == :all
    Dir["test/integration/*"]
  else
    Dir["test/integration/#{resource}_*.rb"]
  end
end

# Returns the controller tests corresponding to the given resource.
def controller_test(resource)
  "test/controllers/#{resource}_controller_test.rb"
end

# Returns all tests for the given resource.
def resource_tests(resource)
  integration_tests(resource) << controller_test(resource)
end




add to .gitignore:
# Ignore Spring files.
/spring/*.pid

$ bundle exec guard


#########
# Rails #
#########

# Configure pgres db
rails new myapp --database=postgresql

gem 'pg'

rake db:setup
rake db:migrate

annotate gem - need to instanti
#######
# DB & models #
#######

$ rails console --sandbox
#all changes wil be rolled back on exit

$ bundle exec rake db:migrate:reset
clears out all db data

    ###############
    # Definitions #
###############

_url vs _path
use "_url" for redirect
this is like http://mydomain.com

use "_path" for hyperlinks
this is like /


##########
# S3 AWS #
##########

1) Sign in to the AWS Management Console at http://aws.amazon.com/iam/

2) Click "Policies" from the Navigation Pane on the left

3) Select the "AdministratorAccess" policy

4) Click Policy Actions > Attach at the top of the page

5) Select the user associated with my S3_ACCESS_KEY, S3_SECRET_KEY, and S3_BUCKET

6) Click "Attach Policy"


References:
squat_admin
Access Key ID:
Secret Access Key:

##############
# POSTGRESQL #
# ############

http://linuxrails.blogspot.com/2012/06/postgresql-setup-for-rails-development.html


psql [table name]
opens console


hba_file path # for configuring connections
/etc/postgresql/9.1/main/pg_hba.conf


sudo /etc/init.d/postgresql restart
to restart db

rake db:create:all
creates new db's

rake db:migrate

pgadmin3
opens db viewer?

alter user username with password ‘new password’;
update password

drop database projectname;


Connect to specific database
\c databasename

Common MySQL commands with postgresql shortcut

SHOW DATABASES
\l

SHOW TABLES
\d

SHOW COLUMNS
\d table


  rake db:setup
sets db to your settings (in database.yml?)


  lift PG admin info:

  user:  jyoun
  password:  gooneen44
  table names:
  lift_developement
  lift_test

