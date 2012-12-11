
require 'json'

module Jenkins
  # represents a jenkins instance
  class Jenkins
    # @param [String] host the host of jenkins instance (with port) E.g "localhost:4000"
    def initialize(host)
      @host = host
    end

    # Returns all job from Jenkins instance
    #
    # @return [Array<Jenkins::Job>] all job
    def get_all_jobs
      get_json['jobs'].map { |job| Job.new(job) }
    end

    # Sends build command to Jenkins for every job
    # @note it sends the commands synchronously
    # @return [NilClass]
    def build_all
      get_all_jobs.each do |job|
        job.build
      end
    end

    # @return [String] host of jenkins instance (with port). E.g. "localhost:4000"
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

