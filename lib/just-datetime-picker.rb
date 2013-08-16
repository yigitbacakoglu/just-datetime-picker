require 'formtastic'

module Just
  module DateTimePicker
    class Railtie < ::Rails::Railtie
      config.after_initialize do
        # Add load paths straight to I18n, so engines and application can overwrite it.
        require 'active_support/i18n'

        I18n.load_path += Dir[File.expand_path('../just-datetime-picker/locales/*.yml', __FILE__)]
        
        require 'active_admin'
        require 'inherited_resources'
        require 'just-datetime-picker/data_access_decorator'
        
      end
    end
  end
end


require 'just-datetime-picker/engine'
require 'just-datetime-picker/core'
require 'just-datetime-picker/databases/common' 
require 'just-datetime-picker/databases/activerecord' if defined?(ActiveRecord::Base)
require 'just-datetime-picker/databases/mongoid'      if defined?(Mongoid::Document)
require 'just-datetime-picker/formtastic-input'
