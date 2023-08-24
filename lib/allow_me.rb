# frozen_string_literal: true

require_relative "allow_me/version"

module AllowMe
  class Error < StandardError; end
  require 'allow_me/controller'

  module Controller
    autoload :Config, 'allow_me/controller/config'
    module Submodules
      # add submodules here
    end
  end

  require 'allow_me/engine' if defined?(Rails)
end
