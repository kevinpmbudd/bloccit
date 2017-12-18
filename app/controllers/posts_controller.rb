class PostsController < ApplicationController
  before_action :require_sign_in, except: :show

  def show
    @post = Post.find_by(id: params[:id])
  end

  def new
    @topic = Topic.find_by(id: params[:topic_id])
    @post = Post.new
  end

  def create
    @topic = Topic.find_by(id: params[:topic_id])
    @post = @topic.posts.build( post_params )
    @post.user = current_user

    if @post.save
      @post.update(title: "SPAM") if @post.id % 5 == 0
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.assign_attributes( post_params )

    if @post.save
      flash[:notice] = "Post was updated"
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post."
      render :edit
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])

    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end

  private
    def post_params
      params.require(:post).permit(:title,:body)
    end
end
