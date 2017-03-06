require 'forwardable'

module Moltin
  class Client
    extend Forwardable

    attr_reader :config
    def_delegators :config, *Configuration::OPTIONS.keys

    def initialize(config = Moltin.configuration)
      @config = config
    end
  end
end
