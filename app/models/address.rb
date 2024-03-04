=begin
class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :city_id

  belongs_to :order

  validates :phone_number,            presence: true
  validates :zip_code,      presence: true
  validates :town,       presence: true
  validates :house_number, presence: true

  validates :city_id,         numericality: { other_than: 1 , message: "Prefecture can't be blank"}

end
