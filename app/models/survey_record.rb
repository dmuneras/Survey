class SurveyRecord < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  
  def date
    self.created_at.strftime("%d/%m/%Y")
  end

  
end
