class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
    unread_message = current_user.unread_message
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive data
    if data.type == 3
      chat = Chat.find(data.id)
      chat.status = 1
      chat.save
    end
  end
end
