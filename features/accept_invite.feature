Feature: accept invite
  To accept an invite
  An invitee
  Logs in and checks the I accept box

  Scenario: Login 
    Given I am logged in as "myfriend" with password "apassword" with invite for "dave"
    Then I should see "Are you coming?"

  Scenario: Accept Invite
    Given I am logged in as "myfriend" with password "apassword" with invite for "dave"
    When I press "Dave is coming!"
    Then I should see "Accepted invite!"
    
  Scenario: Accept Invite
    Given I am logged in as "myfriend" with password "apassword" with invites for "dave,sally"
    When I press "Dave is coming!"
    Then I should see "Dave accepted invite!"
    When I press "Sally is coming!"
    Then I should see "Sally accepted invite!"
