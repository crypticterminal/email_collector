require "google-search"
require "logger"
require "email_collector/version"

module EmailCollector

  def initialize()
    @logger = Logger.new $stdout
  end

  def self.collect(searchReq, domain)
    logger.debug("searching for #{searchReq}")
    Google::Search::Web.new do |search|
      search.query = searchReq
      search.size = :large
    end.each { |item| logger.debug item.title }
  end

end

