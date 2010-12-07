# -*- coding: undecided -*-
class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end
  
  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.sort{|a,b| a.number <=> b.number}
    @aspects = Aspect.all
    if @question.category == 'nested'
      @subquestions = @question.subquestions
    elsif @question.category == 'scale'
      @scale = @question.question_scale
    end
  end

  def next
    question = Question.find(params[:question])
    assign_answer_to question
    next_question = next_question_of question
    if next_question
      redirect_to question_path(next_question)
    else
      redirect_to :controller => :survey_records, :action => :new, :id => question.survey.id
    end
  end

  def assign_answer_to(question)
    session[:answers][question.number-1] = params[:answer]
  end

  def next_question_of(question)
    question.survey.questions.find_by_number(question.number+1)
  end
  
  def new
    @question = Question.new
    1.times {@question.answers.build}
  end
  
  def create
    @question = Question.new(params[:question])
    if @question.save
      flash[:notice] = "Successfully created question."
      redirect_to @question
    else
      render :action => 'new'
    end
  end
  
  def edit
    @question = Question.find(params[:id])
  end
  
  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(params[:question])
      flash[:notice] = "Successfully updated question."
      redirect_to @question
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    flash[:notice] = "Successfully destroyed question."
    redirect_to questions_url
  end
end
