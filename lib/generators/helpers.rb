# frozen_string_literal: true

module AllowMe
  module Generators
    module Helpers
      private

      def allow_me_config_path
        'config/initializers/allow_me.rb'
      end

      # Either return the models passed in a classified form or return the default ["User"].
      def model_class_names
        options[:models] ? options[:models].map(&:classify) : ['User']
      end

      # Either return the models passed in a classified form or return the default 'Admin/Role'
      def role_class_name
        options[:role] ? options[:role].classify : 'Admin/Role'
      end

      def role_related_models
        [role_class_name]
      end

      def tableized_model_class(model_class_name)
        model_class_name.gsub(/::/, '').tableize
      end

      def model_path(model_class_name)
        @model_path ||= File.join('app', 'models', "#{file_path(model_class_name)}.rb")
      end

      def file_path(model_class_name)
        model_name(model_class_name).underscore
      end

      def namespace
        Rails::Generators.namespace if Rails::Generators.respond_to?(:namespace)
      end

      def namespaced?
        !!namespace
      end

      def model_name(model_class_name)
        if namespaced?
          [namespace.to_s] + [model_class_name]
        else
          [model_class_name]
        end.join('::')
      end
    end
  end
end
