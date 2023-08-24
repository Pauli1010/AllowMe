# frozen_string_literal: true

module AllowMe
  module Controller
    module Submodules
      # The Role submodule takes care of setting the user's role configuration
      # as well as for handling roles on the admin side.
      # See AllowMe::Model::Submodules::Role for configuration options.
      module Role
        def self.included(base)
          helper_method :role
          base.send(:include, InstanceMethods)
          Config.module_eval do
            class << self
              # Add code
            end
          end
          # Add Config settings
        end

        module InstanceMethods

        end
      end
    end
  end
end