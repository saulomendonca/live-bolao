class GamePontuationTranslate

  PONTUATION = {
    Date.parse("29/06/2014") => 26,
    Date.parse("30/06/2014") => 27,
    Date.parse("01/07/2014") => 28,
    Date.parse("04/07/2014") => 29,
    Date.parse("05/07/2014") => 30,
    Date.parse("08/07/2014") => 31,
    Date.parse("09/07/2014") => 32,
    Date.parse("12/07/2014") => 33,
    Date.parse("13/07/2014") => 34
  }


  def self.get_pontuation_by_date(date)
    code = PONTUATION[date]
    code ||= 0
  end
end
