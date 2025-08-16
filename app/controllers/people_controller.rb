class PeopleController < ApplicationController
  before_action :set_person, only: %i[show edit update destroy]

  def index
    @people = Person.all
  end

  def show; end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      redirect_to @person, notice: "Person created successfully."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @person.update(person_params)
      redirect_to @person, notice: "Person updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @person.destroy
    redirect_to people_path, notice: "Person deleted successfully."
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:name, :bio, role_ids: [])
  end
end

