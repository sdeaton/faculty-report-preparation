Feature: Be able to navigate to other pages from home page
  
  Scenario: User first loads webapp
    Given User is on the home page
    Then User should see a Faculty Member Historical Data button
      And User should see a Evaluation Data button
      And User should see PICA Utilities as a title

  Scenario: User wants to view evaluation data
    Given User is on the home page
    When User clicks on the Evaluation Data button
    Then User should see the evaluations page

  Scenario: User wants to view faculty member historical data
    Given User is on the home page
    When User clicks on the Faculty Member Historical Data button
    Then User should see the faculty member historical data page
  