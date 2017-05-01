class CartController < ApplicationController
  before_filter :initialize_cart

  def add
    @article = Article.find params[:id]
    @page_title = 'Añadir Artículo'
    if request.post?
      @item = @cart.add params[:id]
      flash[:cart_notice] = "Artículo <em>#{@item.article.title}</em> añadido satisfactoriamente al carrito."
      redirect_to :controller => 'catalog'
    else
      render :controller => 'cart', :action => 'add', :template => 'cart/add'
    end
  end

  def remove
    @article = Article.find params[:id]
    @page_title = 'Eliminar Artículo'
    if request.post?
      @item = @cart.remove params[:id]
      flash[:cart_notice] = "Artículo <em>#{@item.article.title}</em> eliminado correctamente del carrito."
      redirect_to :controller => 'catalog'
    else
      render :controller => 'cart', :action => 'remove'
    end
  end

  def clear
    @page_title = 'Vaciar el carrito'
    if request.post?
      @cart.cart_items.destroy_all
      flash[:cart_notice] = "Carrito vaciado"
      redirect_to :controller => 'catalog'
    else
      render :controller => 'cart', :action => 'clear'
    end
  end
end
