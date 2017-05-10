class CatalogController < ApplicationController
  before_filter :initialize_cart, :except => :show
  before_filter :require_no_user

  def show
    @article = Article.find(params[:id])
    @page_title = @article.title
  end

  def index
    @articles = Article.order("articles.id desc").includes(:suppliers, :manufacturer).paginate(:page => params[:page], :per_page => 5)
    @page_title = 'Catálogo'
  end

  def latest
    @articles = Article.latest 5
    @page_title = 'Últimos artículos'
  end
end
