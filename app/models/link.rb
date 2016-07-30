class Link < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :url, presence: true, url: true

  def read_status
    return "read" if read
      "unread"
  end
end
