class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new( params_for_post )

    if @post.save
      @post.update(title: "SPAM") if @post.id % 5 == 0
      flash[:notice] = "Post was saved."
      redirect_to @post
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
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    if @post.save
      flash[:notice] = "Post was updated"
      redirect_to @post
    else
      flash.now[:alert] = "There was an error saving the post."
      render :edit
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])

    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to posts_path
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end

  private
  def params_for_post
    params.require(:post).permit(:title,:body)
  end
end
