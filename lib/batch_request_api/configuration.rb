module BatchRequestApi
  class << self
    def config
      @config ||= Configuration.new
    end

    def configure
      yield(config)
    end
  end

  class Configuration
    attr_accessor :batch_sequential_path
    attr_accessor :batch_parallel_path

    def initialize
      self.batch_sequential_path = '/api/v1/batch_sequential'
      self.batch_parallel_path = '/api/v1/batch_parallel'
    end
  end
end
