class NotificationMailer < ApplicationMailer
  def new_comment(comment)
    @comment = comment
    @post = comment.post
    @commenter = comment.user

    mail to: @post.user.email, subject: "New comment on \"#{@post.title}\""
  end

  def new_follower(follower:, followed:)
    @follower = follower
    @followed = followed

    mail to: @followed.email, subject: "#{@follower.name} started following you"
  end

  def welcome(user)
    @user = user

    mail to: @user.email, subject: "Welcome to the Blog!"
  end
end
