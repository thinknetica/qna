class CreateAuthorizations < ActiveRecord::Migration[5.2]
  def change
    create_table :authorizations do |t|
      t.references :user, foreign_key: true
      t.string :provider
      t.string :uid

      t.timestamps
    end

    add_index :authorizations, [:provider, :uid]
  end
end
