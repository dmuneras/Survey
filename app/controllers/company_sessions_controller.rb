# -*- coding: utf-8 -*-
class CompanySessionsController < ApplicationController
  def new
    @company_session = CompanySession.new
  end
  
  def create
    @company_session = CompanySession.new(params[:company_session])
    if @company_session.save
      @current_company = Company.find_by_login(@company_session.login)
       session[:current_company] = @current_company.id 
       if @current_company.login == 'eafit'
         flash[:notice] = "Bienvenido administrador del sitio. Eres todapoderosa"
         redirect_to companies_path
       else
         flash[:notice] = "Ha ingresado a editar la compañía. Si desea llenar la encuesta debe salir de la compañía"
         redirect_to @current_company
       end
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @company_session = CompanySession.find(params[:id])
    @company_session.destroy
    session[:current_company] = nil
    flash[:notice] = "Ha terminado la edición de la compañia"
    redirect_to root_url
  end
  
end
