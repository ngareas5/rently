class PostsController < ApplicationController
  include ErrorHandler

  def create
    post = Post.new(post_params)
    if post.save
      return success_response(post, :created)
    else
      return error_response(post)
    end
  end


  def show
    begin
      post = Post.includes(:comments).find(params[:id])
      render json: {post: post, comments: post&.comments, comment_count: post.comments.count}
    rescue ActiveRecord::RecordNotFound
      return item_not_found('post', params[:id])
    end
  end

  def add_likes
    begin
      post = Post.find(params[:post_id])
    rescue ActiveRecord::RecordNotFound
      return item_not_found('post', params[:post_id])
    end
      post_likes = post.like
      post_likes+=1
    if post.update!(like: post_likes)
      render json: {message: "like succefully added", post: post}, status: 200
    else
      render json: {
      errors: "Something went wrong"
      }, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.permit(
    :content
    ).merge(user_id: current_user.id)
  end

  def success_response(post, status = 200)
    render json: post.as_json, status: status
  end

  def error_response(post)
    render json: {
    errors: format_activerecord_errors(post.errors)
    },
    status: :unprocessable_entity
  end

end