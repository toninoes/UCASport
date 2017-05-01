require 'test_helper'

class ArticleAdministrationTest < ActionDispatch::IntegrationTest

  test "article_aministration" do
    manufacturer = Manufacturer.create(:name => 'Fabricante de UCASport')
    supplier = Supplier.create(:first_name => 'Pepe', :last_name => 'Gonzalez')
    george = new_session_as(:george)


    new_article_ruby = george.add_article :article => {
      :title => 'Zapatillas Joma',
      :manufacturer_id => manufacturer.id,
      :supplier_ids => [supplier.id],
      :manufactured_at => Time.now,
      :reference => '123-123-123-X',
      :blurb => 'Nuevas zapatillas Joma',
      :size => 40,
      :price => 45.5
    }

    george.list_articles
    george.show_article new_article_ruby

    george.edit_article new_article_ruby, :article => {
      :title => 'Zapatillas Joma - año 2017',
      :manufacturer_id => manufacturer.id,
      :supplier_ids => [supplier.id],
      :manufactured_at => Time.now,
      :reference => '123-123-123-X',
      :blurb => 'Nuevas zapatillas Joma. Edición Limitada',
      :size => 42,
      :price => 50
    }

    bob = new_session_as(:bob)
    bob.delete_article new_article_ruby
  end

  private

  module ArticleTestDSL
    attr_writer :name

    def add_article(parameters)
      supplier = Supplier.first
      manufacturer = Manufacturer.first
      get '/admin/article/new'
      assert_response :success
      assert_template 'admin/article/new'
      assert_select 'select#article_manufacturer_id' do
        assert_select "option[value=\"#{manufacturer.id}\"]", manufacturer.name
      end
      assert_select "select[name=\"article[supplier_ids][]\"]" do
        assert_select "option[value=\"#{supplier.id}\"]", supplier.name
      end
      post '/admin/article/create', parameters
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template 'admin/article/index'
      page = Article.all.count / 5 + 1
      get "/admin/article/index/?page=#{page}"
      assert_select 'td', parameters[:article][:title]
      article = Article.find_by_title(parameters[:article][:title])
      return article;
    end

    def edit_article(article, parameters)
      get "/admin/article/edit?id=#{article.id}"
      assert_response :success
      assert_template 'admin/article/edit'
      post "/admin/article/update?id=#{article.id}", parameters
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template 'admin/article/show'
    end

    def delete_article(article)
      post "/admin/article/destroy?id=#{article.id}"
      assert_response :redirect
      follow_redirect!
      assert_template 'admin/article/index'
    end

    def show_article(article)
      get "/admin/article/show/#{article.id}"
      assert_response :success
      assert_template 'admin/article/show'
    end

    def list_articles
      get '/admin/article/index'
      assert_response :success
      assert_template 'admin/article/index'
    end
  end

  def new_session_as(name)
    open_session do |session|
      session.extend(ArticleTestDSL)
      session.name = name
      yield session if block_given?
    end
  end
end
