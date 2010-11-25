class CreateQuestionScales < ActiveRecord::Migration
  def self.up
    create_table :question_scales do |t|
      t.string :lower
      t.string :higher
      t.integer :question_id

      t.timestamps
    end
  end

  def self.down
    drop_table :question_scales
  end
end
