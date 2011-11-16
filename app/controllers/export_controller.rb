require 'csv'

class ExportController < ApplicationController
  RESOURCES = %w(address beneficiary court name record transfer)

  def index
  end

  def export
    if RESOURCES.include? params[:resource]
      @resource = params[:resource].camelize.constantize
      to_csv(@resource.all, "#{params[:resource]}.csv")
    else
      flash.now[:error] = 'There was a problem exporting your data'
      render :index
    end
  end

  private
  def to_csv(records, filename)
    csv_string = CSV.generate do |csv|
      # header
      csv << records.map(&:attributes).map(&:keys).first

      records.each do |record|
        csv << record.attributes.values
      end
    end

    send_data(csv_string, type: 'text/csv', filename: filename)
  end
end
