json.extract! user, :id, :username, :email, :name, :surname, :phone, :preferences, :created_at, :updated_at
json.url user_url(user, format: :json)
