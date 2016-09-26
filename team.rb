class Team
  attr_reader :name, :attack, :defense, :luck

  def initialize(team_information)
    @name = team_information[:name]
    @attack = team_information[:attack]
    @defense = team_information[:defense]
    @luck = team_information[:luck]
  end

end
