require 'json'

images = JSON.parse(STDIN.read)

dic = Hash.new{|h,k| h[k] = [] }
images.each do |image|
  image['categories'].each do |cat|
    dic[cat] << image['url']
  end
end

puts dic.to_json
