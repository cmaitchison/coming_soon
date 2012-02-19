class CreateWatchers < ActiveRecord::Migration
  def change
    create_table :watchers do |t|
      t.string :email
      t.string :ip

      t.timestamps
    end
  end
end
