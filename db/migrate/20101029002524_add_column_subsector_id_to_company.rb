class AddColumnSubsectorIdToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :subsector_id, :integer
  end

  def self.down
    remove_column :companies, :subsector_id
  end
end
