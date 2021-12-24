class CommentsController < ApplicationController
  include ErrorHandler

    def create
      begin
        post = Post.find(comment_params[:post_id])
      rescue ActiveRecord::RecordNotFound
        return item_not_found('post', comment_params[:post_id])
      end
      comment = Comment.new(comment_params)
      if comment.save
        return success_response(comment, :created)
      else
        return error_response(comment)
      end
    end

  def add_likes
    begin
      comment = Comment.find(params[:comment_id])
    rescue ActiveRecord::RecordNotFound
      return item_not_found('comment', params[:post_id])
    end
    comment_likes = comment.like
    comment_likes+=1
    if comment.update!(like: comment_likes)
      render json: comment, status: 200
    else
      render json: {
      errors: "Something went wrong"
      }, status: :unprocessable_entity
    end
  end

    private

    def comment_params
      params.permit(
        :content,
        :post_id
      ).merge(user_id: current_user.id)
    end

    def success_response(comment, status = 200)
      render json: comment.as_json, status: status
    end

    def error_response(comment)
      render json: {
        errors: format_activerecord_errors(comment.errors)
      },
      status: :unprocessable_entity
    end

end