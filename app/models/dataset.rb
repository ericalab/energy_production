class Dataset < ApplicationRecord
  belongs_to :user

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      dataset = self.find_by(id: row["ID"]) || new
      dataset.label = row["Label"]
      dataset.user_id = row["House"]
      dataset.year = row["Year"]
      dataset.month = row["Month"]
      dataset.temperature = row["Temperature"]
      dataset.daylight = row["Daylight"]
      dataset.energy_production = row["EnergyProduction"]

      # dataset.attributes = row.to_hash.slice(*updatable_attributes)
      dataset.save!
    end
  end

  def self.month_energies_average
    self.joins(:user).group(:month).average(:energy_production)
  end

  def self.city_daylight
    self.joins(:user).group(:city).average(:daylight)
  end
end
