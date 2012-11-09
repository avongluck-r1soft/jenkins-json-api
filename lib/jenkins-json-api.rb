
require 'json'
require 'open-uri'

class Jenkins

  class Job
    SUCCESS = 'blue'
    FAILED = 'red'

    def initialize(json)
      @name = json['name']
      @url  = json['url']
      @color = json['color']
    end

    def success?
      return true if color == SUCCESS
      return false if color == FAILED
      raise "Inconsistent class state! color: #{color}"
    end

    attr_reader :name, :url, :color
  end

  def initialize(host)
    @host = host
  end

  def get_all_jobs
    get_json['jobs'].map { |job| Job.new(job) }
  end

  attr_reader :host
  private
    def get_json(med = nil)
      JSON.parse(open( api_url(med) ).read)
    end
    def api_url(med)
      "http://#{host}/api/json"
    end
end

