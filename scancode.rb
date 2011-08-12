require 'mysql'

mysql = Mysql.init()
checkm = Mysql.init()
mysql.connect("localhost",'dbuser','', "opendb")
checkm.connect("localhost",'dbuser','', "bluesaharaMember")



img = "/tmp/img" + rand(100).to_s
#puts img
system "streamer -f jpeg -o #{img} 2> /dev/null"
system "libdecodeqr-simpletest #{img} > /tmp/abe"
tmpcontent = `cat /tmp/abe`
if tmpcontent.match(/B(.*)/)
  result = checkm.query("select * from members where code like '#{$&}'")
  if result.num_rows() == 0
    puts "Member not found, exiting!"
    exit
  else
    result.each do |r|
      #puts "member code is #{r[0]}"
      puts "Enter Amount"
      amount = gets.chomp.to_i
      if amount == 0
        puts "Please enter integer value"   
        exit
      end
      value = -(amount * 10/100)

      code = rand(1000)
      finalcode =  2000 + code
      id = rand(1000).to_s + (0...20).map{ ('a'..'z').to_a[rand(26)] }.join
      mysql.query("Insert into PRODUCTS values ('#{id}',#{finalcode},#{finalcode},NULL,'#{$1}-Member Discount-10% on #{amount}',#{value},#{value},'000','000',NULL,NULL,NULL,NULL,1,1,NULL)")
      time = Time.now.strftime("%Y-%m-%d %H:%M:%S")
      checkm.query("Insert into discount_availeds(member_id,Amount,date,gcode) values('#{r[0]}',#{amount},'#{time}',#{finalcode})")
      puts "discount code is #{finalcode}"

    end
  end
    



else
  puts "please run again"
end
