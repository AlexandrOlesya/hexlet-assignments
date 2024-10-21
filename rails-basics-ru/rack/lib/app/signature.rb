# frozen_string_literal: true

require 'digest'

class MiddlewareSignature
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    request = Rack::Request.new(env)
    signature = Digest::SHA2.hexdigest(body)

    new_body = "#{body}\n#{signature}"
    [status, headers, new_body]
  end  

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    [200, {}, ['Hello, World!']]
  end
end

use MiddlewareSignature
run Signature.new
