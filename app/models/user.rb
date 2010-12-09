class User < ActiveRecord::Base
  include ApplicationHelper
  validates_associated :company
  belongs_to :company
  has_many :survey_records, :order => 'created_at DESC', :dependent => :destroy
  acts_as_authentic  

  def full_name 
    [name,last_name].join(" ") 
  end

  def last_surveys (number)
    self.main_survey_records(:limit => number)
  end

  def main_survey_records(conditions={})
    self.survey_records.find_all_by_survey_id(Survey.main_survey.id, conditions)
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
