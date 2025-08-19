# config/initializers/rails_admin.rb
RailsAdmin.config do |config|
  config.asset_source = :sprockets
  config.model 'Person' do
    edit do
      field :name
      field :bio
      # Do NOT define field :role_names here
    end

    list do
      field :name
      field :roles do
        pretty_value { bindings[:object].roles.map(&:name).join(', ') }
      end
    end
  end
  config.model 'Book' do
    edit do
      field :title
      field :url
      field :published_on
      field :status
      field :author_ids, :enum do
        label "Authors"
        multiple true
        enum { Person.order(:name).pluck(:name, :id) }
      end
    end
    list do
      field :title
      field :authors do
        pretty_value { bindings[:object].authors.pluck(:name).join(', ') }
      end
    end
  end
end


