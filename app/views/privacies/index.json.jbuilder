json.array!(@privacies) do |privacy|
  json.extract! privacy, :id, :order, :title, :body
  json.url privacy_url(privacy, format: :json)
end
