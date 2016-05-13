# Scraper

it needs ruby and mecab

```sh
$ bundle install --path vendor/bundle -j4
$ bundle exec ruby fetch.rb > images.json
$ cat images.json > bundle exec ruby translocation.rb > dic.json
```
