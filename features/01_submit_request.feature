Feature: User can submit request for screen shot
  "As a user,
  In order to submit a screen shot request,
  I want a to specify request name to identify the request, and URLs to specify the needed screenshots."

  Scenario: User specifies request Name and URLs
    Given that I visit the index page
    When I click "Screenshot Request"
    And I fill "Name" with "2019/08/02 submission"
    And I fill "URL" with "https://www.google.com"
    And I click "Submit Request"
    Then I should see "Your request has been submitted."