
require 'json'

module Jenkins
  class Jenkins
    def initialize(host)
      @host = host
    end

    def get_all_jobs
      get_json['jobs'].map { |job| Job.new(job) }
    end

    def build_all
      get_all_jobs.each do |job|
        job.build
      end
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
end

