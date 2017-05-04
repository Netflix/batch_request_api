require 'batch_request_api/batch_parallel'
require 'batch_request_api/batch_sequential'

module BatchRequestApi
  class Middleware
    include BatchParallel
    include BatchSequential
    require 'json'

    def initialize(app)
      @app = app
    end

    def call(env)
      if env['PATH_INFO'] == '/api/v1/batch_sequential'
        batch_sequential(env)
      elsif env['PATH_INFO'] == '/api/v1/batch_parallel'
        batch_parallel(env)
      else
        @app.call(env) # regular RAILS CRUD
      end
    end
  end
end
