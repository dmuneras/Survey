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
    @survey_record = SurveyRecord.new(params[:survey_record])
    if @survey_record.save
      flash[:notice] = "Successfully created survey record."
      redirect_to @survey_record
    else
      render :action => 'new'
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
end
