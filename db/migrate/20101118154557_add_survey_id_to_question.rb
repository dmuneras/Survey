class AddSurveyIdToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :survey_id, :integer
  end

  def self.down
    remove_column :questions, :survey_id
  end
end
