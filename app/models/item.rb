=begin
class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :city_id
  belongs_to :category_id
  belongs_to :delivery_id
  belongs_to :days_to_ship_id
  belongs_to :status_id

  has_one :order
  belongs_to :user
  has_one_attached :image

  validates :item_name, presence: true
  validates :content,   presence: true
  validates :price,     presence: true

  validates :city_id,         numericality: { other_than: 1 , message: "Prefecture can't be blank"}
  validates :category_id,     numericality: { other_than: 1 , message: "Category can't be blank"}
  validates :delivery_id,     numericality: { other_than: 1 , message: "Shipping fee status can't be blank"}
  validates :days_to_ship_id, numericality: { other_than: 1 , message: "Scheduled delivery can't be blank"}
  validates :status_id,       numericality: { other_than: 1 , message: "Sales status can't be blank"}

  validates :content, presence: true, unless: :was_attached?

  def was_attached?
    self.image.attached?
  end

end
