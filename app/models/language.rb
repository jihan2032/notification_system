# frozen_string_literal: true

class Language < ApplicationRecord
  validates :name, :code, presence: true
  validates :name, :code, uniqueness: true
end
