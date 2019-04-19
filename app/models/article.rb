class Article < ApplicationRecord
  enum category: { unassigned: 0, web_development: 1, local_news:2, world_news: 3 }
  validates_presence_of :title, :content, :user_id
  belongs_to :user
end
