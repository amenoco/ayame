class ContactMailer < ApplicationMailer
  def send_notification(user, post_comment) #メソッドに対して引数を設定
    @user = user #ユーザー情報
    @post_comment = post_comment #返信内容
    mail to: user.email, subject: 'コメントが来ています'
  end
end
