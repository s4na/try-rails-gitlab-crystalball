class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :body, presence: true, length: { maximum: 1000 }

  scope :chronological, -> { order(created_at: :asc) }
end
