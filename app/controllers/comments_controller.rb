class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user_id #user_id can only be current_user

    respond_to do |format|
      if @comment.save
        format.html {redirect_to @comment, notice: 'Comment was successfully created.'}
        format.json {render :show, status: :created, location: @comment}
        format.js {render 'comments/create'}

        Activity.find(comment_params[:activity_id]).users.each do |user|
          MessageChannel.broadcast_to(user, {type: 2, id: comment_params[:activity_id], count: 1, msg: {
              title: '<i class="fas fa-plus-circle"></i> New Comment',
              text: 'Someone has commented on one of your involved activity', type: 'info'}})
        end
      else
        format.html {render :new}
        format.json {render json: @comment.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html {redirect_to @comment, notice: 'Comment was successfully updated.'}
        format.json {render :show, status: :ok, location: @comment}
      else
        format.html {render :edit}
        format.json {render json: @comment.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to comments_url, notice: 'Comment was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:activity_id, :user_id, :content, :type)
  end
end
