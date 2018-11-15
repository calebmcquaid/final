class ConvertStringsToBooleansOnCompetitions < ActiveRecord::Migration[5.2]
  def up
    change_column :competitions, :miles, :boolean
    change_column :competitions, :calories, :boolean
    change_column :competitions, :steps, :boolean
  end

  def down
    change_column :competitions, :miles, :string
    change_column :competitions, :calories, :string
    change_column :competitions, :steps, :string
  end
end
