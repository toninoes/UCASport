class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :article

  def validate
    errors.add(:amount, "debe ser uno o más") unless amount.nil? || amount > 0
    errors.add(:price, "debe ser un número positivo") unless price.nil? || price > 0.0
  end
end
