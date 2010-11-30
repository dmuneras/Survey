class CompanySessionsController < ApplicationController
  def new
    @company_session = CompanySession.new
  end
  
  def create
    @company_session = CompanySession.new(params[:company_session])
    if @company_session.save
       @current_company = Company.find_by_login(@company_session.login)
       session[:current_company] = @current_company.id 
       flash[:notice] = "Has ingresado a editar la compañia, si desea llenar la encuesta debe salir de la compañia"
       redirect_to @current_company
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @company_session = CompanySession.find(params[:id])
    @company_session.destroy
    session[:current_company] = nil
    flash[:notice] = "Has terminado la edición de la compañia"
    redirect_to root_url
  end
end
