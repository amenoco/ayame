class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :post_comment
  
  scope :unread, -> { where( already_read: false ) }
end
