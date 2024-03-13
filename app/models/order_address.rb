class OrderAddress
  include ActiveModel::Model
  attr_accessor :phone_number, :zip_code, :city_id, :town, :house_number, :building_name, :order_id, :item_id, :user_id, :token

  with_options presence: true do
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "は10桁以上11桁以内の半角数値のみ保存可能です" }
    validates :zip_code, format: { with: /\A\d{3}-\d{4}\z/, message: "は「3桁ハイフン4桁」の形式で入力してください" }
    validates :town
    validates :house_number
    validates :token
    validates :user_id
    validates :item_id
  end
  validates :city_id, numericality: { other_than: 1 , message: "Prefecture can't be blank"}

  def initialize(attributes = {})
    super
    @token = attributes[:token]
  end

  def save
    # トランザクションを開始する前にエラーがないかを確認する
    if valid?
      # トランザクション開始
      ActiveRecord::Base.transaction do
        # 注文情報を保存し、変数orderに代入する
        order = Order.create(item_id: item_id, user_id: user_id)
        # 住所を保存する
        # order_idには、変数orderのidを指定する
        Address.create(phone_number: phone_number, zip_code: zip_code, city_id: city_id, house_number: house_number, town: town, building_name: building_name, order_id: order.id)
      end
    else
      # エラーログを出力する
      Rails.logger.error("Validation failed: #{errors.full_messages.join(', ')}")
    end
  end
end