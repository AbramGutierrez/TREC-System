json.array!(@conferences) do |conference|
  json.extract! conference, :id, :start_date, :end_date, :max_team_size, :min_team_size, :max_teams, :tamu_cost, :other_cost, :challenge_desc
  json.url conference_url(conference, format: :json)
end
