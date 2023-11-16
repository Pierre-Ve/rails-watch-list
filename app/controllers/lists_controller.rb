class ListsController < ApplicationController
  before_action :set_list, only: [:show]
  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.save
    redirect_to lists_path
  end

  def index
    @lists = List.all
  end

  def show
    @bookmarks = Bookmark.where(list_id: @list.id)
    @movies = find_movies(@bookmarks)
  end

  private
  def find_movies(bookmarks)
    movies = []
    bookmarks.each do |bookmark|
      movies.push(Movie.find(bookmark.movie_id))
    end
    return movies
  end

  def list_params
    params.require(:list).permit(:name)
  end

  def set_list
    @list = List.find(params[:id])
  end
end