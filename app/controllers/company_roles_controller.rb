class CompanyRolesController < ApplicationController
  def index
    @company_roles = CompanyRole.all
  end
  
  def show
    @company_role = CompanyRole.find(params[:id])
  end
  
  def new
    @company_role = CompanyRole.new
  end
  
  def create
    @company_role = CompanyRole.new(params[:company_role])
    if @company_role.save
      flash[:notice] = "Successfully created company role."
      redirect_to @company_role
    else
      render :action => 'new'
    end
  end
  
  def edit
    @company_role = CompanyRole.find(params[:id])
  end
  
  def update
    @company_role = CompanyRole.find(params[:id])
    if @company_role.update_attributes(params[:company_role])
      flash[:notice] = "Successfully updated company role."
      redirect_to @company_role
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @company_role = CompanyRole.find(params[:id])
    @company_role.destroy
    flash[:notice] = "Successfully destroyed company role."
    redirect_to company_roles_url
  end
end
