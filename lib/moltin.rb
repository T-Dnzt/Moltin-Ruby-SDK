require 'moltin/version'
require 'moltin/configuration'
require 'moltin/client'

module Moltin
  class << self
    attr_accessor :configuration
  end

  def self.configure
    @configuration = Configuration.new
    yield(configuration)
  end
end
