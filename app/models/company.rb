class Company < ActiveRecord::Base
  acts_as_authentic  
  has_many :users , :dependent => :destroy
  belongs_to :subsector
end
