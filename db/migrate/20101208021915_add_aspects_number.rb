class AddAspectsNumber < ActiveRecord::Migration
  def self.up
    aspects = Aspect.all
    (1..aspects.size).zip(aspects) do |number, aspect| 
      aspect.update_attributes(:number => number)
    end
  end

  def self.down
    
  end
end
