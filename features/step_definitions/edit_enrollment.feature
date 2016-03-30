Feature: Edit enrollment numbers for classes

  Scenario: User can click on the edit button
	Given There exists 5 evaluation record in the database for instructor xyz
	When User visits the evaluation page
	Then User should see a link for Edit for the record

  Scenario: User gets redirected to edit.html page upon clicking edit button in view page
    Given There exists 5 evaluation record in the database for instructor xyz
	When User visits the evaluation page
    And User clicks on Edit link
    Then User should be redirected to evaluation edit page

  Scenario: User gets redirected to evaluation index page after updating
    Given There exists 5 evaluation record in the database for instructor xyz
    When User is on edit page for user 1 
    And User clicks on Update Enrollment button on edit page
    Then User should be redirected to evaluation index page
