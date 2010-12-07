class Survey < ActiveRecord::Base
  has_many :questions
  attr_accessible :name

  def self.main_survey
    Survey.find_by_name('Principal')
  end
  
  def is_main_survey?
    if self  == Survey.find_by_name('Principal')
      return true
    else
      return false
    end
  end

end
