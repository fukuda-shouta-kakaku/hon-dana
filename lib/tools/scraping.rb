require 'open-uri'
require 'nokogiri'

# uri = "http://www.amazon.co.jp/gp/product/4873117380/ref=s9_simh_gw_p14_d0_i1?pf_rd_m=AN1VRQENFRJN5&pf_rd_s=desktop-1&pf_rd_r=0EMB84DN7QHNZYMGNNQC&pf_rd_t=36701&pf_rd_p=302362649&pf_rd_i=desktop"
uri = "http://www.amazon.co.jp/Effective-Python-%E2%80%95Python%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%A0%E3%82%92%E6%94%B9%E8%89%AF%E3%81%99%E3%82%8B59%E9%A0%85%E7%9B%AE-Brett-Slatkin/dp/4873117569/ref=pd_bxgy_14_img_3?ie=UTF8&refRID=105MNA2Q851ZRY0MFMTV"
uri = "http://www.amazon.co.jp/Python%E6%A9%9F%E6%A2%B0%E5%AD%A6%E7%BF%92%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0-%E9%81%94%E4%BA%BA%E3%83%87%E3%83%BC%E3%82%BF%E3%82%B5%E3%82%A4%E3%82%A8%E3%83%B3%E3%83%86%E3%82%A3%E3%82%B9%E3%83%88%E3%81%AB%E3%82%88%E3%82%8B%E7%90%86%E8%AB%96%E3%81%A8%E5%AE%9F%E8%B7%B5-impress-top-gear/dp/4844380605/ref=pd_sim_14_5?ie=UTF8&dpID=51g9ePrbMSL&dpSrc=sims&preST=_AC_UL160_SR125%2C160_&refRID=01SCYX328WX44GXH64FG"
doc = Nokogiri::HTML(open(uri))

puts doc.css('#productTitle').text


text = ''
doc.css('#byline').css('.author').each do |author|
  text += author.css('a').css('.a-link-normal').last.text + author.css('.contribution .a-color-secondary').first.text
end

puts text



reg = /出版社/
doc.css('#detail_bullets_id').css('li').each do |li|
  if reg.match(li.children.first.text)
    t = li.children.last.text
    puts t.match(/\((.+)\)$/)[1] if t.match(/\((.+)\)$/)
    puts li.children.last.text.sub(/\(.+\)$/, "").strip
    break
  end
end

page = doc.css('#detail_bullets_id').css('li').first.children.last.text.strip
if /\d+ページ/.match(page)
  puts doc.css('#detail_bullets_id').css('li').first.children.last.text.strip
end
puts doc.css('#imgBlkFront').attribute('src').value
