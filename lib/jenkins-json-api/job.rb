
require 'open-uri'

module Jenkins
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

    def build
      open url+'build'
    end

    def build_async
      Process.waitpid @job if @job
      @job = fork do
        build
      end
    end

    def to_s
      "\n  #{super.to_s}\n    name: #{name}\n    url: #{url}\n    success: #{success?}\n"
    end

    def ==(r)
      r.name == name and
      r.url  == url  and
      r.success? == success?
    end

    attr_reader :name, :url, :color
  end
end

