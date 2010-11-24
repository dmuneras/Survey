# -*- coding: utf-8 -*-
class SurveysController < ApplicationController

  before_filter :is_logged?
  
  def index
    session[:answers] = []
  end
  
  def show
    if params[:answer]
      @current_question = Answer.find(params[:answer]).question
      assign_answer
      @question = Question.find_by_number(next_question)
    else
      @question = Question.find_by_number(1)
    end
    if @question
      @answers = @question.answers.sort{|a,b| a.number <=> b.number}
    else
      redirect_to new_survey_record_path
    end    
  end
  
  def assign_answer
    session[:answers][@current_question.number-1] = params[:answer]
  end

  def next_question
    @current_question.number + 1
  end

  def new
    @survey = Survey.new
  end
  
  def create
    # session[:answers] += params[:answer] + ','
    # render :action => 'show'
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
