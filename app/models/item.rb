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

  validates :item_name, :content, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  with_options numericality: { other_than: 1 } do
    validates :city_id
    validates :category_id
    validates :delivery_id
    validates :days_to_ship_id
    validates :status_id
  end

  validate :image_attached

  def image_attached
    errors.add(:image, "must be attached") unless image.attached?
  end

  def sold_out?
    order.present?
  end
end