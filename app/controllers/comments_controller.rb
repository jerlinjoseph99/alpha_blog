class CommentsController < ApplicationController
    
    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.build(comment_params)
        @comment.user = current_user
        
        if @comment.save
           flash[:success] = "Comment was added successfully" 
           
        else
           flash.now[:error] =  "Comment was not created"
        end
        
        redirect_to article_path(@article)
    end
    
    private
    def comment_params
        params.require(:comment).permit(:body) 
    end
end
