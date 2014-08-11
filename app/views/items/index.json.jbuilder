json.array!(@items) do |item|
  json.extract! item, :id, :name, :price, :image_url, :description
  json.url item_url(item, format: :json)
end
