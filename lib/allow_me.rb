# frozen_string_literal: true

require_relative 'allow_me/version'

module AllowMe
  class Error < StandardError; end
  require 'allow_me/controller'
  require 'allow_me/model'

  module Controller
    autoload :Config, 'allow_me/controller/config'
    module Submodules
      require 'allow_me/controller/submodules/role'
    end
  end

  require 'allow_me/engine' if defined?(Rails)
end
