class Article < ApplicationRecord
  validates_presence_of :title, :content
  belongs_to :user
  scope :articles_by, ->(user) { where(user_id: user.id)}
end
