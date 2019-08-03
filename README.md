# Full Stack Application: Capture and store website screenshots as a service

## Executive Summary
Approximately 25 hours over two and a half days.  This was a fun ride!

**Goal**<br>
Build a screenshot as a service, _i.e._ a component/service for inputting a list of URLs and being able to view or receive the image of one screenshot of a webpage located by each URL. The design requirements include a back-end that could be run in a datacenter.  

This project is a proof-of-concept prototype.  Please see the flow diagrams below for the current configuration, and possibilities for scaling to production for 1,000,000 screenshot captures per day.



## Local Build
If you want to build this project locally, fork it to your own Github repository and clone to a local workspace.  Don't forget to `bundle install` and `rails db:create db:migrate`.  Please use the following installation instructions to install apps that are not already installed on your terminal.
1. The latest version of Ruby 2.6.3 and Ruby on Rails 5.2.3 are used here.
```
# install Ruby
$ gem install ruby

# install Ruby on Rails
$ gem install rails -v 2.6.3
```
2. Phantomjs & GraphicsMagick are required to enable the Webshot gem that is used for screenshot capture.
```
# install phantomjs on Mac OS with Homebrew
$ brew tap homebrew/cask
$ brew cask install phantomjs

# install graphicsmagick on Mac OS with Homebrew
$ brew install graphicsmagick
```
## Development Flow 
The items listed here are the requirements for the prototype.

**Requirements**<br>
1. Input: One or many (a list of) URLs for the component/service to screenshot.
   1. Option: The list could be stored in a separate file.
   2. Option: The list could delimited by a ";".
2. Saving data: The service should store the result of the request (a collection of URLs, image files, and a request ID).  
3. Retrieving data: The user should be able to query the service for the results, and retrieve the results at any point in time.
4. Output: A single screenshot (image file) at each URL.
5. Scalability: Brief specification on how the service should be scaled to handle up to 1,000,000 screenshots per day as an enterprise infrastructure component.
   1. Option: Message queues could be used to separate the different parts of the service and prepare for scalability.
   2. Option: How long should the requested data remain (persistence)?
6. Technology: Any languages, frameworks, APIs, or databases.

I extracted the core functionality of each requirement and developed a Minimum Viable Product goal using User Stories.  There is some, but not substantial, deviation from this plan throughout the development process as I wrote this sketch in the beginning of the project to get my bearings.  However, as I learned about new technologies and unexpected errors, I adapted the plan to constantly move in the direction of added value.

**Minimum Viable Product**<br>
* Scaffolding: Ruby on Rails
  * PosgreSQL database
  * Cucumber feature tests
  * Rspec unit tests

      A note on testing: unit tests on the models can be run with the command `rspec` and feature tests for the front end can be run using the command `cucumber`.  I work to adhere to BDD and TDD practices and setup a feature test in a new branch at the beginning of development for each feature.  In the last feature `04_show_past_request`, I ran into a confounding bug I believe emerged from an unexpected interaction between the Webshot gem browser and the rails test server, causing all my feature tests to go haywire after clicking Submit Request.  This ultimately did not affect the functionality of the app and was only present during the feature test process.  You may run feature tests at your own risk.

* Feature:<br>
  ```
  "As a user,
  In order to submit a screen shot request,
  I want a to specify request name to identify the request, and URLs to specify the needed screenshots."
  ```
    * Generate Screenshotreqs controller.
    * Add 'new' view with Submit Request form containing a Name field and URL field.
    * Add Screenshotreq model: request name (string), URLs (text).  Unit test.
    * Add 'create' and 'new' methods to create and store a request with associated URLs.  URLs are processed from an input string to a string array.
* Feature:<br>
  ```
  "As a user,
  In order to have the requested screenshots processed,
  I want the screenshots generated as images and stored in the database along with the request name and URLs for later recall."
  ```
    * Add screenshot gem of choice.
    * Add screenshot gem function to 'create' method to generate and store images from URL string array.
    * Add new data association to Screenshotreq model for generated images (bytea), unit test, generate migration for new DB column.
* Feature:<br>
  ```
  "As a user,
  In order to see the result of a past request,
  I want the generate screen shots and their corresponding URLs on a page."
  ```
    * Add Find request form to 'index' view.
    * Add 'show' method to show URLs and images and/or image file names from a given request.

**Additional Features Back End**
* Feature: Message Queues
  * Need to research about message queue problems and solutions.
* Feature: Persistence
  * Set a time that data in the DB will be erased after non-use.

**Additional Features Front End**
* Feature: Input URLs
  * Add view with form that receives a string of delimited URLs
* Feature: Show request
  * Add view that receives a request query and returns URLs and screenshots

## Thoughts, Questions, Ideas, and Research
Day 1<br>
Given my current experience and skills, I will be proceeding with Ruby on Rails.  Various ideas about technologies that are new to me, and development decisions I need to make, are listed below.

**Screenshot**<br>
Day 1<br>
An [article](https://redpanthers.co/screenshots-using-ruby/) from three years ago says that there are two Ruby gems based on `PhantomJS` called `Screencap`-[Github](https://github.com/maxwell/screencap) and `Webshot`-[Github](https://github.com/vitalie/webshot) that perform the basic functionality needed for the Screenshot Controller feature.  `Webshot` seems to be the more recent of the two and can configure the size of the captured screenshot, a waiting period between captures, and overall seems to be designed with an overall application pipeline in mind.  `Grabzit`-[Ruby Gems](https://rubygems.org/gems/grabzit) is another option for Rails -- however, it might be more bulky than necessary for this particular app.  After a brief review of available gems searchable at [Ruby Gems](https://rubygems.org/), I have found that there doesn't seem to be much evolution of these types of APIs after 2016 which makes me think that progress in this type of technology has been taken into the private domain.

Saving images in a DB is not trivial as each file can be hundreds to millions times larger than other common data types.  For example, storing the value of a Name as a _string_ is probably on the order of bytes, whereas hi-res images can easily be MB in size.  Storage capacity is not the only challenge.  DB query speed is also a concern with large files in web applications.  However, this is not a fundamentally new problem and many solutions exist.

If one were to store image files at full resolution, _as is_ so to speak, one suitable DB data format is Binary Large OBject (blob).  Alternatively, a 'thumbnail' of an image can be stored as a Byte Array (bytea) and cached for quick retrieval.<sup>[1](https://stackoverflow.com/questions/54500/storing-images-in-postgresql)</sup>  In this application, a PostgreSQL DB is used because is compatible with the bytea data format<sup>[2](https://www.postgresql.org/docs/9.1/datatype-binary.html), [3](https://edgeguides.rubyonrails.org/active_record_postgresql.html)</sup>, so I will be trying this second option.

Day 2<br>
After considering the question of where and how the screenshots will be stored further, I have decided that that it is more efficient (at this small scale) to store the generated image files in a “file system” configuration, i.e. a local folder.   When recalled later in a Screenshot Request query, the images can be reference by file name.  There seems to be little benefit in trying to store the images in the DB for now.  

This does mean, however, that the relative image file paths must be stored somewhere.  This storage location will be a column associated with the Screenshot that stores a string per url containing the paths for a given request.

**Parser**<br>
Day 1<br>
May or may not need gems.  Need to experiment.

Day 2<br>
Configured parser with a few lines of code.

**Message Queues**<br>
[Sidekiq?](https://sidekiq.org/products/pro.html)





