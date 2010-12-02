class SurveyRecord < ActiveRecord::Base
  belongs_to :user
  has_many :questions

  def self.before_last_of(user)
    SurveyRecord.find_all_by_user_id(user.id, :order => 'created_at DESC')[1]
  end
  
end
