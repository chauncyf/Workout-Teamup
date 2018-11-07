module UsersHelper
  def avatar_for(user)
    #gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    #gravatar_url = "http://media.minimalist.business/images/customer-profile-template/ideal-customer-profile.jpg"

    image_tag(avatar_url(user), class: "rounded-circle")
  end

  def avatar_url user,size="150X150"
    if user.avatar.attached?
      avatar = user.avatar.variant(resize: size)
    end
    avatar || user.gravatar_url
  end

  def map_avatar_url user
    url = avatar_url user,"25x25!"
    url.class == String ? url : url_for(url)
  end
end
