require "mysql2"
require "students_list.rb"

class DBReaderWriter < BasicReaderWriter
	public_class_method :new
	
	attr_accessor :db_table
	attr_accessor :db_client
	
	private :db_table, :"db_table="
	private :db_client, :"db_client="
	
	def initialize(table:, **kwargs)
		self.db_table = table
		self.db_client = Mysql2::Client.new(**kwargs)
	end
	
	def read_objects_impl
		self.db_client.query("SELECT * FROM #{self.db_table}", symbolize_keys: true)
	end
	
	def write_objects_impl hashes_array
		values = hashes_array.map { |h|
			h.values.join ","
		}.map { |str|
			"(#{str})"
		}.join(",")
		
		insert_query = "insert into #{self.db_table} values #{values}"
		self.db_client.query insert_query
	end
end