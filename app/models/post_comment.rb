class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :comment, presence: true,length:{maximum:140}
  after_save do
    Notification.create!(user_id: self.post.user.id, post_comment_id: self.id)
   
      ContactMailer.send_notification(@user, @post_comment).deliver #確認メールを送信
   
  end
end
