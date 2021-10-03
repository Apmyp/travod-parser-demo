# frozen_string_literal: true

class Linguist < ApplicationRecord
  validates :first_name, :last_name, :country, :native_language, :target_language, :source, presence: true
end
