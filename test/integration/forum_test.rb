require 'test_helper'

class ForumTest < ActionDispatch::IntegrationTest

  test "forum" do
  	jill = new_session_as (:jill)
  	george = new_session_as (:george)
  	post = jill.post_to_forum :post => {

  		:name => 'Bookworm',
  		:subject => 'Downtime',
  		:body => 'Eshop11 is down again!'
  	}
    george.view_forum
    jill.view_forum
    george.view_post post
    george.reply_to_post(post, :post => {

    	:name => 'George',
    	:subject => 'Rats!',
    	:body => 'Rats!!!'
    	})
    george.delete_post(post)
  end

  private

  module ForumTestDSL
    include ERB::Util
  	attr_writer :name

  	def post_to_forum(parameters)
  		get '/forum/post'
  		assert_response :success
  		assert_template 'forum/post'
  		post '/forum/create', parameters
  		assert_response :redirect
  		follow_redirect!
  		assert_response :success
  		assert_template 'forum/index'
  		return ForumPost.find_by_subject(parameters[:post][:subject])
  	end

  	def view_forum
  		get '/forum'
  		assert_response :success
  		assert_template 'forum/index'
  		assert_select 'h1', 'Foro'
  		assert_select 'a', 'Nuevo post'
  	end

  	def view_post(post)
  		get "/forum/show/?id=#{post.id}"
  		assert_response :success
  		assert_template 'forum/show'
  		assert_select 'h1', :content => "&#39;#{post.subject}&#39;"
  	end

  	def reply_to_post(post,parameters)
  		get "/forum/reply/?id=#{post.id}"
  		assert_response :success
  		assert_select 'h1', :content => "Responder a &#39;#{post.subject}&#39;"
  		post '/forum/create', :post => { :name => parameters[:post][:name],
  										 :subject => parameters[:post][:subject],
  										 :body => parameters[:post][:body], :parent_id => post.id }
  		assert_response :redirect
  		follow_redirect!
  		assert_response :success
  		assert_template 'forum/index'
  		assert_select 'a', :content => parameters[:post][:subject]
  	end

  	def delete_post(post)
  		post "/forum/destroy/?id=#{post.id}"
  		assert_response :redirect
  		follow_redirect!
  		assert_response :success
  		assert_template 'forum/index'
  		assert_select 'div', { :id => "notice" },
  		:content => "El post #{post.subject} ha sido eliminado correctamente."
  	end
  end

  def new_session_as(name)
  	open_session do |session|
  		session.extend(ForumTestDSL)
  		session.name = name
  		yield session if block_given?
  	end
  end
end
