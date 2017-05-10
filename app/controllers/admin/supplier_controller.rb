class Admin::SupplierController < Admin::AuthenticatedController
  def new
    @supplier = Supplier.new
    @page_title = 'Crear nuevo proveedor'
  end

  def create
    @supplier = Supplier.new(supplier_params)
    if @supplier.save
      flash[:notice] = "Proveedor #{@supplier.name} fue correctamente creado."
      redirect_to :action => 'index'
    else
      @page_title = 'Crear nuevo proveedor'
      render :action => 'new'
    end
  end

  def edit
    @supplier = Supplier.find(params[:id])
    @page_title = 'Editar proveedor'
  end

  def update
    @supplier = Supplier.find(params[:id])
    if @supplier.update_attributes(supplier_params)
      flash[:notice] = "Proveedor #{@supplier.name} fue correctamente actualizado"
      redirect_to :action => 'show', :id => @supplier
    else
      @page_title = 'Editar proveeedor'
      render :action => 'edit'
    end
  end

  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy
    flash[:notice] = "Proveedor correctamente eliminado #{@supplier.name}."
    redirect_to :action => 'index'
  end

  def show
    @supplier = Supplier.find(params[:id])
    @page_title = @supplier.name
  end

  def index
    @suppliers = Supplier.all
    @page_title = 'Listado de proveedores'
  end

  private
    def supplier_params
      params.require(:supplier).permit(:first_name, :last_name)
    end
end
