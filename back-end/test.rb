require './application'
require 'test/unit'
require 'rack/test'
require 'json'
ENV['RACK_ENV'] = 'test'
class AppTest < Test::Unit::TestCase
	include Rack::Test::Methods
	include Convert
	def app
		Sinatra::Application
	end
	def setup
		super
		#每个测试前清空数据库
		#Todo.truncate
	end

	def test_get_all_todo
		@todo=Todo.new(:content=>"insert",:done=>false)
		@todo.save
		get '/todos'
		assert last_response.ok?
		assert get_hash_all(Todo.dataset.all),last_response.body
		#@todo.delete
	end
	def test_get_one_todo
		@todo=Todo.new(:content=>"getone",:done=>false)
		@todo.save
		get "/todos/#{@todo.id}"
		assert last_response.ok?
		assert_equal get_hash(@todo).to_json,last_response.body
		@todo.delete
	end
	
	def test_post_new_record
		@todo=Todo.last
		assert_not_equal  [@todo.content,@todo.done],["new",false]
		post "/todos",({:content=>"new",:done=>false}).to_json
		@todo=Todo.last
		assert_equal  [@todo.content,@todo.done],["new",false]
		Todo.last.delete
	end
  
	def test_put
		@todo=Todo.new(:content=>"testput",:done=>false)
		@todo.save
		assert_equal [@todo.content,@todo.done],["testput",false]
		put "/todos/#{@todo.id}", ({:content=>"put",:done=>true}).to_json
		#要重新查询数据库,获得新的引用
		@todo.refresh
		assert_equal [@todo.content,@todo.done],["put",true]
		@todo.delete
	end

	def test_delete
		@todo=Todo.new(:content=>"getone",:done=>false)
		@todo.save
		assert_not_equal Todo[@todo.id],nil
		delete "/todos/#{@todo.id}"
		assert_equal Todo[@todo.id],nil
	end
end


