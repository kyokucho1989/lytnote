json.reports @reports do |report|
  json.id report.id
  json.content report.content
  json.user report.user
  json.reported_on report.reported_on
end