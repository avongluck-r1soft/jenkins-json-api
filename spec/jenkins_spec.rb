
require 'spec_helper'

require_relative '../lib/jenkins-json-api'

describe Jenkins do
  let(:testhost) { 'myjenkinshost.com' }
  let(:jenkins) { Jenkins.new testhost }

  it { jenkins.host.should == testhost }

  context "there is a running jenkins" do

    before :all do
      # TODO Jenkins-json generator
      jenkins.stub_chain(:open, :read).and_return(
      {
        jobs: [ {name:'proj1'},
                {name:'2ndjob'}
              ]
      }.to_json )
    end

    it "should return list of jobs" do
      jenkins.get_all_jobs.should == ['proj1','2ndjob']
    end
  end
end

