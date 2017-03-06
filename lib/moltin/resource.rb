module Moltin
  class Resource
    attr_accessor :auth_token, :config

    def initialize(config)
      @config = config
      self
    end

    def get_access_token
      # TODO: Retrieve from storage
      return auth_token if auth_token && auth_token.valid?

      # TODO: Save in storage

      auth_token = authenticate
      auth_token
    end

    def authenticate
      body = {
        grant_type: 'client_credentials',
        client_id: @config.client_id,
        client_secret: @config.client_secret
      }
      response = Faraday.new(url: @config.baseURL).post("/#{@config.authURI}", body)

      body = JSON.parse(response.body)
      raise AuthenticationError if body.access_token.blank?

      body
    end
  end
end
