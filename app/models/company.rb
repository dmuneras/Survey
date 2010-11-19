class Company < ActiveRecord::Base
  has_many :users , :dependent => :destroy
  belongs_to :subsector

end
