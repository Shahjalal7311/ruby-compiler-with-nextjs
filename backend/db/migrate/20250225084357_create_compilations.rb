class CreateCompilations < ActiveRecord::Migration[7.2]
  def change
    create_table :compilations do |t|
      t.string :language
      t.text :code
      t.text :output
      t.string :status
      t.float :execution_time

      t.timestamps
    end
  end
end
