class CreateSurveyRecords < ActiveRecord::Migration
  def self.up
    create_table :survey_records do |t|
      t.integer :user_id
      t.string :answers
      t.timestamps
    end
  end

  def self.down
    drop_table :survey_records
  end
end
