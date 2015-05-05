json.array!(@terms) do |term|
  json.extract! term, :id, :order, :title, :body
  json.url term_url(term, format: :json)
end
