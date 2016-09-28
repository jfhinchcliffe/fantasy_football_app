require 'csv'
def filecheck
  p = ["Bulls",1,2,3,"wet"]
  CSV.foreach("./data/football_season.csv") do |row|
    row << p
  end

  CSV.foreach("./data/football_season.csv") do |row|
    puts row
  end

end

filecheck
