class ShortenedUrlsController < Shortener::ShortenedUrlsController
	def show
		token = ::Shortener::ShortenedUrl.extract_token(params[:id])
	  track = Shortener.ignore_robots.blank? || request.human?
	  url   = ::Shortener::ShortenedUrl.fetch_with_token(token: token, additional_params: params, track: track)
	  redirect_to url[:url], status: :moved_permanently
	  short_url_track = ShortUrlTracking.create(shortened_url_id: url[:shortened_url][:id], client_ip: request.remote_ip)
	end
end