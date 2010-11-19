class SurveyRecord < ActiveRecord::Base
  attr_accessible :user_id, :answers
  has_many :questions
end
