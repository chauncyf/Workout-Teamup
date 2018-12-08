class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  # GET /activities
  # GET /activities.json
  def index
    if logged_in? && current_user.identity.eql?(1)
      @activities = Activity.all
    else
      not_found
    end
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    render layout: false
  end

  def show_starter_posters
    #@activities = Activity.find_by(starter_id:current_user_id)
    redirect_to joined_activities_url

  end

  # GET /activities/new
  def new
    if request.xhr?
      @activity = Activity.new
      render layout: false
    else
      not_found
    end
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(starter_id: current_user_id, activity_date: activity_params[:activity_date], place: activity_params[:place], content: activity_params[:content], status: activity_params[:status], theme_color: activity_params[:theme_color])

    respond_to do |format|
      if @activity.save
        # @activity.save

        #  status 1 success 2 failed
        #format.js {render json: {status: 1}}
        format.html {redirect_to @activity, notice: 'Activity was successfully created.'}
        format.json {render :show, status: :created, location: @activity}
        # type 1 means new activity count means there is one more
        User.all.each do |user|
          MessageChannel.broadcast_to(user, {type: 1, count: 1, msg: {
              title: '<i class="fas fa-plus-circle"></i> New Poster',
              text: 'A new poster has been posted', type: 'info'}})
        end
        format.js {render 'users/create_activity'}

      else
        #format.js {render json: {status: 2}}
        format.html {render :new}
        format.json {render json: @activity.errors, status: :unprocessable_entity}
        format.js {render layout: false, content_type: 'text/javascript'}
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html {redirect_to @activity, notice: 'Activity was successfully updated.'}
        format.json {render :show, status: :ok, location: @activity}
      else
        format.html {render :edit}
        format.json {render json: @activity.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html {redirect_to activities_url, notice: 'Activity was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_activity
    @activity = Activity.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def activity_params
    params.require(:activity).permit(:activity_date, :place, :content, :starter_id, :status, :theme_color)
  end
end
