Feature: Logging into the app
  As an Artist
  I want to access my protected account
  So that only I can create my new galleries and edit my existing galleries

  Scenario: Unauthenticated users see a log in link
    Given I am not logged in
    Then I should see "Log in"

  Scenario: User supplies correct credentials
    Given I am not logged in
    When I log in with the correct password
    Then I should see "Log out"
    And I should see my list of galleries
    And I should see "New Gallery"
