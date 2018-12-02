class UsersController < ApplicationController
  include UsersHelper, ApplicationHelper
  before_action :set_user, only: [:show, :edit, :edit_password, :update, :destroy, :edit_avatar, :upload_avatar, :user_avatar_url]

  def join_activity
    ActivityParticipant.create(user_id: current_user.id, activity_id: params[:activity_id], identity: 2)
    flash[:success] = 'Activity joined!'
    redirect_to root_path
  end

  def joined_activities
    @activities_joined = current_user.activities
    @activities_started = Activity.where(starter_id: current_user)
  end

  def follow
    Follow.create(followee_id: params[:followee_id], follower_id: current_user.id)
  end

  def unfollow
    follow_id = Follow.find_by(followee_id: params[:followee_id], follower_id: current_user.id).id
    Follow.destroy(follow_id)
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
    @user = User.find(params[:id])
    if params[:op] == 'showButton'
      render 'show', layout: false
    end
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
    @user = User.new({user_name: user_params[:user_name], email: user_params[:email], password: user_params[:password], identity: 2})

    respond_to do |format|
      if @user.save
        # log_in @user

        # Tell the UserMailer to send a welcome email after save
        UserMailer.with(user: @user).confirmation_email.deliver_now

        flash[:success] = 'Welcome to Workout Teamup, please confirm your email address to finish registration.'
        format.html {redirect_to login_path}
        format.json {render :show, status: :created, location: @user}
      else
        format.html {render :new}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end


  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      log_in user
      flash[:success] = 'Welcome back, your email address has been confirmed.'
    else
      flash[:danger] = 'Your email address was already confirmed.'
    end
    redirect_to root_path
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
