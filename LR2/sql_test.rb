require "mysql2"
require "student.rb"

client = Mysql2::Client.new(host: "localhost", 
							username: "wintttr", 
							database: "studentsdb")

results = client.query("SELECT * FROM students", symbolize_keys: true)

results.each { |r|
	puts Student.new(**r)
	puts
}