module ZwischenzugCLI
  class ZwischenzugAPI
    def initialize(options = {})
      @username = options[:username]
      @password = options[:password]
      @host = options[:host]
      @port = options[:port]
    end

    def create_puzzles_from_pgn(pgn)
      response = Net::HTTP.start(pgn_uri.host, pgn_uri.port) do |http|
        request = Net::HTTP::Post.new pgn_uri, 'Content-Type' => 'application/json'
        form_data = [['pgn', pgn]]
        request.set_form form_data, 'multipart/form-data'

        http.request request
      end
    end

    def create(puzzle)
      game = PGN.parse(puzzle['pgn']).first

      request_body = {
        challenges: puzzle['challenges'].map do |challenge|
          if challenge[-1] == 'b'
            black_ply = 1
          else
            black_ply = 0
          end
          ply_count = challenge[0..1].to_i * 2 + black_ply - 2

          {
            fen: game.positions[ply_count].to_fen,
            expected_fens: [game.positions[ply_count+1].to_fen]
          }
        end
      }

      response = Net::HTTP.start(puzzle_uri.host, puzzle_uri.port) do |http|
        request = Net::HTTP::Post.new puzzle_uri, 'Content-Type' => 'application/json'
        request.body = request_body.to_json

        http.request request
      end

      p response
    end

    def pgn_uri
      URI.parse "http://#{@host}:#{@port}/pgn"
    end

    def puzzle_uri
      URI.parse "http://#{@host}:#{@port}/puzzles"
    end
  end
end
