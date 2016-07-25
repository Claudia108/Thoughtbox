class Link < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :url, presence: true, url: true

  enum read: %w(unread read)


end
