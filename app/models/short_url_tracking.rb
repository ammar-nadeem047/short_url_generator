class ShortUrlTracking < ActiveRecord::Base
	scope :short_url, -> (shortened_url_id) { where(shortened_url_id: shortened_url_id) }
end
