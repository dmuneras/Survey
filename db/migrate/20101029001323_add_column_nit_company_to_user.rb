class AddColumnNitCompanyToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :nit_company, :integer
  end

  def self.down
    remove_column :users, :nit_company
  end
end
