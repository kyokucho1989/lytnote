json.reviews @reviews do |review|
  json.id review.id
  json.content review.content
  json.user review.user
  json.reviewed_on review.reviewed_on
end