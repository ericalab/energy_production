class Dataset < ApplicationRecord
  belongs_to :user

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      user = find_by(id: row["id"]) || new
      user.attributes = row.to_hash.slice(*updatable_attributes)
      user.save
    end
  end
  
  def self.updatable_attributes
    ["id", "label", "user_id","year", "month", "temperature", "has_child", "energy_production"]
  end

  def self.chart_date
    # data = Dataset.group(:month).count
    # average_production = Dataset.group(:month).average(:energy_production)

    order(month: :asc).pluck('month', 'energy_production').to_h

  end
end
