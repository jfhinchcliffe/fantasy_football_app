class Team
  attr_accessor :name, :attack, :defense, :luck, :condition_preference

  def initialize(team_information)
    @name = team_information[:name]
    @attack = team_information[:attack]
    @defense = team_information[:defense]
    @luck = team_information[:luck]
    @condition_preference = team_information[:condition_preference]
  end

  def change_team_values(new_name, new_attack = 0, new_defence = 0)
    @name = new_name if new_name.length > 0
    @attack = new_attack.to_i if new_attack.to_i > 0
    @defence = new_defence.to_i if new_defence.to_i > 0
  end

end
