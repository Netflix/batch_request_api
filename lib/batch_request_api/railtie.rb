module BatchRequestApi
  class Railtie < Rails::Railtie
    initializer "batch_request_api.insert_middleware" do |app|
      app.config.middleware.insert_before Rack::Sendfile, BatchRequestApi::Middleware
    end
  end
end
