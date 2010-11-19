class AddLastSurveyToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :last_survey, :integer
  end

  def self.down
    remove_column :companies, :last_survey
  end
end
