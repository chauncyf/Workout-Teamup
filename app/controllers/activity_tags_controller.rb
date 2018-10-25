class ActivityTagsController < ApplicationController
  before_action :set_activity_tag, only: [:show, :edit, :update, :destroy]

  # GET /activity_tags
  # GET /activity_tags.json
  def index
    @activity_tags = ActivityTag.all
  end

  # GET /activity_tags/1
  # GET /activity_tags/1.json
  def show
  end

  # GET /activity_tags/new
  def new
    @activity_tag = ActivityTag.new
  end

  # GET /activity_tags/1/edit
  def edit
  end

  # POST /activity_tags
  # POST /activity_tags.json
  def create
    @activity_tag = ActivityTag.new(activity_tag_params)

    respond_to do |format|
      if @activity_tag.save
        format.html { redirect_to @activity_tag, notice: 'Activity tag was successfully created.' }
        format.json { render :show, status: :created, location: @activity_tag }
      else
        format.html { render :new }
        format.json { render json: @activity_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activity_tags/1
  # PATCH/PUT /activity_tags/1.json
  def update
    respond_to do |format|
      if @activity_tag.update(activity_tag_params)
        format.html { redirect_to @activity_tag, notice: 'Activity tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity_tag }
      else
        format.html { render :edit }
        format.json { render json: @activity_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activity_tags/1
  # DELETE /activity_tags/1.json
  def destroy
    @activity_tag.destroy
    respond_to do |format|
      format.html { redirect_to activity_tags_url, notice: 'Activity tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity_tag
      @activity_tag = ActivityTag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_tag_params
      params.require(:activity_tag).permit(:activity_id, :tag_id)
    end
end
