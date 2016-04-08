Feature: Integrate data uploaded from excel files downloaded from PICA website

  Scenario: User navigates to import data page
    Given User is authenticated
    And User is on the home page
    When User clicks on the Import evaluation data from PICA button
    Then User should be on the import page
    
  Scenario: User uploads excel file
    Given User is authenticated
    And User is on the import page
    When User selects excel file
    And User clicks on the Upload button
    Then User should be on the evaluation page for term 2015C
    And User should see 9 new evaluations imported. 0 evaluations updated.
    
  Scenario: User uploads a non-excel file
    Given User is authenticated
    And User is on the import page
    When User selects a non-excel file
    And User clicks on the Upload button
    Then User should be on the import page
    And User should see message stating Error with file upload, please check your file
    
