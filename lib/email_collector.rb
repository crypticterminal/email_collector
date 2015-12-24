require 'google-search'
require 'logger'

module EmailCollector
  @logger = Logger.new $stderr
  @logger.debug('logger initialized')
  
  @size = :large
  def self.size=(s)
    @size = s
  end
  
  @keywords = ['', 'mail', 'mailto', 'email', 'contacts', 'contact', 'address', 'login', 'author', 'googletalk', 'gtalk', 
    'gmail', 'googlemail', 'yahoo', 'hotspot', 'outlook', 'yandex'];
  def self.keywords=(k)
    @keywords = k
  end

  def self.collect(searchReq, domain = nil)
    @keywords.map { |keyword| collect_plain("#{searchReq} #{keyword}", domain) }.flatten.uniq.compact
  end

  def self.collect_plain(searchReq, domain = nil)
    #@logger.debug("searching for #{searchReq}")
    #@logger.debug("domain = #{domain}")
	
	if (domain)
      res = google_search("#{searchReq} \"#{domain}\"")
      res_at = google_search("#{searchReq} \"at #{domain}\"")
      
      (res + res_at).map do |context|
        #@logger.debug("context = #{context}")
        context = filter_at_domain(context, domain)
        context.scan(/[a-z0-9._%+-]*[a-z0-9_%+]@#{Regexp.quote(domain)}/i)
      end
	else
      google_search(searchReq).map do |context|
        @logger.debug("context = #{context}")
        context.scan(/[a-z0-9._%+-]*[a-z0-9_%+]@(?:[a-z0-9.-]+\.)+[a-z0-9]{2,}/i)
      end
	end
  end
  
  def self.google_search(searchReq)
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

  # Replaces 'at' with @
  def self.filter_at(s)
    s.gsub(/\s+/, ' ').gsub(/[^a-z0-9_.%+-]+[ae]t[^a-z0-9.@-]+|([_+-]+)[ae]t\1/i, '@')
  end

  # Replaces ***gmail.com with @gmail.com
  def self.filter_at_domain(s, domain)
    s.gsub(/[^a-z0-9_%+-]+#{Regexp.quote(domain)}/, '@' + domain)
  end
  
  # Transforms gmail!com addresses
  def self.filter_exclam(s)
    s.gsub(/[!:]/, '.')
  end
  
  # Fixes google-search gem bold outline
  def self.filter_b(s)
    s.gsub(/<\/?b>/, '')
  end
  
end
