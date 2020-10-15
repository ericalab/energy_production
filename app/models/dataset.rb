class Dataset < ApplicationRecord
  belongs_to :user

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      dataset = self.find_by(id: row["id"]) || new
      dataset.label = row["Label"]
      dataset.user_id = row["user_id"]
      dataset.year = row["year"]
      dataset.month = row["month"]
      dataset.temperature = row["temperature"]
      dataset.daylight = row["daylight"]
      dataset.energy_production = row["energy_production"]

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
