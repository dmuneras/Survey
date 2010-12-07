class AddSurveyIdToSurveyRecord < ActiveRecord::Migration
  def self.up
    add_column :survey_records, :survey_id, :integer
  end

  def self.down
    remove_column :survey_records, :survey_id
  end
end
