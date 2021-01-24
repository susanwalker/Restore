require 'json'

class Config
  attr_reader :host, :username, :password, :source_destination_pairs

  def initialize(h, u, p, sdp)
    @host = h
    @username = u
    @password = p
    @source_destination_pairs = sdp
  end

  def self.new_from_config
    file = File.read('./config.json')
    hash = JSON.parse(file)
    new(
      hash['credentials']['host'],
      hash['credentials']['username'],
      hash['credentials']['password'],
      hash['source_destination_pairs']
    )
  end
end
