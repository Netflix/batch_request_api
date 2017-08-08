require 'batch_request_api/batch_parallel'
require 'batch_request_api/batch_sequential'
require 'json'

module BatchRequestApi
  class Middleware
    include BatchParallel
    include BatchSequential

    PATH_INFO_HEADER_KEY  = 'PATH_INFO'.freeze

    def initialize(app)
      @app = app
    end

    def call(env)
      if is_batch_sequential_path?(env[PATH_INFO_HEADER_KEY])
        batch_sequential(env)
      elsif is_batch_parallel_path?(env[PATH_INFO_HEADER_KEY])
        batch_parallel(env)
      else
        @app.call(env) # regular RAILS CRUD
      end
    end

    def is_batch_sequential_path?(path)
      BatchRequestApi.config.batch_sequential_paths.include?(path)
    end

    def is_batch_parallel_path?(path)
      BatchRequestApi.config.batch_parallel_paths.include?(path)
    end
  end
end
