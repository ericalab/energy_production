class CreateDatasets < ActiveRecord::Migration[6.0]
  def change
    create_table :datasets do |t|
      t.integer :user_id
      t.integer :year
      t.integer :month
      t.integer :temperature
      t.integer :daylight
      t.integer :energy_production

      t.timestamps
    end
  end
end
