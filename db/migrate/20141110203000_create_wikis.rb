class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :title
      t.text :outline
      t.text :body
	  
	  t.references :user, index: true

      t.timestamps
    end
  end
end
