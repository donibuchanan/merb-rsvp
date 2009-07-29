Feature: accept invite
  To accept an invite
  An invitee
  Logs in and checks the I accept box

  Scenario: Login 
    Given I am logged in as "myfriend" with password "apassword"
    Then I should see "Are you coming?"

  Scenario: Accept Invite
    Given I am logged in as "myfriend" with password "apassword"
    When I press "I'm coming!"
    Then I should see "Accepted invite!"
