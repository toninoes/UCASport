require 'test_helper'

class BrowsingAndSearchingTest < ActionDispatch::IntegrationTest
 fixtures :manufacturers, :suppliers, :articles, :articles_suppliers

  test "browse" do
    jill = new_session_as :jill
    jill.index
    jill.second_page
    jill.article_details 'Articulo_9'
    jill.latest_articles
    jill.reads_rss
  end

  module BrowsingTestDSL
    include ERB::Util
    attr_writer :name

    def index
      get '/catalog/index'
      assert_response :success
      assert_select 'dl#articles' do
        assert_select 'dt', :count => 5
      end
      assert_select 'dt' do
        assert_select 'a', 'Articulo_10'
      end
      check_article_links
    end

    def second_page
      get '/catalog/index?page=2'
      assert_response :success
      assert_template 'catalog/index'
      assert_equal Article.find_by_title('Articulo_1'),
                   assigns(:articles).last
      check_article_links
    end

    def article_details(title)
      @article = Article.where(:title => title).first
      get "/catalog/show/#{@article.id}"
      assert_response :success
      assert_template 'catalog/show'
      assert_select 'div#content' do
        assert_select 'h1', @article.title
        assert_select 'h2', "Distribuido por:#{@article.suppliers.map{|a| a.name}.join(", ")}"
      end
    end

    def latest_articles
      get '/catalog/latest'
      assert_response :success
      assert_template 'catalog/latest'
      assert_select 'dl#articles' do
        assert_select 'dt', :count => 5
      end
      @articles = Article.latest(5)
      @articles.each do |a|
        assert_select 'dt' do
          assert_select 'a', a.title
        end
      end
    end

    def check_article_links
      for article in assigns :articles
        assert_select 'a' do
          assert_select '[href=?]', "/catalog/show/#{article.id}"
        end
      end
    end
  end

  def new_session_as(name)
    open_session do |session|
      session.extend(BrowsingTestDSL)
      session.name = name
      yield session if block_given?
    end
  end

  def reads_rss
    get "/catalog/rss"
    assert_response :success
    assert_template "catalog/rss"
    assert_match "application/xml", response.headers["Content-Type"]

    assert_select 'channel' do
      assert_select 'item', :count => 5
    end

    @articles = Article.latest(5)
    @articles.each do |article|
      assert_select 'item' do
        assert_select 'title', article.title
      end
    end
  end

end
