class MessageChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    user = current_user
    stream_for user
    unread_message = user.unread_message
    unread_message.each do |chat|
      sender = chat.sender
      MessageChannel.broadcast_to(user, {type: 3,
                                         chat_id: chat.id,
                                         id: sender.id, count: 1, msg: {
              title: "#{sender.user_name} left you a message at #{chat.created_at.strftime("%b %d, %a %H:%M")}",
              text: chat.content, type: 'info'}})
    end

  end

  def unsubscribed
    stop_all_streams
  end

  def receive data
    if data["type"] == 3
      chat = Chat.find(data["id"])
      chat.status = 1
      chat.save
    end
  end

end
