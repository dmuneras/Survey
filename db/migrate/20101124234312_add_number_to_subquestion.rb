class AddNumberToSubquestion < ActiveRecord::Migration
  def self.up
    add_column :subquestions, :number, :integer
  end

  def self.down
    remove_column :subquestions, :number
  end
end
