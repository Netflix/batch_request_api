if defined?(::Rails)
  module BatchRequestApi
    class Engine < ::Rails::Engine
      isolate_namespace BatchRequestApi
    end
  end
end
