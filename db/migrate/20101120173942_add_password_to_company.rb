class AddPasswordToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :crypted_password, :string
    add_column :companies, :password_salt, :string
    add_column :companies, :persistence_token, :string
  end

  def self.down
    remove_column :companies, :crypted_password
    remove_column :companies, :password_salt
    remove_column :companies, :persistence_token
  end
end
