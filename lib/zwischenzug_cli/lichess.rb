require 'net/http'

module ZwischenzugCLI
  class Lichess
    def self.fetch(id, options={})
      uri = URI.parse "https://lichess.org/training/#{id}"
      response = Net::HTTP.start(uri.host, uri.port,   
                                 :use_ssl => uri.scheme == 'https') do |http|
        request = Net::HTTP::Get.new uri

        http.request request
      end

      puzzle = Puzzle.parse(response.body)

      if options[:format] == 'json'
        STDOUT.write puzzle.pgn
      end

      if options[:format] == 'yaml'
        STDOUT.write puzzle.yaml
      end
    end
  end
end
