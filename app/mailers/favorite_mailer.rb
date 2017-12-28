class FavoriteMailer < ApplicationMailer
  default from: "kevinpmbudd@gmail.com"

  def new_comment(user, post, comment)
    headers["Message-ID"] = "<comments/#{comment.id}@peaceful-peak-12986.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@peaceful-peak-12986.herokuapp.com>"
    headers["References"] = "<post/#{post.id}@peaceful-peak-12986.herokuapp.com>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end

  def new_post(user, post)
    headers["Message-ID"] = "<post/#{post.id}@peaceful-peak-12986.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@peaceful-peak-12986.herokuapp.com>"
    headers["References"] = "<post/#{post.id}@peaceful-peak-12986.herokuapp.com>"

    @user = user
    @post = post

    mail(to: user.email, subject: "You have favorited #{post.title}")
  end
end
