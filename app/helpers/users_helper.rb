module UsersHelper
  def avatar_for(user)
    #gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    #gravatar_url = "http://media.minimalist.business/images/customer-profile-template/ideal-customer-profile.jpg"
    if user.avatar.attached?
      avatar=user.avatar.variant(resize: "150X150")
    end
    image_tag(avatar || user.gravatar_url, class: "rounded-circle")
  end
end
