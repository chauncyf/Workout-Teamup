class MessageChannel < ApplicationCable::Channel
  def subscribed
    user = current_user
    stream_for user
    unread_message = user.unread_message
    unread_message.each do |chat|
      sender = chat.sender
      MessageChannel.broadcast_to(user, {type: 3,
                                         chat_id: chat.id,
                                         id: sender.id, count: 1, msg: {
              title: "#{sender.user_name} left you a message",
              text: chat.content, type: 'info'}})
    end

  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive data
    if data["type"] == 3
      chat = Chat.find(data["id"])
      chat.status = 1
      chat.save
    end
  end

end
