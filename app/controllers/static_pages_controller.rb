class StaticPagesController < ApplicationController
  def home
    @datasets = Dataset.all
    @chart_energies = Dataset.month_energies_average
    @num_people_av = User.average(:num_of_people)
    @city_daylight = Dataset.city_daylight
  end
end
