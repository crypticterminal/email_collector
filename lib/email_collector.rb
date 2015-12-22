require 'google-search'
require 'logger'

module EmailCollector
  @logger = Logger.new $stderr
  @logger.debug('logger initialized')
  
  @size = :huge
   
  
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
  
  def self.setSize(size)
    @size = size
  end
  
  def self.search(searchReq)
    @logger.debug("searching for #{searchReq}")

    Google::Search::Web.new do |search|
      search.query = searchReq
      search.size = @size
    end.map do |item|
      @logger.debug("URI = #{item.uri}")
      @logger.debug(item.content)
      filter_b(filter_at(item.content)).split('...')
    end.flatten
  end

  def self.filter_at(s)
    s.gsub(/\s+/, ' ').gsub(/[^a-z0-9_.%+-]+[ae]t[^a-z0-9.@-]+|([_+-]+)[ae]t\1/i, '@')
  end
  
  # One can go fix google-search gem instead
  def self.filter_b(s)
    s.gsub(/<\/?b>/, '')
  end
  
end
