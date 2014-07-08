class TeamCodeTranslate

  CODE_TEAMS_TRANSLATOR = {
    "COS" => "CRC",
    "ALE" => "GER",
    "SPA" => "ESP",
    "CAM" => "CMR",
    "JAP" => "JPN",
    "IRA" => "IRN",
    "NIG" => "NGA",
    "BOS" => "BIH",
    "SWI" => "SUI",
    "CTI" => "CIV"
  }

  def self.get_fifa_code(vippredictor_code)
    code = CODE_TEAMS_TRANSLATOR[vippredictor_code]
    code ||= vippredictor_code
  end

end
