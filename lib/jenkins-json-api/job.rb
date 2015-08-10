
require 'open-uri'

module Jenkins
  # represents a job in jenkins
  class Job
    # in JSON response 'blue' means stable build
    SUCCESS = 'blue'
    # in JSON response 'red' means failed build
    FAILED = 'red'

    # @param [Hash] json the 'job' part of parsed JSON hash
    def initialize(json)
      @name = json['name']
      @url  = json['url']
      @color = json['color']
    end

    # @return [TrueClass] true if the job is stable ("blue")
    # @return [FalseClass] false if the job is failed ("red")
    def success?
      return true if color == SUCCESS
      return false if color == FAILED
      raise "Inconsistent class state! color: #{color}"
    end

    # Returns all builds from Jenkins instance
    #
    # @return [Array<Jenkins::Build>] all build
    def get_all_builds
      get_sub_json("#{@url}api/json")['builds'].map { |build|
        details = get_sub_json("#{build['url']}api/json")
        Build.new(details)
      }
    end

    # Sends build command to job
    # @return [NilClass]
    def build
      open url+'build'
    end

    # Sends build command asynchronously to job
    # @note TODO returning of the forked task is not checked!
    # @return [NilClass]
    def build_async
      Process.waitpid @job if @job
      @job = fork do
        build
      end
    end

    # return string representation: Object address, name, url, status of the job
    # @return [String]
    def to_s
      "\n  #{super.to_s}\n    name: #{name}\n    url: #{url}\n    success: #{success?}\n"
    end

    # compares two jobs whether they identical or not
    # @return [TrueClass] if names, urls, and statuses are identical
    # @return [FalseClass] if any of them is differs
    def ==(r)
      r.name == name and
      r.url  == url  and
      r.success? == success?
    end

    attr_reader :name, :url, :color
    private
      def get_sub_json(url)
        JSON.parse(open(url).read)
      end
  end
end

