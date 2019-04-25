class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :guest_redirect, only: [:show]
  access all: [:index, :home], user: [:show], editor: :all
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  def home
    @web_development_articles = Article.web_development.first(3)
    @local_news_articles = Article.local_news.first(3)
    @world_news_articles = Article.world_news.first(3)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if article_created_by_current_editor?
        if @article.update(article_params)
          format.html { redirect_to @article, notice: 'Article was successfully updated.' }
          format.json { render :show, status: :ok, location: @article }
        else
          format.html { render :edit }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    respond_to do |format|
      if article_created_by_current_editor?
        @article.destroy
        format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to articles_url, notice: 'Article was not destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :user_id, :category)
    end

    def article_created_by_current_editor?
      @article.user_id === current_user.id
    end

    def guest_redirect
      if current_user.is_a?(GuestUser)
        redirect_to new_user_registration_path
      end
    end
end
