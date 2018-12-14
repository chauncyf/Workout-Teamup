class ActivityContentsController < ApplicationController
  before_action :set_activity_content, only: [:show, :edit, :update, :destroy]

  # GET /activity_contents
  # GET /activity_contents.json
  def index
    @activity_contents = ActivityContent.all
  end

  # GET /activity_contents/1
  # GET /activity_contents/1.json
  def show
  end

  # GET /activity_contents/new
  def new
    @activity_content = ActivityContent.new
  end

  # GET /activity_contents/1/edit
  def edit
  end

  # POST /activity_contents
  # POST /activity_contents.json
  def create
    @activity_content = ActivityContent.new(activity_content_params)

    respond_to do |format|
      if @activity_content.save
        format.html { redirect_to @activity_content, notice: 'Activity content was successfully created.' }
        format.json { render :show, status: :created, location: @activity_content }
      else
        format.html { render :new }
        format.json { render json: @activity_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activity_contents/1
  # PATCH/PUT /activity_contents/1.json
  def update
    respond_to do |format|
      if @activity_content.update(activity_content_params)
        format.html { redirect_to @activity_content, notice: 'Activity content was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity_content }
      else
        format.html { render :edit }
        format.json { render json: @activity_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activity_contents/1
  # DELETE /activity_contents/1.json
  def destroy
    @activity_content.destroy
    respond_to do |format|
      format.html { redirect_to activity_contents_url, notice: 'Activity content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity_content
      @activity_content = ActivityContent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_content_params
      params.require(:activity_content).permit(:activity_id, :sport_option, :customize_sport, :quantity, :quan_unit, :duration, :dur_unit, :equipment, :strength, :suggestion, :alert)
    end
end
