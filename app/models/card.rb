# frozen_string_literal: true

class Card < ApplicationRecord
  validates :title, presence: true

  belongs_to :board
end
