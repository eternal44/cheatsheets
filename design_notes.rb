
************************
* STYLE GUIDE RUBY     *
************************
# bad
if some_condition
do_something
end

# good
do_something if some_condition

Never use unless with else. Rewrite these with the positive case first.

# bad
unless success?
  puts "failure"
else
  puts "success"
end

# good
if success?
  puts "success"
else
  puts "failure"
end

Prefer {...} over do...end for single-line blocks. Avoid using {...} for multi-line blocks (multiline chaining is always ugly). Always use do...end for "control flow" and "method definitions" (e.g. in Rakefiles and certain DSLs). Avoid do...end when chaining.

names = ["Bozhidar", "Steve", "Sarah"]

# good
names.each { |name| puts name }

# bad
names.each do |name|
  puts name
end

# good
names.select { |name| name.start_with?("S") }.map { |name| name.upcase }

# bad
names.select do |name|
  name.start_with?("S")
end.map { |name| name.upcase }

************************
* WORK FLOW FOR COMPLEX*
************************

Write what you want in the view and figure out the backend after

************************
* COMPLEX ASSOCIATIONS *
************************

STI:
class tweet
text_tweet < tweet
photo_tweet < tweet

both sub classes inherit from tweet and store data into tweet's table
  so if it's a text_tweet - it's photo_tweet data columns will be empty

  class tweet
    user_id body image_file
  end

  class text_tweet < tweet
    body
  end

  class photo_tweet < tweet
    image_file
  end

  other ex:
    think about RPG character types:  a mage will have similar data as a warrior. # check if this STI example is true


STI okay if the data in the parent class is going to be the same but each sub class acts differently

class Owner
end

class Pet
  owner_id name
end

class Cat < Pet
end

class Bird < Pet
end






*******************
* DESIGN PATTERNS *
*******************

Default file structure:
1:1:1
model:controller:test

ex:
models/group.rb
models/group/membership.rb

controllers/groups_controller.rb
controllers/groups/memberships_controller.rb
.
.
.

it doesn't have to follow this always but good to have this structure.


****************
* CONTROLLERS  *
****************

Should know what it wants but not how to get it

Roles:
Security (authenticate, authorize)
  Parsing & white listing parameters
  Loading or instantiating model
  Deciding which view to render

  Rules:
  should be short, DRY
  should provide min amount of "glue" to negotiate between requests & models
  every controller reads or changes a SINGLE model.
  even if an update involves multiple models you can manage that with nested forms or form models
  !!!! --->can build custom models to map with complex forms that don't persist in the db.

  Guard access to controller
  def note_scoped
  **note scoped
  end

  key for authorization




  ****************
  * MODELS       *
  ****************

  Roles:
  user facing:
  validation for data entered by users
  form roundtrips - if a form has invalid data the incorrect fields are highlighted & correct fields retain values
  life cycle callbacks - send email after successful submission

  Writing models:
  * use validations & call backs to clearly allow & restrict how clients of the model use any ActiveRecord methods
  * Instantiate & modify a record with any API(ex: update_attribute!, save) you need
  * Manipulating record first is put in a "dirty" phase, put through validation
  * Once it passes all checks it's committed through a single transaction


  ex1:

  class Invite < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id, :if => :accepted?
  after_save :create_membership_on_accept

  private
  def create_membership_on_accept
  if accepted? && accepted_changed?
Membership.create!(:user => user)
  end
  end
  end

  Writing user interaction without a DB
  * validation & for roundtrip
* Attribute setters that cast strings to integers, dates, etc. (everything is a string in params)
  * Language translation for model & attribute names
  * Transactional-style form submissions, where an action is only triggered once all validations pass

  ex2:

  class SignIn < PlainModel *** note "PlainModel"
  attr_accessor :email
  attr_accessor :password

  validate :validate_user_exists
  validate :validate_password_correct

  def user
  User.find_by_email(email) if email.present?
  end

  private

  def validate_user_exists
  if user.blank?
  errors.add(:user_id, 'User not found')
  end
  end

  def validate_password_correct
if user && !user.has_password?(password)
  errors.add(:password, 'Incorrect password')
  end
  end
  end


  Correlating Controller:

  class SessionsController < ApplicationController
  def new
  build_sign_in
  end

  def create
  build_sign_in
  if @sign_in.save
# remember user in cookie here
  else
  render 'new'
  end
  end

  private
  def build_sign_in
@sign_in = SignIn.new(sign_in_params)
  end

  def sign_in_params
  sign_in_params = params[:sign_in]
  sign_in_params.permit(:email, :password) if sign_in_params
  end
  end




  ********************************
  * REFACTORING BAD CONTROLLER  *
  ********************************

  Bad controller:
  class AccountsController < ApplicationController

  def merge_form
  @source_missing = false
  @target_missing = false
  end

  def do_merge
  source_id = params[:source_id]
  target_id = params[:target_id]
  if source_id.blank?
  @source_missing = true
  end
  if target_id.blank?
  @target_missing = true
  end

  if source_id.present? && target_id.present?
  source = Account.find(source_id)
target = Account.find(target_id)
  Account.transaction do
  total_credits = target.credits + source.credits
target.update_attributes!(:credits => total_credits)
  source.subscriptions.each do |subscription|
subscription.update_attributes!(:account => target)
  end
  Mailer.account_merge_notification(source, target).deliver
  source.destroy
  end
  redirect_to target
  else
  render 'merge_form'
  end
  end
  end



  Correlating bad view:
  ** see book **
  basically can't use form_for and it's cool functions
  instead had to manually build with form_tags


  Refactored controller:
  class AccountMergesController < ApplicationController
  def new
  build_merge
  end

  def create
  build_merge
  if @merge.save
  redirect_to @merge.target
  else
  render 'new'
  end
  end

  private

  def build_merge
@merge ||= AccountMerge.new(params[:merge])
  end
  end


  Refactored model:
  class AccountMerge < ActiveType::Object
  attribute :source_id, :integer
  attribute :target_id, :integer

  validates_presence_of :source_id, :target_id

  belongs_to :source, class_name: 'Account'
  belongs_to :target, class_name: 'Account'

  after_save :transfer_credits
  after_save :transfer_subscriptions
  after_save :destroy_source
  after_save :send_notification 

  private
  def transfer_credits
  total_credits = target.credits + source.credits
target.update_attributes!(:credits => total_credits)
  end

  def transfer_subscriptions
  source.subscriptions.each do |subscription|
subscription.update_attributes!(:account => target)
  end
  end

  def destroy_source
  source.destroy
  end

  def send_notification
  Mailer.account_merge_notification(source, target).deliver
  end
  end





  ****************
  * TESTING      *
  ****************

  Assertion list
  http://guides.rubyonrails.org/testing.html

Rules:
Cover as much ground as possible with unit tests
Unit tests - Move as much code from controllers & views into models & service objects.  It'll be easier to test
Integration tests - test all left over interactions on controllers & views with integrations
Every UI screen should have one integration test.  No need to test all possibilites, just one user's story
ex:  don't test for all form errors.  just do one and move on to the next

Dark House Rule:
How much testing is too much?  Too little?
You should have enough tests to "illuminate your house"
No need to blast it with a flood light
Integration tests are ambient lights that radiate through your whole house
Unit tests are spot lights that highlight certain dark corners

DRY:
  repeating tests in different tests are okay - they test different things
repeating tests is okay - clever non-repeating code should happen in the app (not here)
  some times not okay but
  when in doubt - write the test
  use routes vs the specific URL

  Test driven design:
  Before implementing a future class design "use" it with tests to see how it works.

  Legacy applications:
  write an integration test for features that are central to the app.


  Integration test
  Tests user exp flow
  tests view & controller interactions

  ex:
  If there are 2 companies ("Acme", "Madrigal")
  When I enter "Acme" in the search field
  And press "Search"
  Then I should get results for "Acme"
  And not "Madrigal"

  Unit test
  tests edge cases

  ex:
  should find companies by keyword
  should be case-insensitive
  should find companies by phrase in double quotes



  ********************
  * MODEL TESTS      *
  ********************

  What to test:
  each validation in model
  each method in model

  validation example:

  test "should not save article without title" do
  article = Article.new
  assert_not article.save, "Saved the article without a title"
  end

  class Article < ActiveRecord::Base
  validates :title, presence: true
  end


  ********************
  * FUNCTIONAL TESTS * for CONTROLLERS
  ********************

  functional test - Testing the various actions of a single controller

  What to test:
  * was the web request successful?
  * was the user redirected to the right page?
  * was the user successfully authenticated?
  * was the correct object stored in the response template?
  * was the appropriate message displayed to the user in the view


  "get" method
  note:  will probably use "get" & "post" most.  other methods not used too much

  kicks off the web request and populates the results into the response. It accepts 4 arguments:

  * The action of the controller you are requesting. This can be in the form of a string or a symbol.
  * An optional hash of request parameters to pass into the action (eg. query string parameters or article variables).
  * An optional hash of session variables to pass along with the request.
  * An optional hash of flash values.

  sessions example:
  get(:show, {'id' => "12"}, {'user_id' => 5})

  failed session example:
  get(:view, {'id' => '12'}, nil, {'message' => 'booya!'})

  hashes
  note:  after a request has been made with the methods above you can use the following:

  * assigns - Any objects that are stored as instance variables in actions for use in views.
  * cookies - Any cookies that are set.
  * flash - Any objects living in the flash.
  * session - Any object living in session variables.


  note: like regular hashes, can access values by referencing the keys by string:
  flash["gordon"]               flash[:gordon]
  session["shmession"]          session[:shmession]
  cookies["are_good_for_u"]     cookies[:are_good_for_u]

# Because you can't use assigns[:something] for historical reasons:
  assigns["something"]          assigns(:something)

  layouts & templates
  explicitly call for partials in a layout

  example:

  test "new should render correct layout" do
  get :new
  assert_template layout: "layouts/application", partial: "_form"
  end


  balls out functional test:
  articles_controller_test.rb - def create

  test "should create article" do
  assert_difference('Article.count') do
  post :create, article: {title: 'Hi', body: 'This is my first article.'}
  end
assert_redirected_to article_path(assigns(:article))
  assert_equal 'Article was successfully created.', flash[:notice]
  end


views (note:  not integration test!!)

  assert_select

assert_select(selector, [equality], [message]) 

  example:
  assert_select 'title', "Welcome to Rails Testing Guide", "Welcome title not gotten"

  nested example:
  ex1:
  assert_select 'ul.navigation' do
  assert_select 'li.menu_item'
  end

  ex2:
  assert_select "ol" do |elements|
  elements.each do |element|
  assert_select element, "li", 4
  end
  end

  ex3:
  assert_select "ol" do
  assert_select "li", 8
  end



  ********************
  * INTEGRATION TEST *
  ********************
  integration tests must be created under 'test/integration' folder

  additional helpers for testing:
  http://guides.rubyonrails.org/testing.html#integration-testing


  simple example:

  require 'test_helper'

  class UserFlowsTest < ActionDispatch::IntegrationTest
  test "login and browse site" do
# login via https
  https!
  get "/login"
  assert_response :success

  post_via_redirect "/login", username: users(:david).username, password: users(:david).password
  assert_equal '/welcome', path
  assert_equal 'Welcome david!', flash[:notice]

https!(false)
  get "/articles/all"
  assert_response :success
assert assigns(:articles)
  end
  end


  multiple sessions & custom DSL:

  require 'test_helper'

  class UserFlowsTest < ActionDispatch::IntegrationTest
  test "login and browse site" do
# User david logs in
david = login(:david)
# User guest logs in
guest = login(:guest)

# Both are now available in different sessions
  assert_equal 'Welcome david!', david.flash[:notice]
  assert_equal 'Welcome guest!', guest.flash[:notice]

# User david can browse site
  david.browses_site
# User guest can browse site as well
  guest.browses_site

# Continue with other assertions
  end

  private

  module CustomDsl
  def browses_site
  get "/products/all"
  assert_response :success
assert assigns(:products)
  end
  end

def login(user)
  open_session do |sess|
  sess.extend(CustomDsl)
u = users(user)
  sess.https!
  sess.post "/login", username: u.username, password: u.password
  assert_equal '/welcome', sess.path
sess.https!(false)
  end
  end
  end


  ********************
  * SETUP & TEARDOWN *
  ********************

  Ex1:

  require 'test_helper'

  class ArticlesControllerTest < ActionController::TestCase

# called before every single test
  def setup
@article = articles(:one)
  end

# called after every single test
  def teardown
# as we are re-initializing @article before every test
# setting it to nil here is not essential but I hope
# you understand how you can use the teardown method
  @article = nil
  end

  test "should show article" do
  get :show, id: @article.id
  assert_response :success
  end

  test "should destroy article" do
  assert_difference('Article.count', -1) do
  delete :destroy, id: @article.id
  end

  assert_redirected_to articles_path
  end

  end


  Ex2:  same as Ex1 but by specifying setup callback w/ a method name as a symbol
  require 'test_helper'

  class ArticlesControllerTest < ActionController::TestCase

# called before every single test
  setup: initialize_article

# called after every single test
  def teardown
  @article = nil
  end
  .
  .
  .

  private
  def initalize_article
@article = articles(:one)
  end
  end



