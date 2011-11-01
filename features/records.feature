Feature: Records
  As a a user
  I want to be able to manage records

  Scenario: Adding a new record
    Given I am on the new record page
    When  I add a new record
    Then  I should see the page for my newly created record
    And   the notice 'The record has been created.'

  Scenario: Showing a record
    Given I am viewing any record
    Then  I should see all of the record's attributes

  Scenario: Index of all records
    Given I am on the records page
    Then  I should see a paginated list of all the records
    And   I should see facets for courts

  Scenario: Requesting a record
    Given I am viewing any record
    Then  I should be able to request that record
