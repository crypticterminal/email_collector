require 'google-search'
require 'logger'

module EmailCollector
  @logger = Logger.new $stderr
  @logger.debug('logger initialized')
  
  @size = :huge
  def self.set_size(size)
    @size = size
  end
  
  @keywords = ['', 'mail', 'mailto', 'email', 'contacts', 'contact', 'address', 'login', 'author', 'googletalk', 'gtalk', 
    'gmail', 'googlemail', 'yahoo', 'hotspot', 'outlook', 'yandex'];

  def self.set_keywords(keywords)
    @keywords = keywords
  end

  def self.collect(searchReq, domain = nil)
    @keywords.map { |keyword| collectPlain("#{searchReq} #{keyword}", domain) }.flatten.uniq.compact
  end

  def self.collect_plain(searchReq, domain = nil)
    @logger.debug("searching for #{searchReq}")
    @logger.debug("domain = #{domain}")
	
	if (domain)
      search("#{searchReq} \"#{domain}\"") +
        search("#{searchReq} \"at #{domain}\"").map do |context|
        @logger.debug("context = #{context}")
        context = filter_at_domain(context)
        context.scan(/[a-z0-9._%+-]*[a-z0-9_%+]@#{Regexp.quote(domain)}/i)
      end
	else
      search(searchReq).map do |context|
        @logger.debug("context = #{context}")
        context.scan(/[a-z0-9._%+-]*[a-z0-9_%+]@(?:[a-z0-9.-]+\.)+[a-z0-9]{2,}/i)
      end
	end
  end
  
  def self.search(searchReq)
    @logger.debug("searching for #{searchReq}")

    Google::Search::Web.new do |search|
      search.query = searchReq
      search.size = @size
    end.map do |item|
      #@logger.debug("URI = #{item.uri}")
      #@logger.debug(item.content)
      s = filter_b(item.content)
      s = filter_at(s)
      filter_exclam(s).split('...')
    end.flatten
  end

  def self.filter_at(s)
    s.gsub(/\s+/, ' ').gsub(/[^a-z0-9_.%+-]+[ae]t[^a-z0-9.@-]+|([_+-]+)[ae]t\1/i, '@')
  end
  
  def self.filter_at_domain(s, domain)
    s.gsub(/[^a-z0-9_%+-]+#{Regexp.quote(domain)}/, '@' + domain)
  end
  
  # Transform gmail!com addresses
  def self.filter_exclam(s)
    s.gsub(/[!:]/, '.')
  end
  
  # One can go fix google-search gem instead
  def self.filter_b(s)
    s.gsub(/<\/?b>/, '')
  end
  
end
