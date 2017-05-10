class Admin::ManufacturerController < Admin::AuthenticatedController
  def new
    @manufacturer = Manufacturer.new
    @page_title = 'Crear nuevo fabricante'
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)
    if @manufacturer.save
      flash[:notice] = "Fabricante #{@manufacturer.name} ha sido creado exitosamente."
      redirect_to :action => 'index'
    else
      @page_title = 'Crear nuevo fabricante'
      render :action => 'new'
    end
  end

  def edit
    @manufacturer = Manufacturer.find(params[:id])
    @page_title = 'Editar fabricante'
  end

  def update
    @manufacturer = Manufacturer.find(params[:id])
    if @manufacturer.update_attributes(manufacturer_params)
       flash[:notice] = "Fabricante #{@manufacturer.name} ha sido actualizado exitosamente."
       redirect_to :action => 'show', :id => @manufacturer
    else
       @page_title = 'Editar Fabricante'
       render :action => 'edit'
    end
  end

  def destroy
    @manufacturer = Manufacturer.find(params[:id])
    @manufacturer.destroy
    flash[:notice] = "Fabricante borrado correctamente #{@manufacturer.name}."
    redirect_to :action => 'index'
  end

  def show
    @manufacturer = Manufacturer.find(params[:id])
    @page_title = @manufacturer.name
  end

  def index
    @manufacturers = Manufacturer.all
    @page_title = 'Listado de fabricantes'
  end

  private
    def manufacturer_params
      params.require(:manufacturer).permit(:name)
    end
end
