module UsersHelper
  def avatar_for(user)
    #gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    #gravatar_url = "http://media.minimalist.business/images/customer-profile-template/ideal-customer-profile.jpg"
    unless user.avatar.nil?
      avatar=user.avatar.variant(resize: "100X100")
    end
    image_tag(avatar || user.gravatar_url, class: "rounded-circle")
  end
end
