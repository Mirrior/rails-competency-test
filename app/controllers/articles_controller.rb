class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :guest_redirect, only: [:show]
  access all: [:index, :home], user: {except: [:destroy, :new, :create, :edit, :update]}, editor: :all
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  def home
    @articles = Article.all
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
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    if article_created_by_current_editor?
      respond_to do |format|
        if @article.update(article_params)
          format.html { redirect_to @article, notice: 'Article was successfully updated.' }
          format.json { render :show, status: :ok, location: @article }
        else
          format.html { render :edit }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    else
      format.html { redirect_to @article, notice: 'Article was not updated.' }
      format.json { render :show, status: :ok, location: @article }
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    if article_created_by_current_editor?
      @article.destroy
      respond_to do |format|
        format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
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
      params.require(:article).permit(:title, :content, :user_id)
    end

    def category
      Article.category
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
