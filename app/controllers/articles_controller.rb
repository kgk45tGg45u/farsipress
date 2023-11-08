class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1 or /articles/1.json
  def show
    @article = Article.find(params[:id])
    j = @article.content
    j.tr!('0123456789','۰١۲۳۴۵۶۷۸۹')
    @b = j.html_safe
    gregorian = @article.created_at.strftime("%Y, %m, %d")
    gregoriany = @article.created_at.strftime("%Y").to_i
    gregorianm = @article.created_at.strftime("%m").to_i
    gregoriand = @article.created_at.strftime("%d").to_i
    d = Date.civil(gregoriany, gregorianm, gregoriand).to_parsi
    @parsid = d.strftime "%A %d %B %Y"
    @parsid = @parsid.tr!('0123456789','۰١۲۳۴۵۶۷۸۹')

  end

  # GET /articles/new
  def new
    @article = Article.new

  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :author, :published, :category_id, :photo, :cloudinary_url)
    end

end
