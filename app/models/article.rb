class Article < ApplicationRecord
  has_one_attached :photo
  belongs_to :category
  validates :photo, presence: true
end
