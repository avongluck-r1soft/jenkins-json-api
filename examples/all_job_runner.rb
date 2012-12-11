require 'jenkins-json-api'

jenkins = Jenkins::Jenkins.new 'myjenkinshost:80'


jenkins.get_all_jobs.each do |job|
  if job.name =~ /myjobpattern/
    puts job.name
    job.build_async # sending request async, useful if there is many job
  end
end
