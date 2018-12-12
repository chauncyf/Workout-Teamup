class ChatController < ApplicationController
  def send
    MessageChannel.broadcast_to(User.find(params[:target]), {type: 3, count: 1, msg: {
        title: '<i class="fas fa-plus-circle"></i> New Messages',
        text: params[:content], type: 'info'}})
  end

  def new
    @user = User.find(params[:id])
    render layout: false
  end


end