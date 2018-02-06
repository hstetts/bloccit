module ApplicationHelper
   #define a method named form_group_tag which takes two args, array of errors and block
   #&turns block into a proc, which is a block that can be reused like a variable
   def form_group_tag(errors, &block)
     css_class = 'form-group'
     css_class << ' has-error' if errors.any?

     content_tag :div, capture(&block), class: css_class
   end

   def avatar_url(user)
     gravatar_id = Digest::MD5::hexdigest(user.email).downcase
     "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
   end
end
