# frozen_string_literal: true

# The first thing you need to configure is which modules you need in your app.
# The default is nothing which will include only core features (password encryption, login/logout).
#
# Available submodules are: :roles
Rails.application.config.allow_me.submodules = []

# Here you can configure each submodule's features.
Rails.application.config.allow_me.configure do |config|
  config.user_config do |user|
  end
  config.user_classes = <%= model_class_names %>
end
