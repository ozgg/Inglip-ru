json.data @patterns do |item|
  json.meta do
    json.sample item[:sample]
    json.pattern item[:pattern]
  end
end
