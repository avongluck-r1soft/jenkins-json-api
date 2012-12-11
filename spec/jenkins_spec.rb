
require 'spec_helper'

require_relative '../lib/jenkins-json-api'

describe Jenkins::Jenkins do
  subject { Jenkins::Jenkins.new testhost }
  let(:testhost) { 'myjenkinshost.com' }

  its(:host) { should == testhost }

  let(:job1_hash) { { 'name'  => 'gerrit_master',
                      'url'   => "http://#{testhost}/job/gerrit_master/",
                      'color' => 'blue' } }
  let(:job2_hash) { { 'name'  => 'anotherjob',
                      'url'   => "http://#{testhost}/job/anotherjob/",
                      'color' => 'red' } }

  let(:json_hash) { { 'jobs' => [ job1_hash, job2_hash ] } }

  let(:jobs) { [ Jenkins::Job.new(job1_hash), Jenkins::Job.new(job2_hash) ] }

  context "get_all_jobs success" do
    before(:each) { JSON.should_receive(:parse).and_return( json_hash ) }
    before(:each) { subject.stub_chain(:open,:read) }

    its(:get_all_jobs) { should have(2).items }

    its(:get_all_jobs) do
      should =~ jobs
    end
  end

  context "build_all" do
    it "should send build URL for all jobs" do
      jobs.each { |job| job.should_receive :build }
      subject.should_receive( :get_all_jobs ).and_return jobs
      subject.build_all
    end
  end
end

