class SurveyRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey
  has_many :questions
  named_scope :evaluation, :conditions => ["survey_id = ?", 2]  
  def date
    self.created_at.strftime("%d/%m/%Y %H:%M:%S")
  end

  
end
