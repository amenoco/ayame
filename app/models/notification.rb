class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :post_comment
  belongs_to :post
  scope :unread, -> { where( already_read: false ) }
end
