class AddQuestionIdToSubquestion < ActiveRecord::Migration
  def self.up
    add_column :subquestions, :question_id, :integer
  end

  def self.down
    remove_column :subquestions, :question_id
  end
end
