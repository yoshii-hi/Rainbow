# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'
require 'date'
require './loto_analyzer'
require './loto'

def lucky_number
  la = LOTOAnalyzer.new
  # loto_list = la.get_past_lucky_number
  puts "今週のラッキーナンバーは，"
  # puts "#{la.top6.to_s}"
  puts "#{la.top5_and_random1.to_s}"
  puts "です!!"
end

lucky_number
