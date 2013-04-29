// Generated by CoffeeScript 1.6.1
(function() {
  var ReportModel;

  ReportModel = (function() {

    function ReportModel() {}

    ReportModel.createReport = function(data, callback) {
      return $.post("/write", data, function(response) {
        return callback(response);
      }, "json");
    };

    ReportModel.getReportNum = function(callback) {
      return $.post("/getreportnum", function(response) {
        return callback(response);
      }, "json");
    };

    ReportModel.getReports = function(data, callback) {
      return $.post("/getreports", data, function(response) {
        return callback(response);
      }, "json");
    };

    return ReportModel;

  })();

  window.ReportModel = ReportModel;

}).call(this);
