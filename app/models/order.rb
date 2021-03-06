class Order < ApplicationRecord
  before_validation :set_total!

  belongs_to :user
  has_many :placements
  has_many :products, through: :placements

  validates :total, presence: true,
                      numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, presence: true

  private
  def set_total!
      self.total = products.map(&:price).sum
  end

end
