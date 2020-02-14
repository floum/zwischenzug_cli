require 'pgn'
require 'json'
require 'net/http'
require 'zwischenzug_cli/version'
require 'zwischenzug_cli/puzzle'
require 'zwischenzug_cli/analysis'
require 'zwischenzug_cli/lichess'
require 'zwischenzug_cli/zwischenzug_api'

module ZwischenzugCLI
  class Error < StandardError; end
end
