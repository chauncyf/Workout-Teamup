class ActivityParticipantsController < ApplicationController
  before_action :set_activity_participant, only: [:show, :edit, :update, :destroy]

  # GET /activity_participants
  # GET /activity_participants.json
  def index
    if logged_in? && current_user.identity.eql?(1)
      @activity_participants = ActivityParticipant.all
    else
      not_found
    end
  end

  # GET /activity_participants/1
  # GET /activity_participants/1.json
  def show
  end

  # GET /activity_participants/new
  def new
    # todo
    @activity_participant = ActivityParticipant.new
  end

  # GET /activity_participants/1/edit
  def edit
  end

  # POST /activity_participants
  # POST /activity_participants.json
  def create
    @activity_participant = ActivityParticipant.new(activity_participant_params)

    respond_to do |format|
      if @activity_participant.save
        format.html {redirect_to @activity_participant, notice: 'Activity participant was successfully created.'}
        format.json {render :show, status: :created, location: @activity_participant}
      else
        format.html {render :new}
        format.json {render json: @activity_participant.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /activity_participants/1
  # PATCH/PUT /activity_participants/1.json
  def update
    respond_to do |format|
      if @activity_participant.update(activity_participant_params)
        format.html {redirect_to @activity_participant, notice: 'Activity participant was successfully updated.'}
        format.json {render :show, status: :ok, location: @activity_participant}
        format.js {render }
      else
        format.html {render :edit}
        format.json {render json: @activity_participant.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /activity_participants/1
  # DELETE /activity_participants/1.json
  def destroy
    @activity_participant.destroy
    respond_to do |format|
      format.html {redirect_to activity_participants_url, notice: 'Activity participant was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_activity_participant
    @activity_participant = ActivityParticipant.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def activity_participant_params
    params.require(:activity_participant).permit(:user_id, :activity_id, :identity, :rating)
  end
end
