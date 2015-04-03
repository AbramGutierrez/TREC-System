json.array!(@participants) do |participant|
  json.extract! participant, :id, :captain, :waiver_signed, :shirt_size
  json.url participant_url(participant, format: :json)
end
