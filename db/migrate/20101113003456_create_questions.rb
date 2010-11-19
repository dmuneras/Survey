class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.integer :number
      t.string :description
      t.integer :aspect_id
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
