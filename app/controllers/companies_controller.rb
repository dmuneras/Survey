# -*- coding: undecided -*-
class CompaniesController < ApplicationController
  
  before_filter :company_logged?, :except => [:index, :new, :create]
  before_filter :admin_logged?, :only => :index

  def index
    @companies = Company.all
  end
 
  def show_users
    @company = Company.find(params[:id])
    @users = @company.users
  end
 
  def show
    @company = Company.find(params[:id])
  end
  
  def new
    @company = Company.new
  end
  
  def create
    @company = Company.new(params[:company])
    if @company.save
      session[:current_company] = @company
      flash[:notice] = "La empresa #{@company.name} ha ingresado al sistema."
      redirect_to @company
    else
      render :action => 'new'
    end
  end
  
  def edit
    @company = Company.find(params[:id])
  end
  
  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      flash[:notice] = "Se han actualizado los datos de #{@company.name}."
      redirect_to @company
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    @company.users.destroy
    session[:current_company] = nil
    flash[:notice] = "Se ha eliminado la empresa."
    redirect_to root_url
  end

end
