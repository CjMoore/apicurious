class PostController < ApplicationController

  def show
    @post = HotPost.find(params)


    @comments = @post.comments
    # byebug
  end
end
