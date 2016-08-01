class CreateMaterialSources < ActiveRecord::Migration[5.0]
  def change
    create_table :material_sources do |t|
      t.string :url, null: false
      # t.jsonb :content
      t.string :supplier_name
      t.string :title
      t.string :episode
      t.string :year
      t.string :duration
      t.string :aspect_ratio

      t.timestamps
    end
  end
end
