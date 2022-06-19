class Game < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :game_tags, dependent: :destroy, foreign_key: 'game_id'
  has_many :tags, through: :game_tags
  has_many :favorites, dependent: :destroy

  validates :name, presence: true
  validates :player, presence:true
  validates :overview, presence: true
  validates :how_to_use, presence: true
  validates :image, presence: true

  validates :game_quality, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0.5}, presence: true

  validates :strategic, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0.5}, presence: true

  validates :cooperation, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0.5}, presence: true

  validates :excitement, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0.5}, presence: true

  validates :luck, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0.5}, presence: true

  has_one_attached :image

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(word)
      Game.where('name LIKE ?', '%'+word+'%')
  end

  def save_tags(savegame_tags)
    current_tags = self.tags.pluck(:tag) unless self.tags.nil?
    old_tags = current_tags - savegame_tags
    new_tags = savegame_tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag: old_name)
    end

    new_tags.each do |new_name|
      game_tag = Tag.find_or_create_by(tag: new_name)
      self.tags << game_tag
    end
  end

end
