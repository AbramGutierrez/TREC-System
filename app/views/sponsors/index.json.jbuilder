json.array!(@sponsors) do |sponsor|
  json.extract! sponsor, :id, :sponsor_name, :logo_path, :priority
  json.url sponsor_url(sponsor, format: :json)
end
