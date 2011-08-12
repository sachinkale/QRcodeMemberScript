require 'mysql'
require 'date'

mysql = Mysql.init()
checkm = Mysql.init()
mysql.connect("localhost",'dbuser','', "opendb")
checkm.connect("localhost",'dbuser','', "bluesaharaMember")

result = checkm.query("select * from discount_availeds where status is NULL")

result.each do |r|
   code = rand(1000).to_s + (0...20).map{ ('a'..'z').to_a[rand(26)] }.join
   puts code
   gcode = r[7]
   time = DateTime.parse("#{r[4]}")
   created_time = Time.local(time.year,time.month,time.day,time.hour,time.min,time.sec)
   puts created_time
   if (Time.now - created_time) > 300
     mysql.query("update PRODUCTS set CODE = '#{code}',REFERENCE = '#{code}' where code like '#{gcode}'")
     checkm.query("update discount_availeds set status = 'used' where id = #{r[0]}")
   end
end



