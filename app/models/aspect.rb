class Aspect < ActiveRecord::Base
  has_many :questions, :dependent => :destroy 
  attr_accessible :number, :name
end
