require 'open-uri'
require 'nokogiri'

uri = "http://www.amazon.co.jp/gp/product/4873117380/ref=s9_simh_gw_p14_d0_i1?pf_rd_m=AN1VRQENFRJN5&pf_rd_s=desktop-1&pf_rd_r=0EMB84DN7QHNZYMGNNQC&pf_rd_t=36701&pf_rd_p=302362649&pf_rd_i=desktop"
doc = Nokogiri::HTML(open(uri))

puts doc.css('#productTitle').text


text = ''
doc.css('#byline').css('.author').each do |author|
  text += author.css('a').css('.a-link-normal').last.text + author.css('.contribution .a-color-secondary').first.text
end

puts text