fs = require('fs')

dic = JSON.parse(fs.readFileSync('scraper/dic.json', 'utf-8'))

module.exports = (robot) ->
  for k, v of dic
    do (v) ->
      robot.hear ///#{k}///i, (res) ->
        res.send res.random(v)
