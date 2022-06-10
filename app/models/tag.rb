class Tag < ApplicationRecord
  has_many :game_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :games, through: :game_tags

  scope :merge_books, -> (tags){ }

  def self.looks_tag(word)
    tags =Tag.where(tag: word)

    return tags.inject(init = []) {|result, tag| result + tag.games}
  end

end
