# report model层，处理数据调用和解析 ---------------------------------------------------------------
class ReportModel

  @createReport: (data, callback)->
    $.post("/write", data, (response)->
      callback(response)
    , "json")

  @getReportNum: (callback)->
    $.post("/getreportnum", (response)->
      callback(response)
    , "json")

  #返回数据格式为[ { date: '2013-4-30',cotent: '<p><br /></p>4.30 reports' },{ date: '2013-4-30',content: '4.30 reports' }]
  @getReports: (data, callback)->
    $.post("/getreports", data, (response)->
      callback(response)
    , "json")

window.ReportModel = ReportModel