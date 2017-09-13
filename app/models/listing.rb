class Listing < ApplicationRecord
  belongs_to :user

  #必須項目
  validates :game_title, presence: true



  # ユーザー名による絞り込み
  scope :search, (->(word) { where('game_title LIKE ? OR content LIKE ?',
                                     "%#{sanitize_sql_like(word)}%",
                                     "%#{sanitize_sql_like(word)}%") })



end
