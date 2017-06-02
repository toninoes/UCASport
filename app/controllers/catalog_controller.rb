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

  def rss
    latest
    render :layout => false
    response.headers["Content-Type"] = "application/xml; version = 1.0; charset=utf-8"
  end

  def search
    @page_title = "Buscar"
    if params[:commit] == "Buscar" || params[:q]
      @articles = Article.where 'title LIKE ?', "%#{params[:q]}%"
      unless @articles.size > 0
        flash.now[:notice] = "No se ha encontrado el artículo."
      end
    end
  end

end
