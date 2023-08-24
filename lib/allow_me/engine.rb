# frozen_string_literal: true

require 'allow_me'
require 'rails'

module AllowMe
  # The AllowMe engine takes care of extending ActiveRecord (if used) and ActionController,
  # With the plugin logic.
  class Engine < Rails::Engine
    config.allow_me = ::AllowMe::Controller::Config

    initializer 'extend Controller with allow_me' do
      # FIXME: on_load is needed to fix Rails 6 deprecations, but it breaks
      #        applications due to undefined method errors.
      # ActiveSupport.on_load(:action_controller_api) do
      ActionController::API.include AllowMe::Controller if defined?(ActionController::API)

      # FIXME: on_load is needed to fix Rails 6 deprecations, but it breaks
      #        applications due to undefined method errors.
      # ActiveSupport.on_load(:action_controller_base) do
      if defined?(ActionController::Base)
        ActionController::Base.include AllowMe::Controller
        # ActionController::Base.helper_method :user_allowed?
        # ActionController::Base.helper_method :role
      end
    end
  end
end
