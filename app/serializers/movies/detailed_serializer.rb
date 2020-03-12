module Movies
  class DetailedSerializer < ActiveModel::Serializer
    attributes :id, :title
    belongs_to :genre, serializer: Genres::Serializer
  end
end
