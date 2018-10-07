require 'action_service/version'
require 'generators/rails/service_generator'
require 'generators/application_service_generator'

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

    def add_error(error)
      @success = false
      if error.kind_of?(Array)
        @errors += error
      else
        @errors.append(error)
      end
    end
  end

end
