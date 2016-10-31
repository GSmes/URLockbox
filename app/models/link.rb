class Link < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :url, presence: true, url: true
end
