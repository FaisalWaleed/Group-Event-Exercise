json.extract! group_event, :id, :name, :user_id, :latitude, :longitude, :started_at, :ended_at, :deleted_at, :created_at, :updated_at
json.url group_event_url(group_event, format: :json)
