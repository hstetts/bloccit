class ApplicationController < ActionController::Base
   protect_from_forgery with: :exception
   include SessionsHelper

   private
   #define require_sign_in to redirect unsigned in users.
   #we'll eventually want to call it from other controllers.
   #reminder: controllers are classes and inherit from ApplicationController
   def require_sign_in
     unless current_user
       flash[:alert] = "You must be logged in to do that"
       #redirect un-signed in users to the sign-in page
       redirect_to new_session_path
     end
   end
end
