path = "/home/sachin/memberships/img3/"
#path2 = "/home/sachin/memberships/img3/"

imgs = `ls #{path}`
images = imgs.to_a
count = 0
stringarr = Array.new
string = ""
images.each do |i|
  string +="#{path}#{i.chomp} "
  #system "montage #{path}#{i}  -gravity Center -crop 120x120+0+0 #{path2}#{i}"
  count = count + 1
  if count > 53
    count = 0
    stringarr << string
    string = ""
  end
end
#puts string
x = 0
stringarr.each do |str|
  system "montage -tile 6x9 " + str + " A#{x}.png"
  x = x + 1
end
