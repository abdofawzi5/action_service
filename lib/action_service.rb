require 'rails/generators'
require 'action_service/version'
require 'generators/service/service_generator'
require 'generators/application_service/application_service_generator'

module ActionService
  # ActionService::Base is the parent class for all services that will be generated.
  class Base
    attr_accessor :errors, :response

    def initialize
      @errors = []     # contain errors
      @response = {}   # contain the service response data
      @success = true  # flag service execution without any error
    end

    def success?
      @success
    end

    def add_error(error_message)
      @success = false
      @errors << error_message
    end

    def add_errors(*error_messages)
      @success = false
      error_messages = error_messages[0] if error_messages[0].is_a? Array
      @errors += error_messages
    end
  end
end
