class ArticlesController < ApplicationController
  
  before_action :set_article, :only => [:show,:edit,:delete,:update, :destroy]
  
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
    
  end
  
  def edit
     
  end
  
  def update
     
    if @article.update(article_params)
      flash[:success] = "Article was updated successfully"
      redirect_to(articles_path)
    else
      flash.now[:error] = "Article has not been updated"
      render :edit
    end
  end
  
  def destroy 
     
    @article.delete
    flash[:success] = "Article was deleted successfully"
     redirect_to(articles_path)
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
