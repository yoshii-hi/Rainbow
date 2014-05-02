# -*- coding: utf-8 -*-

class LOTOList
  attr_accessor :loto_list
  def initialize(loto_list = [])
    @loto_list = loto_list
  end

  def <<(data)
    @loto_list << data
  end

  def each
    @loto_list.each do |value|
      yield value
    end
  end
end

class LOTO
  attr_accessor :count, :date, :numbers, :bonus_number
  def initialize(count=nil, date=nil, numbers=[], bonus_number=nil)
    @count        = count
    @date         = date
    @numbers      = numbers
    @bonus_number = bonus_number
  end
end
