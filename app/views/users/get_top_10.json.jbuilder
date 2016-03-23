json.array!(@top_10) do |user|
  json.extract! user, :rank, :name, :high_score
end