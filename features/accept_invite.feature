Feature: accept invite
  To accept an invite
  An invitee
  Logs in and checks the I accept box

  Scenario: Login 
    Given I am not authenticated
    And I am a user "myfriend" with password "apassword"
    And I have an invite
    When I go to /invites
    And I fill in "login" with "myfriend"
    And I fill in "password" with "apassword"
    And I press "Log In"
    Then I should see "Are you coming?"


