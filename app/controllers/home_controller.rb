class HomeController < ApplicationController
  def index
  end

  def import_csv
    uploaded_file = params[:csv_file]

    if uploaded_file.present?
      redirect_to root_path, notice: 'CSV file imported successfully'
    else
      redirect_to root_path, alert: 'No CSV file uploaded'
    end
  end
end
