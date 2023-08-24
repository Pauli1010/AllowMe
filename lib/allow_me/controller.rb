module AllowMe
  module Controller
    def self.included(klass)
      klass.class_eval do
        include InstanceMethods
        Config.submodules.each do |mod|
          # FIXME: Is there a cleaner way to handle missing submodules?
          # rubocop:disable Lint/HandleExceptions
          begin
            include Submodules.const_get(mod.to_s.split('_').map(&:capitalize).join)
          rescue NameError
            # don't stop on a missing submodule.
          end
          # rubocop:enable Lint/HandleExceptions
        end
      end
      Config.update!
      Config.configure!
    end

    module InstanceMethods
      def user_classes
        @user_classes ||= Config.user_classes.map { |u| u.to_s.capitalize.constantize }
      rescue NameError
        raise ArgumentError, 'You have incorrectly defined user_class or have forgotten to define it in the initializer file (config.user_class = \'User\').'
      end
    end
  end
end