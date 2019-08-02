# Application: Website screenshots as a service

## Summary
**Goal**<br>
Build a screenshot as a service, _i.e._ a component/service for inputting as list of URLs and receiving one screenshot for each URL. 

Design includes as a back-end that could be run in a datacenter.  Optionally, the service could have a front end.  Optionally, the front end could receive the list of URLs through a form or an uploaded text file.  Optionally, the front end can display the screenshots.

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
    * Add Jobs controller: 'create' method to create a job with given URLs.
    * Add Job model: request name (string), URLs (string array).
* Feature:<br>
  ```
  "As a user,
  In order to have the requested screen shots processed,
  I want the screen shots generated as images and stored in the database along with the job name and URLs for later recall."
  ```
    * Add screenshot gem of choice.
    * Add new data association to Job model for generated images (bytea), generate migration for new DB column.
* Feature:<br>
  ```
  "As a user,
  In order to see the result of a past request,
  I want the screen shots generated as images and stored in the database along with the job name and URLs for later recall."
  ```
    * Add method to 'show' URLs and images and/or image file names from a given Job.

**Additional Features Back End**
* Feature: Message Queues
  * Need to research about message queue problems and solutions.
* Feature: Persistence
  * Set a time

**Additional Features Front End**
* Feature: Input URLs
  * Add view with form that receives a string of delimited URLs
* Feature: Show job
  * Add view that receives a job query and returns URLs and screenshots

## Thoughts, Questions, Ideas, and Research
Given my current experience and skills, I will be proceeding with Ruby and Rails.  Various ideas about technologies new to me, and development flow decisions, are listed below.

**Screenshot**<br>
An [article](https://redpanthers.co/screenshots-using-ruby/) from three years ago says that there are two Ruby gems based on `PhantomJS` called `Screencap`-[Github](https://github.com/maxwell/screencap) and `Webshot`-[Github](https://github.com/vitalie/webshot) that perform the basic functionality needed for the Screenshot Controller feature.  `Webshot` seems to be the more recent of the two and can configure the size of the captured screenshot.  `Grabzit`-[Ruby Gems](https://rubygems.org/gems/grabzit) is another option for Rails -- however, it might be more bulky than necessary for this particular app.  There doesn't seem to be much evolution of these types of APIs after 2016 which makes me think that progress in this type of technology has been taken into the private domain.

**Parser**<br>
May or may not need gems.  Need to experiment.

**Message Queues**<br>
[Sidekiq?](https://sidekiq.org/products/pro.html)





