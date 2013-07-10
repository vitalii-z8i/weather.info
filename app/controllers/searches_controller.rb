class SearchesController < ApplicationController
  # GET /searches
  # GET /searches.json
  def index
    @searches = Search.all
    @search = Search.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @searches }
    end
  end

  # POST /searches
  # POST /searches.json
  def create
    @search = Search.new(params[:search])

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search, notice: 'Search was successfully created.' }
        format.json { render json: @search, status: :created, location: @search }
      else
        format.html { render action: "new" }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search = Search.find(params[:id])
    @search.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end
end
