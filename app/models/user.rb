class User < ApplicationRecord
  has_many :dataset
  
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      user = find_by(id: row["ID"]) || new
      user.first_name = row["Firstname"]
      user.last_name = row["Lastname"]
      user.city = row["City"]
      user.num_of_people = row["num_of_people"]
      user.has_child = row["has_child"]

      # user.attributes = row.to_hash.slice(*updatable_attributes)
      user.save!
    end
  end

end
