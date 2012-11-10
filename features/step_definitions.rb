

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

Then /^it should print lines "(.*?)", "(.*?)"$/ do |line1, line2|
  @resp.split("\n").should =~ [line1,line2]
end


