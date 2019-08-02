# Application: Website screenshots as a service

## Summary
**Goal**<br>
Build a screenshot as a service, _i.e._ a component/service for inputting as list of URLs and receiving one screenshot for each URL. 

Design includes as a back-end that could be run in a datacenter.  Optionally, the service could have a front end.  Optionally, the front end could receive the list of URLs through a form or an uploaded text file.  Optionally, the front end can display the screenshots.

**Requirements**<br>
1. Input: One or many (a list of) URLs for the component/service to screenshot.
   1. Option: The list could be stored in a separate file.
   2. Option: The list could delimited by a ";".
2. Saving data: The service should store the result of the request (a collection of image files and a request ID).  
3. Retrieving data: The user should be able to query the service for the results, and retrieve the results at any point in time.
4. Output: A single screenshot (image file) at each URL.
5. Scalability: Brief specification on how the service should be scaled to handle up to 1 000 000 screenshots per day as an enterprise infrastructure component.
   1. Option: Message queues could be used to separate the different parts of the service and prepare for scalability.
   2. Option: How long should the requested data remain (persistence)?
6. Technology: Any languages, frameworks, APIs, or databases.

## Development Flow and Build
**Minimum Viable Product (MVP)**<br>
* Feature: Screenshot controller
  * Implement screen capture with a given URL and verify image output.
    * Add parser to receive a list of URLs.
    * Add text file import to receive URLs from file.
* Feature: Dataflow controller, Job model
  * Implement control of data generated for and received from Screenshot, then store all data in database.
    * Add text file generator generated from a string of delimited URLs.
    * Add Job model(s) and database which sets database migration to hold arrays of images, arrays of URLs, and a job ID.
      * Maybe needs multiple linked models.  Job has many URLs / Job has many images / URL has one image?
  * Implement management of database queries (Jobs) to retrieve the screenshot(s) from a past job.
    * Add method to "show" URLs and images from a given Job.






