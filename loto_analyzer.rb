# -*- coding: utf-8 -*-

class LOTOAnalyzer
  # ロトのまとめサイトからロト6の当選番号のurlを取ってくる．
  def get_urls
    url = "http://www.takarakuji-loto.jp/loto6-mini/"
    url_list = []
    page = Nokogiri::HTML.parse(open(url).read)
    page.css(".loto6").css(".pginsidelink").css("li").each do |li|
      url_list << url + li.css("a").attribute("href")
    end
    return url_list
  end

  # ロト6の過去の当選番号を取ってくる．
  def get_past_lucky_number
    loto_list = LOTOList.new

    url_list = get_urls

    url_list.each do |url|
      page = Nokogiri::HTML.parse(open(url).read)
      page.css(".ctbox").each do |c|
        c.css("table").css("tr").each do |tr|
          i = 0
          if tr.css("td").size != 0
            loto = LOTO.new
            tr.css("td").each do |td|
              loto.count = td.text.chomp.strip.gsub(/ロト6|第|回/,"").to_i if i == 0
              if i == 1
                date = "#{td.text.chomp.strip.gsub(/年|月/, "-").gsub(/日/, "").gsub("\s", "").gsub("\r\n","").gsub("011","11")}"
                loto.date = Date.parse(date) if date != ""
              end
              loto.numbers << td.text.to_i if [2,3,4,5,6,7].include?(i)
              loto.bonus_number = td.text.to_i if i == 8
              i += 1
            end
            loto_list << loto
          end
        end
      end
    end
    return loto_list
  end

  def top6
    loto_list = get_past_lucky_number
    count_number = Hash.new(0)
    loto_list.loto_list.each do |loto|
      loto.numbers.each do |n|
        count_number["#{n}"] += 1 if n != 0
      end
    end
    top6 = count_number.sort {|(k1, v1), (k2, v2)| v2 <=> v1 }[0..5].map{|k,v| k.to_i}.sort
  end
end
