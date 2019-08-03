Feature: User has screenshots generated from URLs
  "As a user,
  In order to have the requested screenshots processed,
  I want the screenshots generated as images and stored in the database along with the request name and URLs for later recall."

  Scenario: Screenshot method is implemented when user saves request
    Given that I visit the index page
    When I click "Screenshot Request"
    And I fill "Name" with "2019/08/02 submission"
    And I fill "URL" with "https://www.google.com/; https://www.google.com/maps/"
    And I click "Submit Request"
    Then I should see "The screenshots have been generated and saved."