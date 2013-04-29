redis = require("redis")
{Response} = require('../vo/response')

exports.createReport = (userId, content, dateStr, callback) ->
  client = redis.createClient();
  userId = "28"
  client.incr("next_report_id", (err, reportId)->
    score = getDateNumber(dateStr)
    client.zadd("userid:#{userId}:reportIds", score, reportId, (err, reply)->
      client.hmset("userid:#{userId}:reports", "#{reportId}:date", dateStr, "#{reportId}:content", content, (err, reply)->
        callback(new Response(1,'success',reply)) )))

#日期字符串变为数字，例如 “2013-4-27” 变为 20130427
getDateNumber = (dateStr)->
  [year, months, date] = dateStr.split("-")
  months = "0#{months}" if months.length == 1
  date = "0#{date}" if date.length == 1
  parseInt("#{year}#{months}#{date}")

exports.getReports = (userId, page, pageNum, callback) ->
  client = redis.createClient();
  start =  pageNum * (page-1)
  start = 0 if start < 0
  end = (pageNum * page) - 1
  client.zrevrange("userid:#{userId}:reportIds", start, end, (err, reportIds)->
    dateArgs = ["userid:#{userId}:reports"]
    contentArgs = ["userid:#{userId}:reports"]
    for reportId in reportIds
      dateArgs.push("#{reportId}:date")
      contentArgs.push("#{reportId}:content")
    client.hmget(dateArgs, (err, dates)->

      client.hmget(contentArgs, (err, contents)->
        len = contents.length
        response = []
        for i in [0...len]
          response.push({date:dates[i], content:contents[i]})
        client.quit()
        callback(new Response(1,'success',response)) )))

exports.getReportNum = (userId, callback) ->
  client = redis.createClient();
  client.zcount("userid:#{userId}:reportIds", "-inf", "+inf", (err, count)->
    client.quit()
    console.log count
    callback(new Response(1,'success',count)) )
