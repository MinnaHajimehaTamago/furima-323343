class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    ActionCable.server.broadcast 'comment_channel', content: channel_params if @comment.save
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def channel_params
    params.require(:comment).permit(:text).merge(nickname: current_user.nickname)
  end
end
