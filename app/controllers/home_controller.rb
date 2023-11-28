class HomeController < ApplicationController
  def index
  end

  def import_csv
    uploaded_file = params[:csv_file]

    if uploaded_file.present?
      Ingest.process_csv(uploaded_file)
      redirect_to root_path, notice: 'CSV file imported successfully'
    else
      redirect_to root_path, alert: 'No CSV file uploaded'
    end
  end

  def export_csv
    csv_data = Export.export_to_csv

    send_data csv_data, filename: 'exported_data.csv', type: 'text/csv'
  end
end
