class CreateMicroposts < ActiveRecord::Migration[5.1]
  def change
    create_table :microposts do |t|
      t.text :content

      # references型(自動的にインデックスと外部キー参照付きのuser_idカラムが追加)
      t.references :user, foreign_key: true

      # マジックカラム(created_at, updated_at)
      t.timestamps
    end
    # user_idに関連付けられたすべてのマイクロポストを作成時刻の逆順で取り出しやすくなる
    add_index :microposts, [:user_id, :created_at]
  end
end
