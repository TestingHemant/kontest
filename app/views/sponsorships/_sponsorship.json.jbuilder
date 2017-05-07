json.extract! sponsorship, :id, :name, :email, :phone, :message, :created_at, :updated_at
json.url sponsorship_url(sponsorship, format: :json)