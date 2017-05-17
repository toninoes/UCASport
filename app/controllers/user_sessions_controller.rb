class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]

  def new
    @user_session = UserSession.new
    @page_title = 'Inicio de sesión'
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    @user_session.remember_me = false
    @page_title = 'Inicio de sesión'
    if @user_session.save
      flash[:notice] = "Sesión iniciada correctamente."
      redirect_back_or_default :controller => '/admin/supplier', :action => :index
    else
      render :action => :new
    end
  end

  def destroy
    if current_user_session
      current_user_session.destroy
      flash[:notice] = "Sesión cerrada correctamente."
    end
    redirect_to :controller => :catalog, :action => :index
  end

  private
    def user_session_params
      params.require(:user_session).permit(:login, :password, :remember_me)
    end
end
