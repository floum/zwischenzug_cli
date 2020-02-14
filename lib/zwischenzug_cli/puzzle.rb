class Puzzle
  attr_reader :pgn

  def initialize(attrs = {})
    @initial_ply = attrs.fetch(:initial_ply) { 0 }
    @fen = attrs.fetch(:fen)
    @moves = attrs.fetch(:moves)
  end

  def pgn
    %Q([SetUp "1"]\n[FEN "#{@fen}"]\n#{line}\n)
  end

  def yaml
    %Q(- fen: #{@fen}\n  moves: #{line}\n  ply: 1\n)
  end

  def black_to_play?
    @fen.split(' ')[1] == 'b'
  end

  def line 
    moves = @moves.map {|ply, san| san }
    if black_to_play?
      moves.unshift('..')
    end

    moves.each_slice(2).with_index.map do |move, index|
      "#{index+1}.#{move.join(' ')}"
    end.join(' ')
  end

  def self.parse(lichess_response_body)
    positions = lichess_response_body.scan(/"ply":(\d+),"fen":"(\w+\/\w+\/\w+\/\w+\/\w+\/\w+\/\w+\/\w+ [wb] [-KQkq]+ [-\w]+ \d+ \d+)","id":"[^"]+","uci":"(\w+)","san":"([\w=#\+]+)"/).map {|ply, fen, uci, san| [ply.to_i, fen, uci, san]}

    initial_ply = lichess_response_body[/"initialPly":\d+/][/\d+/].to_i
    puzzle = positions.select {|position| position[0] >= initial_ply-1}

    moves = puzzle.map do |ply, fen, uci, san, index|
      [ply, san]
    end[1..-1]

    puzzle_fen = puzzle[0][1]

    pgn = %Q([SetUp "1"]\n[FEN "#{puzzle_fen}"]\n#{moves})
    Puzzle.new(fen: puzzle_fen, moves: moves, initial_ply: initial_ply)
  end
end
