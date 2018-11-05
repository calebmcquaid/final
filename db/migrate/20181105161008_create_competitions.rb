class CreateCompetitions < ActiveRecord::Migration[5.2]
  def change
    create_table :competitions do |t|
      t.integer :miles
      t.integer :steps
      t.integer :calories
      t.integer :time

      t.timestamps
    end
  end
end
