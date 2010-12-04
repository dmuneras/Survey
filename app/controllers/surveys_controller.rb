# -*- coding: utf-8 -*-
class SurveysController < ApplicationController

  before_filter :is_logged?
  
  def index
    session[:answers] = []
  end
  
  def show
    @aspects = Aspect.all
    if params[:question]
      current_question = Question.find(params[:question])
      assign_answer_to current_question
      @question = Question.find_by_number(next_question_of current_question)
    else
      @question = Question.find_by_number(1)
    end
    if @question
      if @question.category == 'nested'
        @subquestions = @question.subquestions
      end
      if @question.category == 'scale'
        @scale = @question.question_scale
      end
      @answers = @question.answers.sort{|a,b| a.number <=> b.number}
    else
      redirect_to new_survey_record_path
    end    
  end
  
  def assign_answer_to(question)
    session[:answers][question.number-1] = params[:answer]
  end

  def next_question_of(question)
    question.number + 1
  end

  def new
    @survey = Survey.new
  end
  
  def create
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
