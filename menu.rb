require 'colorize'
require './team'
require './game'

module Menu

  @all_teams = []

  def Menu.main_menu
    exit = false
    while exit == false
      clear_screen
      puts "Welcome to Fantasy Football Manager".colorize(:blue)
      puts "Currently #{@all_teams.length} teams in the comp"
      page_divide
      puts "Please select from the following options"
      puts "1. Simulate Game*"
      puts "2. See Season Results*"
      puts "3. See All Teams*"
      puts "4. Create Team"
      puts "5. Edit Team*"
      puts "6. Delete team*"
      puts "7. Finish Season*"
      page_divide
      puts "8. Exit Application".colorize(:red)
      puts "9. CHEAT MODE! Auto-populate teams".colorize(:yellow)
      prompt
      selection = $stdin.gets.chomp
      case selection
        when "1"
          simulate_game
        when "2"
          see_season_results
        when "3"
          see_all_teams
        when "4"
          create_team
        when "5"
          edit_team
        when "6"
          delete_team
        when "7"
          finish_season
        when "8"
          puts "Bye!"
          exit = true
        when "9"
          auto_populate_teams
        else
          puts "I don't understand that command"
          press_any_key_to_continue
      end
    end
  end

  # Menu Formatting Methods

  def Menu.clear_screen
    system "clear"
  end

  def Menu.page_divide
    puts "=" * 40
  end

  def Menu.prompt
    print "> "
  end

  def Menu.get_input
    $stdin.gets.chomp
  end

  def Menu.press_any_key_to_continue
    puts "Press any key to continue"
    gets
  end

  # Menu Methods Calling Other Classes

  def Menu.create_team
    clear_screen
    team_complete = false
    while team_complete == false
      puts "Please enter the name of your team:"
      prompt
      team_name  = get_input
      puts "Please enter the team attack strength (1 to 10)"
      prompt
      attack = get_input
      puts "Please enter the team defense strength (1 to 10)"
      prompt
      defense = get_input
      puts "Does this team play better in wet or dry conditions? ('wet' or 'dry')"
      prompt
      condition_preference = get_input
      luck = rand(1..10)
      puts "Team luck has been randomly calculated as #{luck}"
      page_divide
      puts "Name: ".colorize(:yellow) + "#{team_name}"
      puts "Attack: ".colorize(:yellow) + "#{attack}"
      puts "Defense:".colorize(:yellow) + " #{defense}"
      puts "Luck:".colorize(:yellow) + " #{luck}"
      puts "Condition Preference:".colorize(:yellow) + " #{condition_preference}"
      puts "Are you happy with this? (Y/N)"
      prompt
      happy = get_input.upcase
      happy == "Y" ? team_complete = true : team_complete = false
    end
    team_information = {name: team_name, attack: attack.to_i, defense: defense.to_i, luck: luck, condition_preference: condition_preference}
    team = Team.new(team_information)
    @all_teams << team
    press_any_key_to_continue
  end

  def Menu.see_all_teams
    clear_screen
    puts "All Teams"
    page_divide
    team_counter = 0
    @all_teams.each do |team|
      puts "Team Name:".colorize(:red) + " #{team.name}"
      puts "Attack:".colorize(:blue) + " #{team.attack}" + " Defense:".colorize(:blue) + " #{team.defense}"+" Luck:".colorize(:blue) + " #{team.luck}"
      puts "Preferred Conditions:".colorize(:yellow) + " #{team.condition_preference}"
      page_divide
      team_counter += 1
      #paginate at 4 items
      if team_counter == 4
        press_any_key_to_continue
        clear_screen
        team_counter = 0
      end
    end
    press_any_key_to_continue
  end
  #quick hacky method to automatically fill the team list.
  def Menu.auto_populate_teams
    team_array = [
                  {name: "Bulls", attack: 9, defense: 5, luck: 3, condition_preference: "dry"},
                  {name: "Goats", attack: 8, defense: 4, luck: 2, condition_preference: "wet"},
                  {name: "Bears", attack: 7, defense: 3, luck: 1, condition_preference: "dry"},
                  {name: "Anvils", attack: 6, defense: 2, luck: 9, condition_preference: "wet"},
                  {name: "Snakes", attack: 5, defense: 1, luck: 8, condition_preference: "dry"}
                  ]
    team_array.each do |team_info|
      #team = Team.new(team_info)
      @all_teams << Team.new(team_info)
    end
    puts "Cheat mode engaged! Teams automatically added!"
    press_any_key_to_continue
  end

  def Menu.edit_team
    clear_screen
    puts
    @all_teams.each do |team|
      print "#{team.name}, "
    end
    puts
    puts "Please enter the name of team that you'd like to edit"
    prompt
    selection = get_input
    team_to_edit = find_team(selection)
    puts "Please enter the new name for the team"
    prompt
    new_name = get_input
    puts "Please enter the new attack value for the team"
    prompt
    new_attack = get_input
    puts "Please enter the new defense value for the team"
    prompt
    new_ = get_input
    team_to_edit.change_team_values(new_name, new_attack, new_)
    puts "New Values"
    puts team_to_edit.name
    puts team_to_edit.attack
    puts team_to_edit.defense
    press_any_key_to_continue
  end

  def Menu.find_team(name)
    @all_teams.each_with_index do |team, index|
      if team.name == name
        puts "#{team.name} found!"
        press_any_key_to_continue
        return @all_teams[index]
      end
    end
    puts "Team Not Found"
    press_any_key_to_continue
  end

end
Menu.main_menu
