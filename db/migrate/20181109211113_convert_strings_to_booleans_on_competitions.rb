class ConvertStringsToBooleansOnCompetitions < ActiveRecord::Migration[5.2]
  def up
    remove_column :competitions, :miles, :integer
    add_column :competitions, :miles, :boolean

    remove_column :competitions, :calories, :boolean
    add_column :competitions, :calories, :boolean

    remove_column :competitions, :steps, :boolean
    add_column :competitions, :steps, :boolean
  end
end
