class CompanySessionsController < ApplicationController
  def new
    @company_session = CompanySession.new
  end
  
  def create
    @company_session = CompanySession.new(params[:company_session])
    session[:current_company] = @company_session
    if @company_session.save
      flash[:notice] = "Successfully created company session."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @company_session = CompanySession.find(params[:id])
    @company_session.destroy
    session[:current_company] = nil
    flash[:notice] = "Successfully destroyed company session."
    redirect_to root_url
  end
end
