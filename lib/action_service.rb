require 'action_service/version'

module ActionService
 
  # ApplicationService is the parent class for all services will be generated.
  class ApplicationService
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
