class Dataset < ApplicationRecord
  belongs_to :user

  # scope :filter_year_user, -> (year, id) {where(user: id, year: year).group(:month)}
  # scope :filter_year_city, -> (year, id) {joins(:user).pluck(:city, :energy_production )}

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
  
  # def self.updatable_attributes
  #   ["id", "Label", "user_id","year", "month", "temperature", "daylight","energy_production"]
  # end

  def self.years
    self.all.pluck(:year,:energy_production)
  end

  def self.city_energies_production
    self.joins(:user).group(:city).average(:energy_production)
    # years.map {|year| [year, self.filter_year_user(year, id).sum(:energy_production)]}.to_h
  end

  def self.month_energies_average
    self.joins(:user).group(:month).average(:energy_production)
    
  #   years.map {|year| [year, self.filter_year_city(year, id).average(:energy_production)]}.to_h
  end

  def self.daylight(id)
  #   self.average(:num_of_people)
  #   # years.map {|year| [year, filter_year_city(year, id).average(:daylight)]}.to_h
  # end

  def self.chart_date
    order(month: :asc).pluck('month', 'energy_production').to_h
  end
end
