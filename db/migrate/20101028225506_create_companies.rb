class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.integer :nit
      t.string :name
      t.string :email
      t.string :telephone
      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
