require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  fixtures :suppliers, :manufacturers, :articles, :articles_suppliers

  test "failing_create" do
    article = Article.new
    assert_equal false, article.save
    assert_equal 8, article.errors.count
    assert article.errors[:title]
    assert article.errors[:manufacturer]
    assert article.errors[:suppliers]
    assert article.errors[:manufactured_at]
    assert article.errors[:reference]
    assert article.errors[:blurb]
    assert article.errors[:size]
    assert article.errors[:price]
  end

  test "create" do
    article = Article.new(
      :title => 'Zapatillas Running',
      :suppliers => Supplier.all,
      :manufacturer_id => Manufacturer.find(1).id,
      :manufactured_at => Time.now,
      :reference => '123-123-123-1',
      :blurb => 'Unas zapatillas rojas',
      :size => 42,
      :price => 90.5
    )
  assert article.save
  end

  test "has_many_and_belongs_to_mapping" do
    adidas = Manufacturer.find_by_name("Adidas");
    count = adidas.articles.count
    article = Article.new(
      :title => 'Gorra',
      :suppliers => [Supplier.find_by_first_name_and_last_name('Pepe', 'Mateo'),
                   Supplier.find_by_first_name_and_last_name('Toni', 'Gavira')],
      #:manufacturer_id => adidas.id,
      :manufactured_at => Time.now,
      :reference => '123-123-123-x',
      :blurb => 'Una gorra roja y una raya amarilla',
      :size => 40,
      :price => 55.5
    )
    adidas.articles << article
    adidas.reload
    article.reload
    assert_equal count + 1, adidas.articles.count
    assert_equal 'Adidas', article.manufacturer.name
  end

  test "has_many_and_belongs_to_many_suppliers_mapping" do
    article = Article.new(
      :title => 'Gorra',
      :suppliers => [Supplier.find_by_first_name_and_last_name('Pepe', 'Mateo'),
                   Supplier.find_by_first_name_and_last_name('Toni', 'Gavira')],
      :manufacturer_id => Manufacturer.find_by_name("Adidas").id,
      :manufactured_at => Time.now,
      :reference => '123-123-123-x',
      :blurb => 'Una gorra roja y una raya amarilla',
      :size => 40,
      :price => 55.5
    )
    assert article.save
    article.reload
    assert_equal 2, article.suppliers.count
    assert_equal 4, Supplier.find_by_first_name_and_last_name('Pepe', 'Mateo').articles.count
    assert_equal 3, Supplier.find_by_first_name_and_last_name('Toni', 'Gavira').articles.count
  end
end
