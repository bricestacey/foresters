class RecordsController < ApplicationController
  def index
    if params[:search] || params[:court_name]
      facets_fields = {court_name: params[:court_name]}.reject {|k,v| v.nil?}
      @records = Record.search params[:search],
        page: params[:page],
        conditions: facets_fields,
        star: true,
        per_page: 100
      @facets = @records.facets
    else
      @records = Record.includes(:court).page params[:page]
      @facets = Record.facets
    end
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
