Feature: Just browsing on Amazon website

  Background:
    Given Enabled BStack Automate

  Scenario: Searching for Mobile Phones
    Given I am on Amazon website
    When I search for Mobile Phone
    Then Title should contain mobile phone
