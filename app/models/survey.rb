class Survey < ActiveRecord::Base
  has_many :questions, :order => 'number'
  has_many :survey_records
  attr_accessible :name

  def is_main_survey
    self == Survey.main_survey
  end

  def self.main_survey
    Survey.find_by_name('Principal')
  end

  def to_param
    "#{self.id}-#{self.name}"
  end
  
end
