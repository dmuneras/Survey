class AnswersController < ApplicationController
  def index
    @answers = Answer.all
  end
  
  def show
    @answer = Answer.find(params[:id])
  end
  
  def new
    @answer = Answer.new
  end
  
  def create
     @answer = Answer.new(params[:answer])
    if @answer.save
      flash[:notice] = "Successfully created answer."
      redirect_to @answer
    else
      render :action => 'new'
    end
  end
  
  def edit
    @answer = Answer.find(params[:id])
  end
  
  def update
    @answer = Answer.find(params[:id])
    if @answer.update_attributes(params[:answer])
      flash[:notice] = "Successfully updated answer."
      redirect_to @answer
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    flash[:notice] = "Successfully destroyed answer."
    redirect_to answers_url
  end
end
