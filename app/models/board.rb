# frozen_string_literal: true

class Board < ApplicationRecord
  validates :title, presence: true

  belongs_to :workspace
  has_many :cards, dependent: :destroy
end
