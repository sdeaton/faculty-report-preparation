Feature: Manually enter evaluation data from paper evaluations

  Scenario: User has the option of adding a course name for courses without one
    Given User is authenticated
    And There exists 1 group of 5 evaluation records in the database for instructor Brent Walther
    When User visits the evaluation index page
    And User clicks on Brent Walther link
    Then User be on the instructor evaluation page for Brent Walther

  Scenario: User can access the add course name page and see the correct fields
    Given User is authenticated
    And There exists 1 group of 5 evaluation records in the database for instructor Brent Walther
    When User visits the instructor evaluation page for Brent Walther
    And User clicks on Add Course Name link
    Then User should see input fields for Course, Name

  Scenario: User can add a new course name manually
    Given User is authenticated
    And There exists 1 group of 5 evaluation records in the database for instructor Brent Walther
    When User visits the instructor evaluation page for Brent Walther
    And User clicks on Add Course Name link
    And User fills in Course with CSCE 121, Name with Intro to programming
    And User clicks on the Add Course Name button
    Then User be on the instructor evaluation page for Brent Walther
