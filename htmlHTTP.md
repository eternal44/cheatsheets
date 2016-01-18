########
# HTML #
########

element - is just the 'a'
   |
  <a>
  |||
  tag - includes the surrounding brackets & includes the element

attribute - id, class, src, href, etc.


#######
# CSS #
#######
selectors - targets attribute value (ex: class, id, etc.)

# selector
   |
   p {
   # property
      |
     color: black;
              |
          # value
   }

type selectors - targest elements (ex: h1)
----
class
id


###############
# REST & HTTP #
###############
REST:  a simple way to organize interactions between independent systems
HTTP:  protocol that allows for sending documents back and forth on the
       web

## HTTP - General concept
* roles: server & client
  client always initiates the conversation & server replies

* made of a header and body
  body - contains the data in order to use it according to the
         instructions in the header
       - need to specify the content type (ex:  Content/Type: application/json)

  header - contains metadata (ex: encoding info) but in the case of a
           request it also contains the HTTP methods.  In REST - header
           data is more significant than the body


## HTTP VERBS
GET     /blog-posts     - Get a list of blog posts
POST    /blog-posts     - Create a new blog post
GET     /blog-posts/1   - Get the blog post with id=1
PUT     /blog-posts/1   - Update blog post with id=1
DELETE  /blog-posts/1   - Delete blog post with id=1
