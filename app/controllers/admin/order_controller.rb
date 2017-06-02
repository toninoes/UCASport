class Admin::OrderController < Admin::AuthenticatedController
  def close
    order = Order.find(params[:id])
    order.close
    flash[:notice] = "La orden ##{order.id} ha sido cerrada."
    redirect_to :action => 'index'
  end

  def show
    @order = Order.find(params[:id])
    @page_title = "Mostrando pedido ##{@order.id}"
  end

  def index
    @status = params[:id]
    if @status.blank?
      @status = ''
      conditions = nil
    else
      conditions = "status = '#{@status}'"
    end
    @orders = Order.where(conditions).paginate(:page => params[:page], :per_page => 10)

    if @status == 'open'
      @status = 'abiertos'
    elsif @status == 'processed'
      @status = 'procesados'
    elsif @status == 'closed'
      @status = 'cerrados'
    elsif @status == 'failed'
      @status = 'fallidos'
    end

    @page_title = "Mostrando pedidos #{@status}"
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    flash[:notice] = "La orden ##{@order.id} fue borrada correctamente."
    redirect_to :action => 'index'
  end
end
