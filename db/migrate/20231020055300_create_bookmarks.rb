class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.timestamps
    end
    # bookmarksにおいてend_user_idとpost_idの組み合わせを一意性あるものにする
    add_index  :bookmarks, [:user_id, :post_id], unique: true
  end
end
