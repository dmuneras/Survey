class SurveyRecordsController < ApplicationController
  def index
    @survey_records = SurveyRecord.all
  end
  
  def show
    @survey_record = SurveyRecord.find(params[:id])
  end
  
  def new
    @survey_record = SurveyRecord.new
  end
  
  def create
    aspect_avg = {}
    ans_to_save = []
    for answer in session[:answers] do
      if answer.class == Array
        ans = Answer.find(answer.first)
        aspect = ans.question.aspect_id
        aspect_avg[aspect] ||= 0
        aspect_avg[aspect] += answer.size * 100 / Answer.count(:conditions => {:question_id => ans.question_id})
        ans_to_save << answer.join(',')
      elsif answer.class == HashWithIndifferentAccess
        aspect = Answer.find(answer.first.second).question.aspect_id
        aspect_avg[aspect] ||= 0
        ans = []
        sub_avg = 0
        answer.each do |a,b|
          sub_avg += Answer.find(b).value
          ans << b
        end
        sub_avg /= ans.size
        aspect_avg[aspect] += sub_avg
        ans_to_save << ans.join(',')
      elsif answer
        ans = Answer.find(answer)
        aspect_avg[ans.question.aspect_id] ||= 0
        aspect_avg[ans.question.aspect_id] += ans.value
        ans_to_save << answer
      else 
        ans_to_save << " "
      end
    end

    avg_to_save = []
    aspect_avg.each do |a,b|
      avg = b.to_f / Question.count(:conditions => {:aspect_id => a}).to_f
      avg_to_save << "#{a},#{avg}"
    end
    
    avg_to_save = avg_to_save.join(';')
    ans_to_save = ans_to_save.join(';')

    @survey_record = SurveyRecord.create(:user_id => current_user,
                                         :answers => ans_to_save,
                                         :averages => avg_to_save,
                                         :comment => params[:comment])
    
    Company.find(User.find(current_user).company_id).calculate_company_averages
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
