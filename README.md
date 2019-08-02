# Application: Website screenshots as a service

## Summary
**Goal**<br>
Build a screenshot as a service, _i.e._ a component/service for inputting a list of URLs and being able to view or receive the image of one screenshot of a webpage located by each URL. 

The design requirements include a back-end that could be run in a datacenter.  Optionally, the service could have a front end.  Optionally, the front end could receive the list of URLs through a form or an uploaded text file.  Optionally, the front end can display the screenshots.

**Requirements**<br>
1. Input: One or many (a list of) URLs for the component/service to screenshot.
   1. Option: The list could be stored in a separate file.
   2. Option: The list could delimited by a ";".
2. Saving data: The service should store the result of the request (a collection of URLs, image files, and a request ID).  
3. Retrieving data: The user should be able to query the service for the results, and retrieve the results at any point in time.
4. Output: A single screenshot (image file) at each URL.
5. Scalability: Brief specification on how the service should be scaled to handle up to 1 000 000 screenshots per day as an enterprise infrastructure component.
   1. Option: Message queues could be used to separate the different parts of the service and prepare for scalability.
   2. Option: How long should the requested data remain (persistence)?
6. Technology: Any languages, frameworks, APIs, or databases.

## Development Flow and Build
**Minimum Viable Product (MVP)**<br>
* Scaffolding: Ruby on Rails
  * PosgreSQL database
  * Cucumber feature tests
  * Rspec unit tests
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
  I want the screen shots generated as images and stored in the database along with the request name and URLs for later recall."
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
Given my current experience and skills, I will be proceeding with Ruby on Rails.  Various ideas about technologies that are new to me, and development decisions I need to make, are listed below.

**Screenshot**<br>
An [article](https://redpanthers.co/screenshots-using-ruby/) from three years ago says that there are two Ruby gems based on `PhantomJS` called `Screencap`-[Github](https://github.com/maxwell/screencap) and `Webshot`-[Github](https://github.com/vitalie/webshot) that perform the basic functionality needed for the Screenshot Controller feature.  `Webshot` seems to be the more recent of the two and can configure the size of the captured screenshot, a waiting period between captures, and overall seems to be designed with an overall application pipeline in mind.  `Grabzit`-[Ruby Gems](https://rubygems.org/gems/grabzit) is another option for Rails -- however, it might be more bulky than necessary for this particular app.  After a brief review of available gems searchable at [Ruby Gems](https://rubygems.org/), I have found that there doesn't seem to be much evolution of these types of APIs after 2016 which makes me think that progress in this type of technology has been taken into the private domain.

Saving images in a DB is not trivial as each file can be hundreds to millions times larger than other common data types.  For example, storing the value of a Name as a _string_ is probably on the order of bytes, whereas hi-res images can easily be MB in size.  Storage capacity is not the only challenge.  DB query speed is also a concern with large files in web applications.  However, this is not a fundamentally new problem and many solutions exist.

If one were to store image files at full resolution, _as is_ so to speak, one suitable DB data format is Binary Large OBject (blob).  Alternatively, a 'thumbnail' of an image can be stored as a Byte Array (bytea) and cached for quick retrieval.<sup>[1](https://stackoverflow.com/questions/54500/storing-images-in-postgresql)</sup>  In this application, a PostgreSQL DB is used because is compatible with the bytea data format<sup>[2](https://www.postgresql.org/docs/9.1/datatype-binary.html), [3](https://edgeguides.rubyonrails.org/active_record_postgresql.html)</sup>, so I will be trying this second option.

**Parser**<br>
May or may not need gems.  Need to experiment.

**Message Queues**<br>
[Sidekiq?](https://sidekiq.org/products/pro.html)





