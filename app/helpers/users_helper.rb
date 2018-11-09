module UsersHelper
  def avatar_for(user, param = {})
    param[:class] = "rounded-circle avatar"
    image_tag(avatar_url(user), param)
  end

  def avatar_url user, size = "100X100"
    if user.avatar.attached?
      avatar = user.avatar.variant(resize: size)
    end
    avatar.nil? ? user.gravatar_url : url_for(avatar)
  end

  def map_avatar_url user
    avatar_url user, "25x25!"
  end
end
