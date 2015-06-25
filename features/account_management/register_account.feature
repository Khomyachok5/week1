Feature: account_management.register_account
Registering new account
User info, used for registrartion - email(login), password, password re-type, subdomain name


  Scenario: user opens new account registration form
  	Given user visits "Start" page
  	When user clicks "Create new account" link
  	Then user should be redirected to "Create new account" page
    And all fields are visible
    And user should see "Create Account" button is disabled
    And user should not see any error messages

  Scenario: user registers new account
  	Given user visits "Create new account" page
  	When user properly fills the form
  	And presses "Create Account" button
  	Then user should be redirected to "Account admin panel" page
    And user should not see any error messages

  Scenario: user enters blank login
    Given user visits "Create new account" page
  	When user properly fills the form
  	And user leaves email field blank
  	Then user should see "Create Account" button is disabled

  Scenario: user enters invalid login
    Given user visits "Create new account" page
  	When user properly fills the form
  	And enters incorrect email
    Then user should see "Create Account" button is disabled

  Scenario: user enters blank subdomain
    Given user visits "Create new account" page
    When user properly fills the form
    And user leaves subdomain field blank
    Then user should see "Create Account" button is disabled

  Scenario: user enters invalid subdomain
    Given user visits "Create new account" page
    When user properly fills the form
    And enters incorrect subdomain
    And presses "Create Account" button
    Then user should see "invalid subdomain" error message

  Scenario: user enters existing subdomain
    Given user visits "Create new account" page
    When user properly fills the form
    And presses "Create Account" button
    Then user should be redirected to "Account admin panel" page
    And user should not see any error messages
    Then user visits "Create new account" page
    And user properly fills the form
    And presses "Create Account" button
    Then user should stay on "Create new account" page
    Then user should see "Subdomain already taken" error message

  Scenario: user enters blank password
    Given user visits "Create new account" page
  	When user properly fills the form
  	And user leaves password field blank
  	Then user should see "Create Account" button is disabled

  Scenario: user re-enters blank password
    Given user visits "Create new account" page
  	When user properly fills the form
  	And user leaves re-enter password field blank
  	Then user should see "Create Account" button is disabled

  Scenario: user re-enters incorrect password
    Given user visits "Create new account" page
  	When user properly fills the form
    And user should not see "passwords do not match" message
  	And user fills re-enter password field with incorrect password
  	Then user should see "Create Account" button is disabled
  	And user should see "passwords do not match" error message

  Scenario: user re-enters incorrect password then correct password
    Given user visits "Create new account" page
    When user properly fills the form
    And user fills re-enter password field with incorrect password
    And user should see "Create Account" button is disabled
    And user should see "passwords do not match" error message
    And user properly fills the form
    Then user should not see "passwords do not match" error message
    And presses "Create Account" button



