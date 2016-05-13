require 'json'
require 'natto'

images = JSON.parse(STDIN.read)

images.map! do |image|
  words = image['categories']
  [image['title'], image['description']].each do |sentence|
    Natto::MeCab.new.parse(sentence) do |n|
      if n.feature =~ /^名詞/ && n.surface.length > 1
        words << n.surface
      end
    end
  end

  {
    words: words.uniq,
    url: image['url']
  }
end

dic = Hash.new{|h,k| h[k] = [] }
images.each do |image|
  image[:words].each do |word|
    dic[word] << image[:url]
  end
end

puts dic.to_json
