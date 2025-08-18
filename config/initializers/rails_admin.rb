RailsAdmin.config do |config|
  config.asset_source = :sprockets

  config.model 'Person' do
    edit do
      field :name
      field :bio
      field :role_names, :enum do
        label 'Roles'
        enum { Role.order(:name).pluck(:name) }
        multiple true
        help 'Select one or more roles'
      end
    end

    list do
      field :id
      field :name
      field :bio
      field :roles
      field :created_at
      field :updated_at
    end
  end

  # hide the join model from the sidebar
  config.excluded_models << 'PeopleRole'
end

