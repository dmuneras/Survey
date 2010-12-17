# -*- coding: utf-8 -*-
class SurveyRecordsController < ApplicationController

  before_filter :is_logged?, :except => :index
  before_filter :admin_logged?, :only => :index
  
  def index
    @survey_records = SurveyRecord.evaluation
  end
 
  # Recopila datos de la última encuesta para generar una tabla en la vista.
  def show
    @survey_record = SurveyRecord.find(params[:id])
    @answers = string_to_arrays @survey_record.answers
    if @survey_record.survey == Survey.main_survey
      @questions = Question.all(:conditions => {:survey_id => Survey.main_survey.id}, :order => 'number')
    else
      @questions = Question.all(:conditions => {:survey_id => @survey_record.survey.id}, :order => 'number')
    end
  end

  # Recopila datos de las últimas 2 encuestas para generar una tabla comparativa en la vista.
  def compare
    @user = User.find(params[:id])
    @last_surveys = @user.last_surveys(2).reverse
    @last_answers = @last_surveys.inject([]) do |ans, sur|
      ans << string_to_arrays(sur.answers)
    end
    @questions = Question.all(:conditions => {:survey_id => Survey.main_survey.id}, :order => 'number')
  end
  
  def new
    @survey = Survey.find(params[:id])
    @survey_record = SurveyRecord.new
  end
  
  # Crea un nuevo registro de SurveyRecord para el usuario que acaba de realizar la encuesta.
  # Las respuestas se encuentran en la variable de sesión session[:answers]
  # Si se crea el registro con éxito, se calculan los nuevos promedios generales para la compañía.
  def create
    current_survey = Survey.find(params[:survey])
    if current_survey.is_main_survey
      if session[:answers].empty?
        flash[:notice] = "No ha llenado la encuesta"
        redirect_to root_url
        return
      end
      aspect_avg = []
      ans_to_save = []
      @questions = Question.main_questions
      @answers = session[:answers]
      @answers.zip(@questions) do |answer, question|
        aspect_number = question.aspect.number
        aspect_avg[aspect_number-1] ||= 0
        if question.category == 'unique' || question.category == 'scale'
          aspect_avg[aspect_number-1] += Answer.find(answer).value.to_f
          ans_to_save << answer
        elsif question.category == 'multiple'
          if answer
            aspect_avg[aspect_number -1] += answer.count * 5 / question.answers.count            
             ans_to_save << answer.join(',')
          else
            ans_to_save << ''
          end
        elsif question.category == 'nested'
          avg = 0
          answer.values.each {|sub_answer| avg += Answer.find(sub_answer).value.to_f}
          aspect_avg[aspect_number-1] = avg / question.subquestions.count
          ans_to_save << answer.values.join(',')
        end 
      end
      aspects = Aspect.all(:order => 'number')
      avg_to_save = aspects.inject([]) {|averages, aspect| averages << aspect_avg[aspect.number-1] / aspect.questions.count}
      
      
      avg_to_save = avg_to_save.join(';')
      ans_to_save = ans_to_save.join(';')
      
      @survey_record = SurveyRecord.new(:user_id => current_user.id,
                                        :answers => ans_to_save,
                                        :averages => avg_to_save,
                                        :comment => params[:comment],
                                        :survey_id => params[:survey])
      if @survey_record.save
        current_user.company.calculate_company_averages
        session[:answers] = []
      else
        flash[:notice] = 'Error al almacenar los resultados'      
      end    
      redirect_to :controller => :chart, :action => :index, :id => "user_#{current_user.id}"
    else
      ans = ""
      for answer in session[:answers] do
         ans << "#{answer};"
       end
      @survey_record = SurveyRecord.new(:user_id => current_user.id,:answers => ans, 
                                        :survey_id => params[:survey], :comment => params[:comment] )
      if @survey_record.save
        redirect_to root_url
        flash[:notice] = "Gracias por ayudarnos a mejorar."
      else
        redirect_to :back
      end
    end
  end

  
  def edit
    @survey_record = SurveyRecord.find(params[:id])
  end
  
  def update
    @survey_record = SurveyRecord.find(params[:id])
    if @survey_record.update_attributes(params[:survey_record])
      flash[:notice] = "Successfully updated survey record."
      redirect_to @survey_record
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @survey_record = SurveyRecord.find(params[:id])
    @survey_record.destroy
    flash[:notice] = "Successfully destroyed survey record."
    redirect_to survey_records_url
  end

  def grabage
    
        # for answer in session[:answers] do
      #   if answer.class == Array
      #     ans = Answer.find(answer.first)
      #     aspect = ans.question.aspect
      #     aspect_avg[aspect.number-1] ||= 0
      #     aspect_avg[aspect.number-1] += answer.size * 5 / Answer.count(:conditions => {:question_id => ans.question_id})
      #     ans_to_save << answer.join(',')
      #   elsif answer.class == HashWithIndifferentAccess
      #     aspect = Answer.find(answer.first.second).question.aspect
      #     aspect_avg[aspect.number-1] ||= 0
      #     ans = []
      #     sub_avg = 0
      #     answer.each do |sub,a|
      #       sub_avg += Answer.find(a).value
      #       ans << a
      #     end
      #     sub_avg /= ans.size
      #     aspect_avg[aspect.number-1] += sub_avg
      #     ans_to_save << ans.join(',')
      #   elsif answer
      #     ans = Answer.find(answer)
      #     aspect_avg[ans.question.aspect.number-1] ||= 0
      #     aspect_avg[ans.question.aspect.number-1] += ans.value
      #     ans_to_save << answer
      #   else 
      #     ans_to_save << ''
      #   end
  end

end
