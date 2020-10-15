class User < ApplicationRecord
  has_many :dataset
  
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      user = find_by(id: row["id"]) || new
      user.first_name = row["first_name"]
      user.last_name = row["last_name"]
      user.city = row["City"]
      user.num_of_people = row["num_of_people"]
      user.has_child = row["has_child"]

      # user.attributes = row.to_hash.slice(*updatable_attributes)
      user.save!
    end
  end

  # def self.updatable_attributes
  #   ["id", "first_name", "last_name", "City", "num_of_people", "has_child"]
  # end
end
