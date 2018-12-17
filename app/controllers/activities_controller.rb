class ActivitiesController < ApplicationController
  require 'rqrcode'
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
    @show_comment = params[:show_comment]
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
    if request.xhr?
      render layout: false
    end
  end

  # POST /activities
  # POST /activities.json
  def create
    activity_contents = params[:activity][:activity_contents]
    params = activity_params
    @activity = Activity.new(starter_id: current_user_id,
                             activity_date: params[:activity_date],
                             activity_end_time: params[:activity_end_time],
                             place: params[:place],
                             content: params[:content],
                             activity_type_id: params[:activity_type_id],
                             status: params[:status])


    respond_to do |format|
      if @activity.validate
        @activity.save
        ActivityParticipant.create(user_id: current_user_id,
                                   activity_id: @activity.id,
                                   identity: 1)
        activity_contents = JSON.parse(activity_contents)
        activity_contents.each do |content|
          ActivityContent.create(activity_id: @activity.id,
                                 sport_option: content["sport_option"],
                                 quantity: content["quantity"])

        end
        format.html {redirect_to @activity, notice: 'Activity was successfully created.'}
        format.json {render :show, status: :created, location: @activity}
        starter = @activity.starter
        starter.follower.each do |user|
          MessageChannel.broadcast_to(user, {type: 1, count: 1, msg: {
              title: "<i class='fas fa-plus-circle'></i> New Poster from #{starter.user_name}",
              text: 'A new poster has been posted', type: 'info'}})
        end
        format.js {render 'users/create_activity'}

      else
        #format.js {render json: {status: 2}}
        # unless @activity.activity_date.nil?
        #   @activity.activity_date = @activity.activity_date.strftime('%m/%d/%Y %H:%M')
        # end
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
        #remove all existed contents first
        @activity.activity_contents.destroy_all
        activity_contents = JSON.parse(params[:activity][:activity_contents])
        activity_contents.each do |content|
          ActivityContent.create(activity_id: @activity.id,
                                 sport_option: content["sport_option"],
                                 quantity: content["quantity"])
        end
        format.html {redirect_to @activity, notice: 'Activity was successfully updated.'}
        format.json {render :show, status: :ok, location: @activity}
        format.js {render 'users/create_activity'}
      else
        format.html {render :edit}
        format.json {render json: @activity.errors, status: :unprocessable_entity}
        format.js {render 'activities/create', layout: false, content_type: 'text/javascript'}
      end
    end
  end

  def like
    Activity.transaction do
      if Like.where(user_id: current_user_id, activity_id: params[:activity_id]).any?
        Like.where(user_id: current_user_id, activity_id: params[:activity_id]).first.delete
        render 'users/like_activity', locals: {like: false, login: logged_in?}
      else
        Like.create(user_id: current_user_id, activity_id: params[:activity_id])
        render 'users/like_activity', locals: {like: true, login: logged_in?}
      end
    end
  end

  def unlike
    Like.where(user_id: current_user_id, activity_id: params[:activity_id]).destroy_all
    render 'users/like_activity.js.erb', locals: {like: false, login: logged_in?}
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

  def qrcode
    if Rails.env.development?
      qrcode = RQRCode::QRCode.new("https://0.0.0.0:3000/?activity_id=#{params[:id]}")
    else
      qrcode = RQRCode::QRCode.new("https://#{request.host}/?activity_id=#{params[:id]}")
    end
    render 'qrcode.js.erb', locals: {activity_id: params[:id], qrcode: qrcode}
  end

  def canvas
    if Rails.env.development?
      qrcode = RQRCode::QRCode.new("https://0.0.0.0:3000/?activity_id=#{params[:id]}")
    else
      qrcode = RQRCode::QRCode.new("https://#{request.host}/?activity_id=#{params[:id]}")
    end
    render 'canvas.js.erb', locals: {activity_id: params[:id], qrcode: qrcode}
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_activity
    @activity = Activity.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def activity_params
    res = params.require(:activity).permit(:activity_date, :place, :content, :activity_type_id, :starter_id, :status, :activity_end_time)
    if res[:activity_date].size > 0
      res[:activity_date] = Time.strptime(res[:activity_date], '%m/%d/%Y %H:%M')
    end
    if res[:activity_end_time].size > 0
      res[:activity_end_time] = Time.strptime(res[:activity_end_time], '%m/%d/%Y %H:%M')
    end
    res
  end
end
