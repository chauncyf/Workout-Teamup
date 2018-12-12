class UsersController < ApplicationController
  include UsersHelper
  before_action :set_user, only: [:show, :edit, :edit_password, :update, :destroy, :edit_avatar, :upload_avatar, :user_avatar_url, :profile]

  def join_activity
    User.transaction do
      if ActivityParticipant.where(user_id: current_user_id, activity_id: params[:activity_id]).any?
        @join_status = false
      else
        ActivityParticipant.create(user_id: current_user_id, activity_id: params[:activity_id], identity: 2)
        @join_status = true
        MessageChannel.broadcast_to(Activity.find(params[:activity_id]).starter,
                                    type: 1, count: 1, msg: {
            title: '<i class="fas fa-plus-circle"></i> New Friend Join!',
            text: "#{current_user.user_name} has joined your activity!", type: 'info'})
      end
    end

    render 'join_activity', locals: {join_status: @join_status}
  end

  def leave_activity
    User.transaction do
      if ActivityParticipant.where(user_id: current_user_id, activity_id: params[:activity_id]).any?
        # TODO whether or not destroy the activity
        # if ActivityParticipant.find(identity).equal?1
        #   Activity.find(activity_id: params[:activity_id]).destroy
        # end
        ActivityParticipant.where(user_id: current_user_id, activity_id: params[:activity_id]).destroy_all
        @leave_status = true
        MessageChannel.broadcast_to(Activity.find(params[:activity_id]).starter, type: 1, count: 1, msg: {
            title: '<i class="fas fa-exclamation-circle"></i> Team Member Left',
            text: "#{current_user.user_name} has left your activity", type: 'notice'})
      end
    end

    render 'join_activity.js.erb', locals: {leave_status: @leave_status, join_status: nil}
  end

  def joined_activities
    @activities_joined = current_user.activities
    @activities_started = Activity.where(starter_id: current_user)
  end

  def refresh_joined_activities
    page = params[:page]
    size = params[:size]
    @activities_joined = current_user.activities
    @activities_started = Activity.where(starter_id: current_user)
    render 'users/refresh_joined_activities'
  end

  def follow
    Follow.transaction do
      if Follow.where(followee_id: params[:followee_id], follower_id: current_user_id).size == 0
        Follow.create(followee_id: params[:followee_id], follower_id: current_user_id)
        MessageChannel.broadcast_to(User.find(params[:followee_id]), type: 1, count: 1, msg: {
            title: '<i class="fas fa-plus-circle"></i> A New Friend Started Following You!',
            text: 'What a star!', type: 'info'})
      end
    end
    render 'follow', locals: {follow_status: true, profile_id: params[:followee_id]}
  end

  def unfollow
    Follow.transaction do
      if Follow.where(followee_id: params[:followee_id], follower_id: current_user_id).any?
        Follow.where(followee_id: params[:followee_id], follower_id: current_user_id).destroy_all
        MessageChannel.broadcast_to(User.find(params[:followee_id]), type: 1, count: 1, msg: {
            title: '<i class="fas fa-exclamation-circle"></i> A Friend Stopped Following You',
            text: 'Don\' be upset!', type: 'notice'})
      end
    end
    render 'follow.js.erb', locals: {follow_status: false, profile_id: params[:followee_id]}
  end

  # GET /users
  # GET /users.json
  def index
    if logged_in? && current_user.identity.eql?(1)
      @users = User.all
    else
      not_found
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    render partial: 'user_profile_card', locals: {user: @user}
  end

  def profile
    render 'show'
  end


  # GET /users/new
  def new
    @user = User.new

    # if request.xhr?
    #   @user = User.new
    # else
    #   not_found
    # end
  end

  def upload_avatar
    if @user.avatar.attached?
      @user.avatar.purge
    end
    @user.avatar.attach params[:avatar]
  end

  def user_avatar_url
    render html: avatar_url(@user)
  end

  # GET /users/1/edit
  def edit
    render layout: false
  end

  # GET /users/1/editPwd
  def edit_password
    render layout: false
  end

  def edit_avatar
    render layout: false
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_name: user_params[:user_name], email: user_params[:email], password: user_params[:password], identity: 2)
    if @user.errors.include?(:password_confirmation)
      @user.errors.delete(:password_confirmation)
    end
    respond_to do |format|
      if @user.save
        # log_in @user

        # Tell the UserMailer to send a welcome email after save
        UserMailer.with(user: @user).confirmation_email.deliver_now

        flash[:success] = 'Welcome to Workout Teamup, please confirm your email address to finish registration.'
        format.html {redirect_to login_path}
        format.json {render :show, status: :created, location: @user}
      else
        if user_params[:password] != user_params[:password_confirmation]
          # @user.errors.add(:password_confirmation, message: "Password input two times are different")
          @user.errors.add(:password_confirmation, :invalid, message: "input different from password")
        end
        format.html {render :new}
        format.json {render json: @user.errors, status: :unprocessable_entity}
        format.js {render layout: false, content_type: 'text/javascript'}
      end
    end
  end


  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      log_in user
      @confirm_success = true
    else
      @confirm_success = false
    end
    render 'confirm_email'
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    unless user_params[:avatar].nil?
      upload_avatar
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html {redirect_to @user, notice: 'User was successfully updated.'}
        format.json {render :show, status: :ok, location: @user}
      else
        format.html {render :edit}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html {redirect_to users_url, notice: 'User was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :height, :weight, :physical_condition, :motto, :avatar, :followee_id)
  end
end
