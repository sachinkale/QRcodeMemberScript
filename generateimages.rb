y = 1005
count = 0
while(count < 300)
  y = y + 1
  if y < 10
    i = "00#{y}"
  elsif y < 100
    i = "0#{y}"
  else
    i = y
  end
  #puts i
  system("qrencode 'B#{i}' -o  /home/sachin/memberships/img2/bs-A#{i}.png -s 5")
  system("libdecodeqr-simpletest /home/sachin/memberships/img2/bs-A#{i}.png >/tmp/abe")
  check = `cat /tmp/abe`
  if check.match(/B#{i}/)
     puts "passed for #{i}"
     count = count + 1
  else
    puts "removing #{i}"
    system("rm /home/sachin/memberships/img2/bs-A#{i}.png")
  end
end
