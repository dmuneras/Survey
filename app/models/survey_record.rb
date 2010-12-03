class SurveyRecord < ActiveRecord::Base
  belongs_to :user
  has_many :questions

  def created_at
    super.strftime("%d/%m/%Y")
  end

  
end
