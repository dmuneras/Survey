class CompanySessionsController < ApplicationController
  def new
    @company_session = CompanySession.new
  end
  
  def create
    @company_session = CompanySession.new(params[:company_session])
    if @company_session.save
       session[:current_company] = @company_session
       @company = Company.find_by_login(@company_session.login)
      flash[:notice] = "Has ingresado a editar la compañia"
      redirect_to @company
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @company_session = CompanySession.find(params[:id])
    @company_session.destroy
    session[:current_company] = nil
    flash[:notice] = "Has terminado la edicion de la compañia"
    redirect_to root_url
  end
end
