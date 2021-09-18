class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.user_id = current_user.id
    @post_comment.post_id = @post.id
    if @post_comment.save
      flash[:notice] = 'コメントしました'
      redirect_to post_path(@post)
    else
      @post = Post.find(params[:post_id])
      @post_comments = PostComment.where(post_id: @post.id)
      render 'posts/show', id: params[:post_id]
    end
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    flash[:notice] = 'コメントを削除しました'
    redirect_to post_path(post_comment.post)
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
