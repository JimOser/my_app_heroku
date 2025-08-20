RailsAdmin.config do |config|
  config.asset_source = :sprockets

  config.model 'Person' do
    edit do
      field :name
      field :bio
    end
    list do
      field :name
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

  config.model 'Song' do
    edit do
      field :title
      field :released_on
      field :youtube_url
      field :spotify_url
      field :singer_ids, :enum do
        label "Singers"
        multiple true
        enum { Person.order(:name).pluck(:name, :id) }
      end
    end
    list do
      field :title
      field :singers do
        pretty_value { bindings[:object].singers.pluck(:name).join(', ') }
      end
    end
  end

  config.model 'Podcast' do
    edit do
      field :title
      field :description
      field :host_ids, :enum do
        label "Hosts"
        multiple true
        enum { Person.order(:name).pluck(:name, :id) }
      end
    end
    list do
      field :title
      field :hosts do
        pretty_value { bindings[:object].hosts.pluck(:name).join(', ') }
      end
    end
  end
end
