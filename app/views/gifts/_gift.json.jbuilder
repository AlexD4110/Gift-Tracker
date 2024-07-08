json.extract! gift, :id, :name, :price, :link, :friend_id, :created_at, :updated_at
json.url gift_url(gift, format: :json)
