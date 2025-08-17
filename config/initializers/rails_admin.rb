RailsAdmin.config do |config|
  # Use Sprockets for assets (default)
  config.asset_source = :sprockets
  #############################
  # Optional authentication
  #############################
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  #############################
  # Person
  #############################
  config.model 'Person' do
    list do
      field :id
      field :name
      field :bio

      field :roles do
        formatted_value do
          bindings[:object].people_roles.map do |pr|
            pr.role.name + (pr.main_author ? " (main)" : "")
          end.join(", ")
        end
      end

      field :created_at
      field :updated_at
    end

    edit do
      field :name
      field :bio
      field :people_roles do
        nested_form true
      end
    end

    show do
      field :id
      field :name
      field :bio
      field :people_roles do
        formatted_value do
          bindings[:object].people_roles.map do |pr|
            pr.role.name + (pr.main_author ? " (main author)" : "")
          end.join(", ")
        end
      end
      field :created_at
      field :updated_at
    end
  end

  # Hide join table from menu
  config.excluded_models << 'PeopleRole'

  #############################
  # Book
  #############################
  config.model 'Book' do
    list do
      field :id
      field :title
      field :person do
        label "Author / Owner"
      end
      field :status
      field :published_on
      field :created_at
      field :updated_at
    end

    edit do
      field :title
      field :url
      field :published_on
      field :status, :enum do
        enum do
          %w[want_to_read reading read]
        end
      end
      field :person
    end

    show do
      field :title
      field :url
      field :published_on
      field :status
      field :person do
        formatted_value { bindings[:object].person.name }
      end
    end
  end

  #############################
  # Podcast
  #############################
  config.model 'Podcast' do
    list do
      field :id
      field :title
      field :person do
        label "Host"
      end
      field :description
      field :created_at
      field :updated_at
    end

    edit do
      field :title
      field :person
      field :description
    end

    show do
      field :title
      field :person do
        formatted_value { bindings[:object].person.name }
      end
      field :description
    end
  end

  #############################
  # Episode
  #############################
  config.model 'Episode' do
    list do
      field :id
      field :podcast
      field :number
      field :title
      field :released_on
      field :created_at
      field :updated_at
    end

    edit do
      field :podcast
      field :number
      field :title
      field :url
      field :youtube_url
      field :released_on
    end

    show do
      field :podcast
      field :number
      field :title
      field :url
      field :youtube_url
      field :released_on
    end
  end

  #############################
  # Singer
  #############################
  config.model 'Singer' do
    list do
      field :id
      field :name
      field :bio
      field :created_at
      field :updated_at
    end

    edit do
      field :name
      field :bio
    end

    show do
      field :id
      field :name
      field :bio
      field :created_at
      field :updated_at
    end
  end

  #############################
  # Song
  #############################
  config.model 'Song' do
    list do
      field :id
      field :title
      field :singer
      field :released_on
      field :youtube_url
      field :spotify_url
      field :created_at
      field :updated_at
    end

    edit do
      field :title
      field :singer
      field :released_on
      field :youtube_url
      field :spotify_url
    end

    show do
      field :title
      field :singer
      field :released_on
      field :youtube_url
      field :spotify_url
    end
  end
end

