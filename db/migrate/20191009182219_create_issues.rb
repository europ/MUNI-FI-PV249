class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues do |t|
      t.string :subject
      t.string :text

      t.timestamps
    end
  end
end
