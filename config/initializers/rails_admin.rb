# config/initializers/rails_admin.rb
RailsAdmin.config do |config|
  config.model 'Person' do
    edit do
      field :name
      field :bio
      field :roles do
        help 'Select one or more roles'
        associated_collection_scope do
          Proc.new { |scope| scope.order(:name) }
        end
      end
      # Do NOT define field :role_names here
    end

    list do
      field :name
      field :roles do
        pretty_value { bindings[:object].roles.map(&:name).join(', ') }
      end
    end
  end
end

