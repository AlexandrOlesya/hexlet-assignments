# frozen_string_literal: true

require 'rack'

class Router
  def call(env)
    request = Rack::Request.new(env)

    case request.path
    when '/'
      [200, {}, ['Hello, World']]
    when '/about'
      [200, {}, ['About']]
    else
      [404, {}, ['Not Found']]
    end
  end
end
