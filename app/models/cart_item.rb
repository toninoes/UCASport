class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :article
end
