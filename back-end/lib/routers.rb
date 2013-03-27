helpers Convert

get '/todos' do 
	#返回整个todos数据集,使用Json
	json get_hash_all(Todo.all)
end

get '/todos/:id' do
	#返回单条代办事项,使用Json
	json get_hash(Todo["#{params[:id]}"])
end

post '/todos' do
	#添加新的代办事项
	#处理json
	new_hash = JSON.parse request.body.read
	@todo = Todo.new(:title=>new_hash["title"],:done=>new_hash["done"])
  @todo.save
	nil
end

put '/todos/:id' do
	#对指定的代办事项进行修改
	#接受处理的Json
	new_hash = JSON.parse request.body.read
	@todo=Todo[params[:id]].update(:title=>new_hash["title"],:done=>new_hash["done"])
	nil
end

delete '/todos/:id' do
	#删除制定的代办事项
	Todo[params[:id]].delete
	nil
end
