json.array!(@contacts) do |contact|
  json.extract! contact, :id, :rank, :group, :position, :name, :email, :other
  json.url contact_url(contact, format: :json)
end
