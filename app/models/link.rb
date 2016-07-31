class Link < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :url, presence: true, url: true

  def read_status
    return "read" if read
      "unread"
  end

  def mark_as_status
    return "Mark as Unread" if read
      "Mark as Read"
  end
end
