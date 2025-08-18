# app/controllers/people_explorer_controller.rb
class PeopleExplorerController < ApplicationController
  before_action :forbid_in_production_on_update!, only: :update

  def index
    # Now that associations are correct, this eager-load is fine
    @people = Person.includes(:books, :songs, podcasts: :episodes).order(:name)
  end

  def update
    klass = permitted_classes[params[:type].to_s]
    return head :bad_request unless klass

    record = klass.find_by(id: params[:id])
    return head :not_found unless record

    if record.update(permitted_params(klass))
      respond_to do |f|
        f.html { redirect_to people_explorer_path, notice: "#{klass.model_name.human} updated." }
        f.turbo_stream
        f.json { render json: { ok: true } }
      end
    else
      render json: { errors: record.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def forbid_in_production_on_update!
    head :forbidden unless Rails.env.development?
  end

  def permitted_classes
    { "Person" => Person, "Book" => Book, "Podcast" => Podcast, "Episode" => Episode, "Song" => Song }
  end

  # Match your schema.rb exactly
  def permitted_params(klass)
    case klass.name
    when "Person"  then params.require(:record).permit(:name, :bio)
    when "Book"    then params.require(:record).permit(:title, :url, :published_on, :status)
    when "Podcast" then params.require(:record).permit(:title, :description)
    when "Episode" then params.require(:record).permit(:number, :title, :url, :youtube_url, :released_on)
    when "Song"    then params.require(:record).permit(:title, :released_on, :youtube_url, :spotify_url)
    else params.require(:record).permit
    end
  end
end

