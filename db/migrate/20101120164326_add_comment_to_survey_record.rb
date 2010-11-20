class AddCommentToSurveyRecord < ActiveRecord::Migration
  def self.up
    add_column :survey_records, :comment, :string
  end

  def self.down
    remove_column :survey_records, :comment
  end
end
