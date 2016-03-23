json.array!(@users) do |user|
  json.extract! user, :rank, :name, :high_score
end
