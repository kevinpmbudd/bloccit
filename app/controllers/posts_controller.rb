class PostsController < ApplicationController
  def index
    @posts = Post.all

    @posts.each do |post|
      if post.id % 5 == 1
        post.update(title: "SPAM")
      end
    end
  end

  def show
  end

  def new
  end

  def edit
  end
end
