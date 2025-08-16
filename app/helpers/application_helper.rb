module ApplicationHelper
  def display_roles(person)
    person.roles.map(&:name).join(", ")
  end

  def display_person_link(person)
    link_to person.name, person_path(person)
  end
end
