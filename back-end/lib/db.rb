Sequel::Model.plugin(:schema)
#使用sqlite数据，mysql的使用大同小异.
DB = Sequel.sqlite('anydo.db')
#Sequel的日志文件
DB.logger=Logger.new('sqlite.log')
#创建
class Todo < Sequel::Model
	set_schema do
		primary_key :id
		String :title
		TrueClass :done
	end

	def validate
		super
		errors.add(:title,"can't be empty") if title.empty?
	end

end

Todo.create_table unless Todo.table_exists?
