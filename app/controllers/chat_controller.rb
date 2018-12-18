class ChatController < ApplicationController

  def send_message
    user = current_user
    chat = Chat.new(send_from: current_user_id,
                    send_to: params[:target],
                    content: params[:content],
                    status: 0
    )
    chat.save
    MessageChannel.broadcast_to(User.find(params[:target]), {type: 3, chat_id: chat.id, id: current_user_id, count: 1, msg: {
        title: "#{user.user_name} just sends you a message",
        text: params[:content], type: 'info'}})
  end

  def new
    @user = User.find(params[:id])
    render 'new.html.erb', layout: false
  end
end