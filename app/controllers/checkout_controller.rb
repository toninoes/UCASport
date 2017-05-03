class CheckoutController < ApplicationController
  before_filter :initialize_cart, :only => :index # <========================== sprint 7 probar a quitar a partir de la , y quitar el oculto de index

  def index
    @order = Order.new
    @page_title = 'Pago'
    if @cart.articles.empty?
      flash[:notice] = 'Tu carrito de la compra está vacío! ' +
                       'Por favor añade al menos un artículo al carrito antes de enviar la orden.'
      redirect_to :controller => 'catalog'
    end
  end

  def submit_order
    @cart = Cart.find(params[:cart][:id]) # <========================== sprint 7 si funciona todo probar a quitar
    @order = Order.new(order_params)
    @order.ship_to_country_code = @order.ship_to_country_code.upcase
    @order.customer_ip = request.remote_ip
    @order.status = 'open'
    @page_title = 'Pago'
    populate_order

    if @order.save
      if @order.process
        flash[:notice] = 'Tu pedido ha sido recibido y será procesado inmediatamente.'
        session[:order_id] = @order.id
        @cart.cart_items.destroy_all # empty shopping cart
        redirect_to :action => 'thank_you'
      else
        flash[:notice] = "Error al enviar tu orden '#{@order.error_message}'."
        render :action => 'index'
      end
    else
      render :action => 'index'
    end
  end

  def thank_you
    @page_title = 'Gracias.'
  end

  private

  def populate_order
    for cart_item in @cart.cart_items
      order_item = OrderItem.new(:article_id => cart_item.article_id,
                                 :price => cart_item.price,
                                 :amount => cart_item.amount)
      @order.order_items << order_item
    end
  end

  def order_params
      params.require(:order).permit(:email, :phone_number, :ship_to_first_name, :ship_to_last_name, :ship_to_address, :ship_to_city, :ship_to_postal_code, :ship_to_country_code, :card_type,
      :card_expiration_month, :card_expiration_year, :card_number, :card_verification_value)
  end
end
