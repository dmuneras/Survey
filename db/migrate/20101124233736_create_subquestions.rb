class CreateSubquestions < ActiveRecord::Migration
  def self.up
    create_table :subquestions do |t|
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :subquestions
  end
end
