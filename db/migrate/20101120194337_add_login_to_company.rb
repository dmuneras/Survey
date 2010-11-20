class AddLoginToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :login, :string
  end

  def self.down
    remove_column :companies, :login
  end
end
