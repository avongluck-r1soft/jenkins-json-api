Feature: handling errors in rjja
  In order to see useful error and help messages
  As an agile developer who using continuous integration
  I want to know what I did wrong

  Scenario: missing host parameter
    Given the rjja binary
    When I execute rjja with parameters ""
    Then it should print "Error: argument --host mandatory.","Try --help for help."

  Scenario: no action given
    Given the rjja binary
    When I execute rjja with parameters "--host=somehost"
    Then it should print "Error: no action given.", "Try --help for help."

  Scenario: non-existent host
    Given the rjja binary
    When I execute rjja with parameters "--host=asdf job list"
    Then it should print "Error: Network error"
