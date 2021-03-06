class ArticlesController < ApplicationController
  
  before_action :set_article, :only => [:show,:edit,:delete,:update, :destroy]
  before_action :authenticate_user!, :except => [:index,:show ]
  
  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was created successfully"
      redirect_to(articles_path)
    else
      flash.now[:error] = "Article has not been created"
      render :new
    end
  end
  
  def show
    @comment = Comment.new
    
    respond_to do |format|
      # some other formats like: format.html { render :show }
      format.html
      format.pdf do
        pdf = Prawn::Document.new
        
        pdf.text @article.title, :align => :center, :size => 18
        pdf.move_down 30
        pdf.text @article.body

        send_data pdf.render,
          filename: "export.pdf",
          type: 'application/pdf',
          disposition: 'inline'
      end
    end
    
  end
  
  def edit
    unless current_user == @article.user
      flash[:alert] = "You can only edit your own article."
      redirect_to root_path
    end
     
  end
  
  def update
    unless current_user == @article.user
      flash[:alert] = "You can only edit your own article."
      redirect_to root_path
    else 
      if @article.update(article_params)
        flash[:success] = "Article was updated successfully"
        redirect_to(articles_path)
      else
        flash.now[:error] = "Article has not been updated"
        render :edit
      end
    end
  end
  
  def destroy 
    unless current_user == @article.user
      flash[:alert] = "You can only delete your own article."
      redirect_to root_path
    else
      @article.delete
      flash[:success] = "Article was deleted successfully"
      redirect_to(articles_path)
    end
  end
  
  protected
  def resource_not_found
    message = "The article you are looking for could not be found" 
    flash[:alert] = message
    redirect_to root_path
  end
  
  private
  
  def article_params
    params.require(:article).permit(:title, :body)  
  end
  
  def set_article
    @article = Article.find(params[:id])
  end
end
