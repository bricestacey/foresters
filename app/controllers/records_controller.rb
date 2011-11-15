class RecordsController < ApplicationController
  def index
    options = {}.tap do |option|
      option[:page]      = params[:page]
      option[:star]      = true
      option[:per_page]  = 100

      if params[:order]
        option[:order]     = params[:order]
        option[:sort_mode] = params[:sort_mode].blank? ? :asc : params[:sort_mode].to_sym
      else
        # Default sort is by weight, descending
        option[:order]     = '@weight DESC'
      end

      option[:conditions] = {}.tap do |condition|
        # Facets
        condition[:court_name]  = params[:court_name].gsub('/', '\/')  if params[:court_name]

        # Search query depending on index
        condition[:name_first]  = params[:search] if params[:index] == 'name_first'
        condition[:name_middle] = params[:search] if params[:index] == 'name_middle'
        condition[:name_last]   = params[:search] if params[:index] == 'name_last'
      end
    end

    @records = Record.search (params[:index] == 'keyword') ? params[:search] : '', options
    @facets = @records.facets
  end

  def show
    @record = Record.find(params[:id])
  end

  def new
    @record = Record.new
    @record.residence = @record.build_residence
    @record.names.build
  end

  def edit
    @record = Record.find(params[:id])
  end

  def create
    @record = Record.new(params[:record])

    if @record.save
      flash[:notice] = 'Record was successfully created.'
      redirect_to record_path(@record)
    else
      flash.now[:error] = 'There was a problem creating the record.'
      render :new
    end
  end

  def update
    @record = Record.find(params[:id])
    @record.attributes = params[:record]

    if @record.updated_at.to_s != params[:updated_at]
      flash[:error] = "Another user has updated this record since you've opened it. The record was not saved. Pleased try again."
      redirect_to record_path(@record)
    elsif @record.save
      flash[:notice] = 'Record was successfully updated.'
      redirect_to record_path(@record)
    else
      flash.now[:error] = 'There was a problem updating the record.'
      render :edit
    end
  end

  def destroy
    @record = Record.find(params[:id])

    if @record.destroy
      flash[:notice] = 'The record was successfully deleted.'
      redirect_to records_url
    else
      flash[:error] = 'There was a problem deleting the record.'
      redirect_to records_url
    end
  end
end
