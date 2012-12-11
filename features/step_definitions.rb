
# TODO nicer step-def code, more support code
Given /^jenkins on port "(.*?)" with jobs "(.*?)", "(.*?)" with statuses respectively "(.*?)", "(.*?)"$/ do |port, job1, job2, stat1, stat2|
  mock_resp(port: port) do
    get('/api/json') do
      # TODO nicer jenkins response generation
      { 'jobs' => [ { 'name' => job1, 'color' => status_to_color(stat1) },
                    { 'name' => job2, 'color' => status_to_color(stat2) } ]
      }.to_json
    end
  end

end

When /^I execute rjja with parameters "(.*?)"$/ do |params|
  @resp = exec_cli params
end

Then /^it should print "(.*?)"$/ do |line1|
  lines = line1.split /"\s*,\s*"/
  #@resp.chomp.should == line1
  @resp.split("\n").should =~ lines
end

Given /^the rjja binary$/ do
  # TODO  File.exists
end

Then /^it should print the usage$/ do
  pending # express the regexp above with the code you wish you had
end

