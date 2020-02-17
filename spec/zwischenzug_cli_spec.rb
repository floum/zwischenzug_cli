RSpec.describe PGN do
  data = File.read('./polgar.pgn')
  games = PGN.parse(data)

  p games.first.positions.first
end
