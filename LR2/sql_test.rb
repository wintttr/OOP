require "mysql2"
require "student.rb"

client = Mysql2::Client.new(host: "localhost", 
							username: "wintttr", 
							database: "studentsdb")

results = client.query("SELECT * FROM students")

results = results.map {|r| r.to_h {|k, v| [k.to_sym, v]}}

results.each { |r|
	puts Student.new(**r)
	puts
}