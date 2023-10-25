# frozen_string_literal: true

class Workspace < ApplicationRecord
  validates :title, presence: true

  has_many :boards, dependent: :destroy

  scope :recent, -> { order(created_at: :desc) }
end
