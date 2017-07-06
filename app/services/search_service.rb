class SearchService
  def initialize(query)
    @query = query
  end

  def search
    {
      tags:   serialize(search_tags),
      users:  serialize(search_users),
      albums: serialize(search_albums)
    }
  end

  attr_reader :query

  private

  def serialize(resource)
    ActiveModelSerializers::SerializableResource.new(resource)
  end

  def search_tags
    Tag.search_by_text(query)
      .order('tags.taggings_count DESC')
      .limit(20)
  end

  def search_users
    User.search_by_full_name(query)
      .order('users.followers_count DESC')
      .limit(10)
  end

  def search_albums
    Album.search_by_name(query)
      .includes(:user)
      .order('albums.photos_count DESC')
      .limit(20)
  end
end
