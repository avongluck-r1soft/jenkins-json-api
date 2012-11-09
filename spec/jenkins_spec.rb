
require 'spec_helper'

require_relative '../lib/jenkins-json-api'

describe Jenkins do
  let(:testhost) { 'myjenkinshost.com' }
  let(:jenkins) { Jenkins.new testhost }

  it { jenkins.host.should == testhost }

  context "get_all_jobs" do
    before :each do
      jenkins.stub_chain(:open,:read).and_return( JenkinsTestDataGenerator.real_root )
    end

    it "should return list of jobs" do
      jenkins.get_all_jobs.map { |job| job.name }.should == ['config-provider-model','core_selenium-test','gerrit_master']
    end

    it "should return jobs with its names, urls, success states" do
      jobs = jenkins.get_all_jobs
      jobs[2].name.should == 'gerrit_master'
      jobs[2].url.should == "http://myjenkinshost.com/job/gerrit_master/"
      jobs[2].success?.should == true
      jobs[0].success?.should == false
    end

  end
end

