class RemoveTimeColumnFromCompetition < ActiveRecord::Migration[5.2]
  def up
    remove_column :competitions, :time, :string
  end

  def down
    add_column :competitions, :time, :string
  end
end
