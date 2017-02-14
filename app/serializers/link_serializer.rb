class LinkSerializer < ActiveModel::Serializer
  attributes :id, :ip, :title, :original_url, :created_at, :updated_at
  
  has_many :shortened_urls, class_name: 'Shortener::ShortenedUrl'
end
