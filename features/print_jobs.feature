Feature: rjja - print all job
  In order to get feedback from my jenkins CI tool
  As an agile developer who using continuous integration
  I want to know my jenkins-jobs' names and their statuses

  Scenario: print all job
    Given jenkins on port "4000" with jobs "firstjob", "secjob" with statuses respectively "success", "failed"
    When I execute rjja with parameters "--host=localhost:4000 job list"
    Then it should print "firstjob success", "secjob failed"


