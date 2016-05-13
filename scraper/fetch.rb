require 'mechanize'
require 'json'
require 'ruby-progressbar'

@agent = Mechanize.new

def fetch_labels(section_url)
  page = @agent.get(section_url)
  page.search('#banners>a').map{|a| a['href'] }
end

def fetch_images(label_url)
  current_page = @agent.get(label_url)
  image_urls = []
  1.times do
    image_urls.concat(current_page.search('div.boxim>a').map{|box| box['href'] })

    next_link = current_page.at('a.blog-pager-older-link')&.send(:[], 'href')
    break unless next_link

    current_page = @agent.get(next_link)
  end
  image_urls
end

def fetch_image_detail(url)
  page = @agent.get(url)

  title = page.at('div.title>h2').text.strip
  entry = page.search('div.entry>div.separator')
  image_url = entry[0].at('a')['href']
  description = entry[1].text.strip
  categories = page.search('span.category>a').map(&:text)

  {
    title: title,
    description: description,
    url: image_url,
    categories: categories
  }
end

page = @agent.get('http://www.irasutoya.com/')

sections = page.search('#section_banner>a').map{|a| a['href'] }
labels = sections.take(2).map{|section| fetch_labels(section).take(2) }.flatten
image_urls = labels.map{|label| fetch_images(label).take(2) }.flatten

progressbar = ProgressBar.create(total: image_urls.length, output: STDERR)
images = image_urls.uniq.map do |image_url|
  i = fetch_image_detail(image_url)
  progressbar.increment
  i
end
progressbar.finish

puts images.to_json
