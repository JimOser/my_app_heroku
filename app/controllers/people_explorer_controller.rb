class PeopleExplorerController < ApplicationController
  def index
    @people = Person.includes(:authored_books, :sung_songs, hosted_podcasts: :episodes).order(:name)
  end
end
