class ConvertStringsToBooleansOnCompetitions < ActiveRecord::Migration[5.2]
  def change
    change_column :competitions, :miles, :boolean
    change_column :competitions, :calories, :boolean
    change_column :competitions, :steps, :boolean
  end
end
