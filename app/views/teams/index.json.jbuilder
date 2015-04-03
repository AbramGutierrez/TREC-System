json.array!(@teams) do |team|
  json.extract! team, :id, :team_name, :paid_status, :school
  json.url team_url(team, format: :json)
end
