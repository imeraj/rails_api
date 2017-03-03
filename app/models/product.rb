class Product < ApplicationRecord
    belongs_to :user
    has_many :placements
    has_many :orders, through: :placements

    validates :title, :user_id, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 0 },
                      presence: true


end
