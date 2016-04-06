Feature: Be able to navigate to other pages from home page

  Scenario: User first loads webapp
    Given User is on the home page
    And User is authenticated
    Then User should see a Faculty Member Historical Data button
      And User should see a Evaluation Data button
      And User should see PICA Utilities as a title

  Scenario: User wants to view evaluation data
    Given There exists 1 group of 5 evaluation records in the database for instructor Brent Walther
    Given User is on the home page
    And User is authenticated
    When User clicks on the Evaluation Data button
    Then User should see the evaluations page for 2015C

  Scenario: User wants to view faculty member historical data
    Given User is on the home page
    And User is authenticated
    When User clicks on the Faculty Member Historical Data button
    Then User should see the faculty member historical data page

