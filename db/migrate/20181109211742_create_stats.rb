class CreateStats < ActiveRecord::Migration[5.2]
  def change
    create_table :stats do |t|
      t.integer :competition_id
      t.integer :user_id
      t.integer :calories
      t.integer :steps
      t.integer :miles
      t.datetime :recorded_at

      t.timestamps
    end
  end
end
