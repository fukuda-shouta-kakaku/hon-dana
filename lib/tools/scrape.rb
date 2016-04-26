require 'open-uri'
require 'nokogiri'

# uri = "http://www.amazon.co.jp/gp/product/4873117380/ref=s9_simh_gw_p14_d0_i1?pf_rd_m=AN1VRQENFRJN5&pf_rd_s=desktop-1&pf_rd_r=0EMB84DN7QHNZYMGNNQC&pf_rd_t=36701&pf_rd_p=302362649&pf_rd_i=desktop"
# uri = "http://www.amazon.co.jp/Effective-Python-%E2%80%95Python%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%A0%E3%82%92%E6%94%B9%E8%89%AF%E3%81%99%E3%82%8B59%E9%A0%85%E7%9B%AE-Brett-Slatkin/dp/4873117569/ref=pd_bxgy_14_img_3?ie=UTF8&refRID=105MNA2Q851ZRY0MFMTV"
# uri = "http://www.amazon.co.jp/Python%E6%A9%9F%E6%A2%B0%E5%AD%A6%E7%BF%92%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0-%E9%81%94%E4%BA%BA%E3%83%87%E3%83%BC%E3%82%BF%E3%82%B5%E3%82%A4%E3%82%A8%E3%83%B3%E3%83%86%E3%82%A3%E3%82%B9%E3%83%88%E3%81%AB%E3%82%88%E3%82%8B%E7%90%86%E8%AB%96%E3%81%A8%E5%AE%9F%E8%B7%B5-impress-top-gear/dp/4844380605/ref=pd_sim_14_5?ie=UTF8&dpID=51g9ePrbMSL&dpSrc=sims&preST=_AC_UL160_SR125%2C160_&refRID=01SCYX328WX44GXH64FG"
# doc = Nokogiri::HTML(open(uri))
module Tools

  class Scrape
    attr_reader :success

    def initialize(uri)
      @success = false
      @uri = uri
      retry_count = 0
      begin
        @doc = Nokogiri::HTML(open(@uri))
        @success = true
      rescue OpenURI::HTTPError
        retry_count += 1
        retry if retry_count < 3
      end
    end

    def get_params
      publisher, published_at = publisher_and_published_at
      {
        amazon_id: amazon_id,
        title: title,
        author: author,
        publisher: publisher,
        published_at: published_at,
        page: page,
        image_src: image_src
      }
    end

    private

    def amazon_id
      @amazon_id ||= @doc.css('#detail_bullets_id').css('li').each {|li| break li.children.last.text.strip if /ISBN-10/.match(li.children.first) }
    end

    def title
      @doc.css('#productTitle').text
    end

    def author
      author_str = ''
      @doc.css('#byline').css('.author').each do |author|
        author_str += author.css('a').css('.a-link-normal').last.text + author.css('.contribution .a-color-secondary').first.text
      end
      author_str
    end

    def publisher_and_published_at
      publisher, published_at = nil
      @doc.css('#detail_bullets_id').css('li').each do |li|
        if /出版社/.match(li.children.first.text)
          text = li.children.last.text
          publisher = text.sub(/\(.+\)$/, "").strip
          published_at = text.match(/\((.+)\)$/)[1] if text.match(/\((.+)\)$/)
          break
        end
      end
      return publisher, published_at
    end

    def page
      page_str = @doc.css('#detail_bullets_id').css('li').first.children.last.text.strip
      if /\d+ページ/.match(page_str)
        @doc.css('#detail_bullets_id').css('li').first.children.last.text.strip
      end
    end

    def image_src
      @doc.css('#imgBlkFront').attribute('src').value
    end

  end
end