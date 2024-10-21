# frozen_string_literal: true

class MiddlewareAdminPolicy
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    [403,{},[]] if request.path == '/admin' 
  end  
end  

class AdminPolicy
  def initialize(app)
    @app = app
  end

  def call(env)
    [200, {}, ['succes']]
  end
end

use MiddlewareAdminPolicy
run AdminPolicy.new
