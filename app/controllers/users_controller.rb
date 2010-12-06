# -*- coding: utf-8 -*-
class UsersController < ApplicationController

  def show
    if current_user
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end
  
  def new
    @company = Company.find(params[:company_id])
    if @company.users.count >= 5
      flash[:notice] = "No puede crear más de 5 usuarios. Para registrar un nuevo usuario debe eliminar alguno de los existentes."
      redirect_to show_users_company_path(@company)
    else
      @user = @company.users.build
    end
  end

  def create
    @company = Company.find(params[:company_id])
    @user = @company.users.build(params[:user])
    @user.nit_company = @company.nit
    if @user.save_without_session_maintenance
      flash[:notice] = "Se ha creado un nuevo usuario llamado #{@user.full_name}."
      redirect_to show_users_company_path(@company) 
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Los datos de #{@user.full_name} han sido actualizados."
      redirect_to @user
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Se ha eliminado el usuario."
    redirect_to :back
  end

  private

   def verification
    @company = Company.find(params[:nit_company])
    render :layout => false
  end
  
end
