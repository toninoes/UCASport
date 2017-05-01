class Admin::ArticleController < ApplicationController
  def new
    load_data
    @article = Article.new
    @page_title = 'Crear nuevo artículo'
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "El artículo #{@article.title} ha sido correctamente creado."
      redirect_to :action => 'index'
    else
      load_data
      @page_title = 'Crear nuevo artículo'
      render :action => 'new'
    end
  end

  def edit
    load_data
    @article = Article.find(params[:id])
    @page_title = 'Editar artículo'
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:notice] = "El artículo #{@article.title} ha sido correctamente actualizado."
      redirect_to :action => 'show', :id => @article
    else
      load_data
      @page_title = 'Editar artículo'
      render :action => 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Borrado correctamente el artículo #{@article.title}."
    redirect_to :action => 'index'
  end

  def show
    @article = Article.find(params[:id])
    @page_title = @article.title
  end

  def index
    sort_by = params[:sort_by]
    @articles = Article.order(sort_by).paginate(:page => params[:page], :per_page => 5)
    @page_title = 'Listado de artículos'
  end

  private

    def load_data
      @suppliers = Supplier.all
      @manufacturers = Manufacturer.all
    end

    def article_params
      params.require(:article).permit(:title, :manufacturer_id, :manufactured_at, { :supplier_ids => [] },
                                   :reference, :blurb, :price, :size, :cover_image)
    end
end
