class AddTypeToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :category, :string
  end

  def self.down
    remove_column :questions, :category
  end
end
