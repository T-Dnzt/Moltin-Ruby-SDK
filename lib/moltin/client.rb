require 'forwardable'

module Moltin
  class Client
    extend Forwardable

    # The Moltin configuration.
    attr_reader :config

    # Public: Create an instance of the SDK client,
    # using the options of the argument or the global configuration
    #
    # options - Hash of options to override in the global configuration
    #
    def initialize(options = nil)
      @config = load_config(options)
    end

    private

    def load_config(options)
      return Moltin.configuration unless options

      config = Configuration.new
      config.merge(Moltin.configuration.to_hash.merge(options))
      config
    end
  end
end
