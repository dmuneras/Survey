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
    # aspect_average = {}
    # for answer in session[:answers] do
    #   if answer.class == Array
    #     aspect = Answer.find(answer.first).question.aspect.id
    #     aspect_average[aspect] ||= 0
    #     aspect_average[aspect] += answer.size * 100 / Question.find(Answer.find(answer.first).question_id).answers.size
    #     answer.join(',')
    #   elsif answer.class == HashWithIndifferentAccess
    #     aspect = Answer.find(answer.first.second).question.aspect.id
    #     aspect_average[aspect] ||= 0
    #     new_ans = []
    #     answer.each do |a,b|
    #       aspect_average[aspect] += Answer.find(b).value
    #       new_ans << b
    #     end
    #     answer = new_ans.join(',')
    #   else
    #     aspect_average[Answer.find(answer).question.aspect.id] ||= 0
    #     aspect_average[Answer.find(answer).question.aspect.id] += Answer.find(answer).value
    #   end
    # end
    # aspect_average.each do |a,b|
    #   b /= Aspect.find(a).questions.size
    #   logger.info("average of #{a} = #{b}")
    # end
    @survey_record = SurveyRecord.create(:user_id => current_user,
                                         :answers => session[:answers].join(';'),
                                         :comment => params[:comment])
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
