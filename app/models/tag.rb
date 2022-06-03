class Tag < ApplicationRecord
  has_many :game_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :games, through: :game_tags
end
