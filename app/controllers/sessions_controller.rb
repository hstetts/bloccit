class SessionsController < ApplicationController
   def new
   end

   def create
     #search db for user with specified email address in the params hash.
     user = User.find_by(email: params[:session][:email].downcase)

     #verify user isn't nil and password in params hash matches the specified password.
     if user && user.authenticate(params[:session][:password])
       create_session(user)
       flash[:notice] = "Welcome, #{user.name}!"
       redirect_to root_path
     else
       flash.now[:alert] = 'Invalid email/password combination'
       render :new
     end
   end

   def destroy
 # #3
     destroy_session(current_user)
     flash[:notice] = "You've been signed out, come back soon!"
     redirect_to root_path
   end
end
