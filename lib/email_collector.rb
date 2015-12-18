require 'google-search'
require 'logger'

module EmailCollector
  @logger = Logger.new $stdout
  @logger.debug('logger initialized')

  def self.collect(searchReq, domain)
    @logger.debug("searching for #{searchReq}")
    Google::Search::Web.new do |search|
      search.query = searchReq
      search.size = :large
    end.each { |item| logger.debug item.title }
  end

end

