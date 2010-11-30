class AddAveragesToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :averages, :string
  end

  def self.down
    remove_column :companies, :averages
  end
end
