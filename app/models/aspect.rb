class Aspect < ActiveRecord::Base
  has_many :questions, :order => 'number', :dependent => :destroy 
  attr_accessible :number, :name
end
