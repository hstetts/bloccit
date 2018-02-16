class FavoriteMailer < ApplicationMailer
  default from: "youremail@email.com"

  def new_comment(user, post, comment)

     # set three different headers to enable conversation threading in different email clients.
     headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
     headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
     headers["References"] = "<post/#{post.id}@your-app-name.example>"

     @user = user
     @post = post
     @comment = comment

     #the mail method takes a hash of mail-relevant information -
     # - the subject the to address, the from (we're using the default), and any cc or bcc information
     #- and prepares the email to be sent.
     mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
