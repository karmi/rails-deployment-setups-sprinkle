require 'rack'

Application = proc { |env| [ 200, {'Content-Type' => 'text/plain'}, ["Hello World!"] ] }
