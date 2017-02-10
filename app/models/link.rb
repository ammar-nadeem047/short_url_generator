class Link < ActiveRecord::Base
	has_shortened_urls
	validates :title, :original_url, :ip, presence: true
end
