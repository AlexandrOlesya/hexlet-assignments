# frozen_string_literal: true

require 'digest'  

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    messsage = body.first
    body << '\n'
    body << Digest::SHA2.hexdigest(messsage)
    body << '\n'

    [status, headers, body]
  end
end