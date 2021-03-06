# -*- coding: utf-8 -*-
# Controlador para las preguntas de una encuesta.
class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end
  
  # Recopila datos de la pregunta solicitada.
  # Se genera en la vista con base en su tipo ('category')
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

  # Verifica que se haya dado una repuesta correcta a la pregunta actual para almacenar la respuesta en la variable de sesión session[:answers] 
  # Si es así, busca la siguiente pregunta y redirecciona a la acción 'show' de la misma.
  # De lo contrario, redirecciona nuevamente a la pregunta actual.
  def next
    question = Question.find(params[:question])
    if question.category == 'unique' or question.category == 'scale'
      unless params[:answer]
        flash[:error] = "Debe seleccionar alguna respuesta."
        redirect_to question_path(question)
        return 
      end
    end
    if question.category == 'nested'
      unless params[:answer] and params[:answer].count == question.subquestions.count
        flash[:error] = "Debe contestar todas las preguntas."
        redirect_to question_path(question)
        return
      end 
    end
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
