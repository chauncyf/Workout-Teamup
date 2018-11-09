module UsersHelper
  def avatar_for(user)
    image_tag(avatar_url(user), class: "rounded-circle avatar")
  end

  def avatar_url user,size="50X50"
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
