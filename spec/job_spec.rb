
require 'spec_helper'

require_relative '../lib/jenkins-json-api'

describe Jenkins::Job do
  let(:job1_hash) { { 'name'  => 'gerrit_master',
                      'url'   => "http://testhost/job/gerrit_master/",
                      'color' => 'blue' } }

  subject { Jenkins::Job.new(job1_hash) }
  its(:name) { should == 'gerrit_master' }
  its(:url)  { should == job1_hash['url'] }
  its(:success?) { should == true }

  context "build a job" do

    it "should send url request to build to job" do
      subject.should_receive(:open).once.with "#{job1_hash['url']}build"

      subject.build
    end
  end
end
