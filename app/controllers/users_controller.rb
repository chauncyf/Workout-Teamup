class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :editPwd, :update, :destroy]

  def join_activity
    ActivityParticipant.create(participant_id: current_user.id, activity_id: params[:activity_id], identity: 2)
    flash[:success] = 'Activity joined!'

    redirect_to root_path
  end

  def joined_activities
    @activities = current_user.activities.all
    @activities = Activity.joins(:activity_participants).where("activity_participants.participant_id = #{current_user.id}")
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    render layout: false
  end

  # GET /users/1/editPwd
  def editPwd

    render layout: false
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new({user_name: user_params[:user_name], email: user_params[:email], password: user_params[:password], identity: 2})
    # if @user.save
    #   # Handle a successful save.
    #   log_in @user
    #   flash[:success] = 'Welcome to Workout Teamup'
    #   redirect_to @user
    # else
    #   render 'new'
    # end
    respond_to do |format|
      if @user.save
        log_in @user
        flash[:success] = 'Welcome to Workout TeamUp' # Todo not working
        format.html {redirect_to root_path}
        format.json {render :show, status: :created, location: @user}


      else
        format.html {render :new}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    unless user_params[:avatar].nil?
      if @user.avatar.attached?
        @user.avatar.purge
      end
      @user.avatar.attach(params[:avatar])
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
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :height, :weight, :physical_condition, :motto, :avatar)
  end
end
