class ChatController < ApplicationController

  def send_message
    user = current_user
    MessageChannel.broadcast_to(User.find(params[:target]), {type: 3, id: current_user_id, count: 1, msg: {
        title: "#{user.user_name} send you a message",
        text: params[:content], type: 'info'}})
  end

  def new
    @user = User.find(params[:id])
    render layout: false
  end


end