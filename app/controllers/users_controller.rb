class UsersController < ApplicationController

  def show
    if not (current_user.nil?)
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end
  
  def new
    @company = Company.find(params[:company_id])
    @user = @company.users.build
  end

  def create
    @company = Company.find(params[:company_id])
    @user = @company.users.build(params[:user])
    @user.nit_company = @company.nit
    if @user.save
      flash[:notice] = "Successfully create user."
      redirect_to company_path(@company)
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
      flash[:notice] = "Successfully updated user."
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Successfully destroyed user."
    redirect_to root_url
  end

  private

   def verification
    @company = Company.find(params[:nit_company])
    render :layout => false
  end
  
end
