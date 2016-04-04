Feature: Be able to view data in the database

  Scenario: User can view a formatted table of data
    Given There exists 1 group of 5 evaluation records in the database for instructor Brent Walther
    And User is authenticated
    When User visits the evaluation index page
    Then User should see a table of 7 data rows

  Scenario: User can view all instructors
    Given There exists 1 group of 5 evaluation records in the database for instructor Brent Walther
    And There exists 1 group of 5 evaluation records in the database for instructor John Smith
    And User is authenticated
    When User vists the instructor index page
    Then User should see a link for instructor Brent Walther
    And User should see a link for instructor John Smith

  Scenario: User can view an instructors courses
    Given There exists 1 group of 5 evaluation records in the database for instructor Brent Walther
    And User is authenticated
    When User visits the evaluation index page
    And Clicks on the name of instructor Brent Walther
    Then User should see courses page for Brent Walther
