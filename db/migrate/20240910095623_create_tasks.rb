class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.datetime :deadline
      t.boolean :completed
      t.integer :priority

      t.timestamps
    end
  end
end
