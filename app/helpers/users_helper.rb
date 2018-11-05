module UsersHelper
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "http://media.minimalist.business/images/customer-profile-template/ideal-customer-profile.jpg"
    image_tag(gravatar_url, alt: user.user_name, class: "gravatar")
  end
end
