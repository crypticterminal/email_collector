require 'minitest/autorun'
require 'email_collector'

class EmailCollectorTest < Minitest::Unit::TestCase
  @@logger = Logger.new $stderr

  def test_filter_at
    assert_equal "name@domain.com", EmailCollector.filter_at("name at domain.com")
    assert_equal "name@domain.ru", EmailCollector.filter_at("name et domain.ru")
    assert_equal "name@domain.moscow", EmailCollector.filter_at("name (at) domain.moscow")
    assert_equal "name@domain.moscow", EmailCollector.filter_at("name+at+domain.moscow")
  end
  
  def test_filter_b
    assert_equal "name@domain.com", EmailCollector.filter_b("<b>name</b>@<b>domain.com</b>")
  end

  PATTERN = ['wikipedia', 'alexei.fedotov@gmail.com']
  def test_search
    EmailCollector.setSize(:small);
    
    PATTERN.each do |pattern|
  	  x = EmailCollector.search("\"#{pattern}\"").join('').gsub(/ /, '')
      #@@logger.debug("PATTERN = #{pattern}")
      #@@logger.debug("x = " << x)
      #@@logger.debug(x.match(/#{pattern}/i))
      assert(x.match(/#{pattern}/i))
	end
  end

end