class CreateCompilationHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :compilation_histories do |t|
      t.references :compilation, null: false, foreign_key: true
      t.text :code
      t.integer :version

      t.timestamps
    end
  end
end
