class CreateShortUrlTrackings < ActiveRecord::Migration
  def change
    create_table :short_url_trackings do |t|
    	t.integer :shortened_url_id
    	t.string :client_ip
      t.timestamps null: false
    end
  end
end
