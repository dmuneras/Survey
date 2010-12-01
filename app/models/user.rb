class User < ActiveRecord::Base
  validates_associated :company
  belongs_to :company
  has_many :survey_records, :dependent => :destroy
  acts_as_authentic  
  validates_presence_of :username

  def full_name 
    [name,last_name].join(" ") 
  end
end
