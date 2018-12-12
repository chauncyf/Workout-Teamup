class ChatController < ApplicationController
  def send_message
    MessageChannel.broadcast_to(User.find(params[:target]), {type: 3,id: current_user_id, count: 1, msg: {
        title: '<i class="fas fa-plus-circle"></i> New Messages',
        text: params[:content], type: 'info'}})
  end

  def new
    @user = User.find(params[:id])
    render layout: false
  end


end