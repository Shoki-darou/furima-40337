class Genre < ActiveHash::Base
=begin

  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '1~2発送' },
    { id: 3, name: '2~3発送' },
    { id: 4, name: '4~7で発送' }
  ]

  include ActiveHash::Associations
  has_many :items
=end
end