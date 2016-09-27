require 'colorize'
require './team'
require './game'
require './season'

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
      puts "1. Simulate Game"
      puts "2. See Season Results*"
      puts "3. See All Teams"
      puts "4. Create Team"
      puts "5. Edit Team"
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

  # Menu Format Methods

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

  def Menu.display_team_names
    amount_per_line = 5
    counter = 0
    puts "Team Names".colorize(:red)
    @all_teams.each do |team|
      if counter == 3
        puts "#{team.name}, "
        counter = 0
      else
        print "#{team.name}, "
      end
      counter += 1
    end
    puts
    page_divide
  end

  def Menu.display_formatted_team(team)
    puts "Team Name:".colorize(:red) + " #{team.name}"
    puts "Attack:".colorize(:blue) + " #{team.attack}" + " Defense:".colorize(:blue) + " #{team.defense}"+" Luck:".colorize(:blue) + " #{team.luck}"
    puts "Preferred Conditions:".colorize(:yellow) + " #{team.condition_preference}"
  end

  # Menu Methods Calling Other Classes

  def Menu.create_team
    clear_screen
    team_complete = false
    while team_complete == false
      verify_name = false
      while verify_name == false
        puts "Please enter the name of your team:"
        prompt
        team_name  = get_input
        if @all_teams.any? {|team| team.name == team_name}
          puts "#{team_name} already taken. Please select a new name."
        else
          verify_name = true
        end
      end
      verify_attack = false
      while verify_attack == false
        puts "Please enter the team attack strength (1 to 10)"
        prompt
        attack = get_input.to_i
        if attack <= 0 || attack > 10
          puts "Invalid number"
        else
          verify_attack = true
        end
      end
      verify_defense = false
      while verify_defense == false
        puts "Please enter the team defense strength (1 to 10)"
        defense = get_input.to_i
        if defense <= 0 || defense > 10
          puts "Invalid number"
        else
          verify_defense = true
        end
      end
      verify_conditions = false
      while verify_conditions == false
        puts "Does this team play better in wet or dry conditions? ('wet' or 'dry')"
        prompt
        condition_preference = get_input.downcase
        if condition_preference == 'wet' || condition_preference == 'dry'
          verify_conditions = true
        else
          puts "Please enter wet or dry"
        end
      end

      luck = rand(1..10)
      puts "Team luck has been randomly calculated as #{luck}"
      page_divide
      puts "Name: ".colorize(:yellow) + "#{team_name}"
      puts "Attack: ".colorize(:yellow) + "#{attack}"
      puts "Defense:".colorize(:yellow) + " #{defense}"
      puts "Luck:".colorize(:yellow) + " #{luck}"
      puts "Condition Preference:".colorize(:yellow) + " #{condition_preference}"
      puts "Are you happy with these stats? (y/n)"
      prompt
      happy = get_input.upcase
      happy == "Y" ? team_complete = true : team_complete = false
    end
    team_information = {name: team_name, attack: attack, defense: defense, luck: luck, condition_preference: condition_preference}
    team = Team.new(team_information)
    @all_teams << team
    puts "#{team_name} added."
    press_any_key_to_continue
  end

  def Menu.see_all_teams
    clear_screen
    puts "All Teams"
    page_divide
    team_counter = 0
    @all_teams.each do |team|
      display_formatted_team(team)
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
    display_team_names
    puts "Leave the field blank to leave the team info the same"
    team_to_edit = find_team
    puts "Please enter the new name for the team"
    puts "Leave blank to remain the same"
    prompt
    new_name = get_input
    puts "Please enter the new attack value for the team"
    puts "Leave blank to remain the same"
    prompt
    new_attack = get_input
    puts "Please enter the new defense value for the team"
    puts "Leave blank to remain the same"
    prompt
    new_defense = get_input
    puts "Please enter the new conditions preference value ('wet' or 'dry') for the team"
    puts "Leave blank to remain the same"
    prompt
    new_conditions_preference = get_input
    team_to_edit.edit_team_values(new_name, new_attack, new_defense, new_conditions_preference)
    puts "New Values".colorize(:green)
    display_formatted_team(team_to_edit)
    press_any_key_to_continue
  end

  def Menu.find_team
    found = false
    while found == false
      puts "Please enter the name of the team"
      prompt
      selection = get_input
      @all_teams.each_with_index do |team, index|
        if team.name == selection
          puts "#{team.name} found!"
          return @all_teams[index]
        end
      end
      puts "Team not found."
    end
  end

  def Menu.simulate_game
    clear_screen
    if @all_teams.length < 2
      puts "Not enough teams entered to play a game. Returning to menu."
      press_any_key_to_continue
    else
      display_team_names
      puts "Home team"
      home_team = find_team
      puts "Away team"
      away_team = find_team
      game = Game.new(home_team, away_team)
      game.play
    end
  end

  def Menu.finish_season
    puts "Wiping season"
    press_any_key_to_continue
    Game.finish_season
  end

  def Menu.see_season_results
    Game.season_results
  end

end
Menu.main_menu
