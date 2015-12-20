require 'google-search'
require 'logger'

module EmailCollector
  @logger = Logger.new $stderr
  @logger.debug('logger initialized')
  
  KEYWORDS = ['', 'mail', 'mailto', 'email', 'contacts', 'contact', 'address', 'login', 'author'];
  DOMAINS = ['gmail.com', 'yahoo.com', 'outlook.com', 'yandex.ru', 'mail.com', 'hotspot.com']

  def self.collect(searchReq, domain = nil)
    @logger.debug("searching for #{searchReq}")
    @logger.debug("domain = #{domain}")
	
	if (domain)
      KEYWORDS.each do |keyword|
        search("#{searchReq} #{keyword} \"#{domain}\"") +
          search("#{searchReq} #{keyword} \"at #{domain}\"").map { |context| context }
      end
	else
      (KEYWORDS + DOMAINS).each do |keyword|
        search("#{searchReq} #{keyword}").map { |context| context }
      end
	end.uniq.compact
  end
  
  def self.search(searchReq, domain)
    @logger.debug("searching for #{searchReq}")

    Google::Search::Web.new do |search|
      search.query = searchReq + 
      search.size = :large
    end.map { |item| filter_at(item.content) }
  end
  
  def self.filter_at(s)
    s.gsub(/\s+/, ' ').gsub(/[^a-z0-9_.%+-]+[ae]t[^a-z0-9.@-]+|([_+-]+)[ae]t\1/i, '@');
  end
end

