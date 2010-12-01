class Subsector < ActiveRecord::Base
  has_many :companies, :dependent => :destroy
  attr_accessible :name
end
