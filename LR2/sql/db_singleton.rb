require "mysql2"

class DBSingleton
	private_class_method :new

	@instance = new

	def db_client= value
		@db_client = value
	end
	
	private :"db_client="

	
	def db_client
		self.reload
		
		@db_client
	end
	
	def reload
		if @db_client.nil? or @db_client.closed? then
			begin
				self.db_client = Mysql2::Client.new(host: "localhost", 
												username: "wintttr", 
												database: "studentsdb")
			rescue
				self.db_client = nil
			end
		end
	end
	
	def self.instance
		@instance
	end
end