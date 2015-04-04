json.array!(@accounts) do |account|
  json.extract! account, :id, :email, :password_digest, :first_name, :last_name
  json.url account_url(account, format: :json)
end
