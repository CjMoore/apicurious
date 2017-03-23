class PostController < ApplicationController

  def show
    @post = HotPost.find(params[:post_title],
                         params[:post_url],
                         params[:post_ups],
                         params[:post_id],
                         params[:sub_name],
                         current_user.token)


    @comments = @post.comments
    # byebug
  end
end
