class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
    	t.string :ip
    	t.string :original_url
      t.timestamps null: false
    end
  end
end
