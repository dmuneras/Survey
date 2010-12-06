class User < ActiveRecord::Base
  include ApplicationHelper
  validates_associated :company
  belongs_to :company
  has_many :survey_records, :dependent => :destroy
  acts_as_authentic  
  # validates_presence_of :username, :name, :last_name, :phone
  # validates_uniqueness_of :username

  def full_name 
    [name,last_name].join(" ") 
  end

  def last_surveys (number)
    SurveyRecord.find_all_by_user_id(id, :order => 'created_at DESC', :limit => number)
  end

  def total_average
    vals = {}
    for record in survey_records do
      averages = string_to_hash record.averages
      averages.each do |asp, avg|
        vals[asp] ||= 0
        vals[asp] += avg
      end
    end
    vals.each{|asp, avg| vals[asp] = avg / survey_records.size}
    return vals 
  end

end
