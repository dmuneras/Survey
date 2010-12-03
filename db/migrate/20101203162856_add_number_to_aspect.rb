class AddNumberToAspect < ActiveRecord::Migration
  def self.up
    add_column :aspects, :number, :integer
  end

  def self.down
    remove_column :aspects, :number
  end
end
