class CreateCompanyRoles < ActiveRecord::Migration
  def self.up
    create_table :company_roles do |t|
      t.string :role
      t.integer :hierarchy
      t.timestamps
    end
  end

  def self.down
    drop_table :company_roles
  end
end
