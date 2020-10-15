class StaticPagesController < ApplicationController
  def home
    @datasets = Dataset.all

    years = Dataset.years
    @chart_energies = Dataset.month_energies_average
    @num_people_av = User.average(:num_of_people)
    # @chart_energies_avg = Dataset.city_energies_average(params[:id])
    # @chart_daylights = Dataset.city_daylight(params[:id])
  end
end
