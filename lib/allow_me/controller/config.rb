# frozen_string_literal: true

module AllowMe
  module Controller
    module Config
      class << self
        attr_accessor :submodules
        # what classes to use as the user class.
        attr_accessor :user_classes
        # what class to use as the role class.
        attr_accessor :role_class

        def init!
          @defaults = {
            :@user_classes => nil,
            :@submodules => [],
            :@role_class => nil
          }
        end

        # Resets all configuration options to their default values.
        def reset!
          @defaults.each do |k, v|
            instance_variable_set(k, v)
          end
        end

        def update!
          @defaults.each do |k, v|
            instance_variable_set(k, v) unless instance_variable_defined?(k)
          end
        end

        def user_config(&blk)
          block_given? ? @user_config = blk : @user_config
        end

        def configure(&blk)
          @configure_blk = blk
        end

        def configure!
          @configure_blk&.call(self)
        end
      end

      init!
      reset!
    end
  end
end
