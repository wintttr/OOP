require "mysql2"
require "singleton"

class DBSingleton
	include Singleton
	
	attr_accessor :db_client
	private :"db_client="
	
	def initialize
		self.db_client = Mysql2::Client.new(host: "localhost", 
											username: "wintttr", 
											database: "studentsdb")
	end
end