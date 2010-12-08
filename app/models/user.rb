class User < ActiveRecord::Base
  include ApplicationHelper
  validates_associated :company
  belongs_to :company
  has_many :survey_records, :dependent => :destroy
  acts_as_authentic  

  def full_name 
    [name,last_name].join(" ") 
  end

  def last_surveys (number)
    SurveyRecord.find_all_by_user_id(id, :conditions => {:survey_id => Survey.main_survey.id} , :order => 'created_at DESC', :limit => number)
  end

  def main_survey_records
    survey = Survey.main_survey
    SurveyRecord.all(:conditions => {:survey_id => survey.id, :user_id => self.id})
  end

  def total_average
    vals = []
    for record in self.main_survey_records do
      averages = record.averages.split(';')
      (0...Aspect.count).zip(averages) do |asp, avg|
        vals[asp] ||= 0
        vals[asp] += avg.to_f
      end
    end
    vals.map{|avg| avg /= self.main_survey_records.size} 
  end

end
