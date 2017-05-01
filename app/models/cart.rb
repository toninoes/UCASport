class Cart < ActiveRecord::Base
  has_many :cart_items
  has_many :articles, :through => :cart_items

  def add(article_id)
    items = cart_items.where(article_id: article_id)
    article = Article.find article_id
    if items.size < 1
      ci = cart_items.create :article_id => article_id, :amount => 1, :price => article.price
    else
      ci = items.first
      ci.update_attribute :amount, ci.amount + 1
    end
    ci
  end

  def remove(article_id)
    ci = cart_items.where(article_id: article_id).first
    if ci.amount > 1
      ci.update_attribute :amount, ci.amount - 1
    else
      CartItem.destroy ci.id
    end
    ci
  end

  def total
    sum = 0
    cart_items.each do |item| sum += item.price * item.amount end
    sum
  end
end
