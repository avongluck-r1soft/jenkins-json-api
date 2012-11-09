
module JenkinsTestDataGenerator
  def self.root()
    { jobs: [ {name:'proj1'},
              {name:'2ndjob'} ] }.to_json
  end

  def self.real_root()
    open('spec/root.json').read
  end
end

