module Service
  class ApplicationServiceGenerator < Rails::Generators::Base

    source_root File.expand_path("templates", __dir__)

    def create_application_service
      template "application_service.rb", application_service_file_name
    end

    private

    def application_service_file_name
      @application_record_file_name ||= "app/services/application_action.rb"
    end
    

  end
end