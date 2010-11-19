class User < ActiveRecord::Base
  validates_associated :company
  belongs_to :company
  acts_as_authentic  
  validates_presence_of :username
end
