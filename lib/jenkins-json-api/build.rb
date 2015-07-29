require 'open-uri'

module Jenkins
  # represents a build in jenkins
  class Build
    # @param [Hash] json the 'job' part of parsed JSON hash
    def initialize(json)
      @number = json['number']
      @url = json['url']
    end

    # compares two jobs whether they identical or not
    # @return [TrueClass] if names, urls, and statuses are identical
    # @return [FalseClass] if any of them is differs
    def ==(r)
      r.number == number and
      r.url  == url
    end

    attr_reader :url, :number
  end
end
