class SubsectorsController < ApplicationController
  def index
    @subsectors = Subsector.all
  end
  
  def show
    @subsector = Subsector.find(params[:id])
  end
  
  def new
    @subsector = Subsector.new
  end
  
  def create
    @subsector = Subsector.new(params[:subsector])
    if @subsector.save
      flash[:notice] = "Successfully created subsector."
      redirect_to @subsector
    else
      render :action => 'new'
    end
  end
  
  def edit
    @subsector = Subsector.find(params[:id])
  end
  
  def update
    @subsector = Subsector.find(params[:id])
    if @subsector.update_attributes(params[:subsector])
      flash[:notice] = "Successfully updated subsector."
      redirect_to @subsector
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @subsector = Subsector.find(params[:id])
    @subsector.destroy
    flash[:notice] = "Successfully destroyed subsector."
    redirect_to subsectors_url
  end
end
