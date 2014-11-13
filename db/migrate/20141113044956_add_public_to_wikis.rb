class AddPublicToWikis < ActiveRecord::Migration
  def change
	change_table :wikis do |t|
		t.boolean :public, default: true
	end
  end
end
