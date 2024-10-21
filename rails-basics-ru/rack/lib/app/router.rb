# frozen_string_literal: true

require 'rack'

class Router
  def call(env)
    def call(env)
      request = Rack::Request.new(env)

      if request.path == '/' || request.path == '/about'
        [200, {'Content-Type' => 'text/html'}, ['Hello']]
      else
        [404, {'Content-Type' => 'text/html'}, ['Hello']]
      end
    end
  end
end
