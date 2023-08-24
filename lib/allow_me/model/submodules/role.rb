# frozen_string_literal: true

class Role < ActiveRecord::Base
  validates :name, presence: true
end
