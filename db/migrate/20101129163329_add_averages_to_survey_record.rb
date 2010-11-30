class AddAveragesToSurveyRecord < ActiveRecord::Migration
  def self.up
    add_column :survey_records, :averages, :string
  end

  def self.down
    remove_column :survey_records, :averages
  end
end
