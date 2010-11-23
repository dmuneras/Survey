# -*- coding: utf-8 -*-
class SurveysController < ApplicationController
  def index
    session[:current_question] = 0
    session[:answers] = ""
  end
  
  def show
    session[:answers] += params[:answer] + ';' if params[:answer]
    @question = Question.find_by_number(next_question)
    redirect_to :controller => :survey_records, :action => 'new' unless @question
  end
  
  def next_question
    session[:current_question] += 1
  end

  def new
    @survey = Survey.new
  end
  
  def create
    session[:answers] += params[:answer] + ','
    render :action => 'show'
    # if params[:number] == session[:current_question]
    #   session[:answers] += params[:answer]      
    #   render :action => 'show'
    # else
    #   flash[:notice] = "¡Oigan a este!"
    # end    
  end
  
  def edit
    @survey = Survey.find(params[:id])
  end
  
  def update
    @survey = Survey.find(params[:id])
    if @survey.update_attributes(params[:survey])
      flash[:notice] = "Successfully updated survey."
      redirect_to @survey
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
    flash[:notice] = "Successfully destroyed survey."
    redirect_to surveys_url
  end
end
