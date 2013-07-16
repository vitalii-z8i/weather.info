class SearchesController < ApplicationController

  # Home page.
  # Provides a new search and a list of previous searches
  def index
    @searches = @current_user.searches.order('created_at DESC').take(5)
    @search = Search.new
p @current_user
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # Search action.
  # Finds weather in an entered city
  def create
    params[:search][:user_id] = @current_user.id
    @search = Search.new(params[:search])

    @search.get_weather(params[:search][:city])

    respond_to do |format|
      format.js   {}
      if @search.save
        format.json { render json: @search, status: :created, location: @search }
      else
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # Delete one of the previous search results
  def destroy
    @search = Search.find(params[:id])
    @search.destroy

    respond_to do |format|
      format.json { head :no_content, status: :no_content }
    end
  end
end
