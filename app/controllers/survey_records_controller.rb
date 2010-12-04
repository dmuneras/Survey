class SurveyRecordsController < ApplicationController
  def index
    @survey_records = SurveyRecord.all
  end
  
  def show
    @survey_record = SurveyRecord.find(params[:id])
    @answers = @survey_record.answers.split(';').map{|ans| ans.split(',')}
  end

  def compare
    @user = User.find(params[:id])
    @last_surveys = @user.last_surveys 2
    @last_answers = []
    @last_answers << @last_surveys.last.answers.split(';').map{|ans| ans.split(',')}
    @last_answers << @last_surveys.first.answers.split(';').map{|ans| ans.split(',')}
    @questions = Question.all(:order => 'number')
  end
  
  def new
    @survey_record = SurveyRecord.new
  end
  
  def create
    aspect_avg = []
    ans_to_save = []
    for answer in session[:answers] do
      if answer.class == Array
        ans = Answer.find(answer.first)
        aspect = ans.question.aspect
        aspect_avg[aspect.number-1] ||= 0
        aspect_avg[aspect.number-1] += answer.size * 5 / Answer.count(:conditions => {:question_id => ans.question_id})
        ans_to_save << answer.join(',')
      elsif answer.class == HashWithIndifferentAccess
        aspect = Answer.find(answer.first.second).question.aspect
        aspect_avg[aspect.number-1] ||= 0
        ans = []
        sub_avg = 0
        answer.each do |sub,a|
          sub_avg += Answer.find(a).value
          ans << a
        end
        sub_avg /= ans.size
        aspect_avg[aspect.number-1] += sub_avg
        ans_to_save << ans.join(',')
      elsif answer
        ans = Answer.find(answer)
        aspect_avg[ans.question.aspect.number-1] ||= 0
        aspect_avg[ans.question.aspect.number-1] += ans.value
        ans_to_save << answer
      else 
        ans_to_save << ''
      end
    end

    avg_to_save = []
    1.upto(aspect_avg.size) do |i|
      aspect_id = Aspect.find_by_number(i).id
      avg = aspect_avg[i-1] / Question.count(:conditions => {:aspect_id => aspect_id}).to_f
      avg_to_save << "#{aspect_id},#{avg}"
    end
    
    avg_to_save = avg_to_save.join(';')
    ans_to_save = ans_to_save.join(';')

    @survey_record = SurveyRecord.new(:user_id => current_user.id,
                                      :answers => ans_to_save,
                                      :averages => avg_to_save,
                                      :comment => params[:comment])
    if @survey_record.save
      current_user.company.calculate_company_averages
      session[:answers] = []
    else
      flash[:notice] = 'Error al almacenar los resultados'      
    end    
    redirect_to :action => :index
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
end
