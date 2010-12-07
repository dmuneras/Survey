class Survey < ActiveRecord::Base
  has_many :questions
  attr_accessible :name

  def self.is_main_survey(s)
   main = Survey.find_by_name('Principal')
   if main == s
     return true
   else
     return false
   end
  end

  def self.main_survey
    Survey.find_by_name('Principal')
  end
  
end
