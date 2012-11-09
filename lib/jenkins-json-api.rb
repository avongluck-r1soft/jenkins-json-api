
require 'json'
require 'open-uri'

class Jenkins
  def initialize(host)
    @host = host
  end

  def get_all_jobs
    JSON.parse(open("http://#{host}/api/json").read)['jobs'].map { |job| job['name'] }
  end

  attr_reader :host
end

