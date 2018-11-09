module UsersHelper
  def avatar_for(user,param={})
    param[:class]="rounded-circle avartar"
    image_tag(avatar_url(user), param)
  end

  def avatar_url user,size="100X100"
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
