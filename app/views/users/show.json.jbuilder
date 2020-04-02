json.array! @events, partial: "users/event", as: :event

json.array!(@events) do |event|
  json.extract! event, :id, :title, :body
  json.id "#{event.id}"
  json.title "#{event.title}"
  json.start event.start_date
  json.end event.end_date
  json.url event_url(event, format: :html)
end
