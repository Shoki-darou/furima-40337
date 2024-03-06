class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :city
  belongs_to :category
  belongs_to :delivery
  belongs_to :days_to_ship
  belongs_to :status

  has_one :order
  belongs_to :user
  has_one_attached :image

  validates :item_name, presence: true
  validates :content,   presence: true
  validates :price,     presence: true, numericality: { only_integer: true, greater_than: 0 }

  validates :city_id,         numericality: { other_than: 1 , message: "Prefecture can't be blank"}
  validates :category_id,     numericality: { other_than: 1 , message: "Category can't be blank"}
  validates :delivery_id,     numericality: { other_than: 1 , message: "Shipping fee status can't be blank"}
  validates :days_to_ship_id, numericality: { other_than: 1 , message: "Scheduled delivery can't be blank"}
  validates :status_id,       numericality: { other_than: 1 , message: "Sales status can't be blank"}

  validate :image_attached

  def image_attached
    errors.add(:image, "must be attached") unless image.attached?
  end

end
