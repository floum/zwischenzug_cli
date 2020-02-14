class Analysis
  def self.run(fen)
    Stockfish.analyze fen, multipv: 2, depth: 22
  end
end
