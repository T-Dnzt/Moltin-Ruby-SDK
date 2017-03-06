module Moltin
  class Configuration
    OPTIONS = {
      # Authentication Params
      client_id: -> { ENV['MOLTIN_CLIENT_ID'] },
      client_secret: -> { ENV['MOLTIN_CLIENT_SECRET'] },

      # API Endpoints Configuration
      version: 'v2',
      baseURL: 'https://api.moltin.com',
      authURI: 'oauth/access_token'
    }.freeze

    # Setting all the OPTIONS keys as attributes
    attr_accessor(*OPTIONS.keys)

    def initialize
      # Initializing each attribute with its default value.
      # These values can then be overridden.
      OPTIONS.each do |name, val|
        value = val.respond_to?(:lambda?) && val.lambda? ? val.call : val
        instance_variable_set("@#{name}", value)
      end
    end

    # Public: Allows config options to be read like a hash
    #
    # option - Key for a given attribute
    #
    # Returns value of requested attribute
    def [](option)
      send(option)
    end

    # Public
    # Returns a hash of all configurable options
    def to_hash
      OPTIONS.keys.inject({}) do |hash, option|
        hash[option.to_sym] = send(option)
        hash
      end
    end
  end
end
