require 'mechanize'
require 'json'

agent = Mechanize.new

page = agent.get("http://www.irasutoya.com/search/label/コンピューター")

current_page = page
image_urls = []
1.times do
  image_urls.concat(current_page.search('div.boxim>a').map{|box| box['href'] })

  next_link = page.at('a.blog-pager-older-link')&.send(:[], 'href')
  break unless next_link

  current_page = agent.get(next_link)
end

images = image_urls.take(5).map do |url|
  page = agent.get(url)

  title = page.at('div.title>h2').text.strip
  entry = page.search('div.entry>div.separator')
  image_url = entry[0].at('a')['href']
  description = entry[1].text
  categories = page.search('span.category>a').map(&:text)

  {
    title: title,
    description: description,
    url: image_url,
    categories: categories
  }
end

puts images.to_json
