
require 'mock_server_thin'

RJJA_BIN='bin/rjja'

def exec_cli(params)
  cmd = "#{RJJA_BIN} #{params}"
  puts cmd
  ret = `#{cmd} 2>&1`
  puts "RETURNED:\n---------\n#{ret}\n-----------"
  ret
end

def status_to_color(s)
  if s =~ /fail/
    'red'
  else s =~ /succ/
    'blue'
  end
end

def mock_resp( opts = {}, &block )
  app = Class.new(Sinatra::Base)
  app.class_eval &block
  @server = MockServerThin.new(app,opts,&block).start
end

