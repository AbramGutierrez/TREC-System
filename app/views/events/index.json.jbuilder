json.array!(@events) do |event|
  json.extract! event, :id, :day, :start_time, :end_time, :event_desc
  json.url event_url(event, format: :json)
end
