class StaticPagesController < ApplicationController
  def home
    @datasets = Dataset.all
  end
end
