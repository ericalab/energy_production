class DatasetsController < ApplicationController
  def index
    @datasets = Dataset.all
  end

  def import
    Dataset.import(params[:fileupload][:file])
    redirect_to root_url
  end

end