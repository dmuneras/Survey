class CreateSubsectors < ActiveRecord::Migration
  def self.up
    create_table :subsectors do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :subsectors
  end
end
