json.array!(@pageinfos) do |pageinfo|
  json.extract! pageinfo, :id, :page, :body
  json.url pageinfo_url(pageinfo, format: :json)
end
