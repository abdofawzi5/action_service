module Service
  class ServiceGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('templates', __dir__)

    def create_service_file
      template 'service.rb.tt', File.join('app/services', class_path, "#{file_name}_service.rb")
    end

    private

    def file_name
      @file_name ||= remove_possible_suffix(super)
    end

    def remove_possible_suffix(name)
      name.sub(/_?service$/i, '')
    end
  end
end
