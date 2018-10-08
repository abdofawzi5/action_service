require 'action_service/version'
require 'generators/service/service_generator'
require 'generators/application_service/application_service_generator'

module ActionService
  
  
  # ActionService::Base is the parent class for all services that will be generated.
  class Base
   def initialize
      @errors = []     # contain errors
      @response = {}   # contain the service response data
      @success = true  # flag service execution without any error
    end

    def errors 
      @errors
    end

    def response
      @response
    end

    def success?
      @success
    end

    def add_error(*error_message)
      @success = false
      @errors += error_messages_list
    end

    def add_errors(error_messages_list)
      @success = false
      @errors += error_messages_list
    end
  end

end
