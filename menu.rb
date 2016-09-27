require 'colorize'
require './team'
require './game'
require './season'
require './menu_helper'

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
      puts "2. See Season Results"
      puts "3. See All Teams"
      puts "4. Create Team"
      puts "5. Edit Team"
      puts "6. Delete Team*"
      puts "7. Deletes Season Information"
      page_divide
      puts "8. Exit Application".colorize(:red)
      page_divide
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
    @all_teams.each do |team|
      display_options = {name: true, attack: false, defense: false, luck: false, condition_preference: false}
      display_formatted_team(team, display_options)
    end
  end

  def Menu.display_formatted_team(team, display_options = {name: true, attack: true, defense: true, luck: true, condition_preference: true}
)
    MenuHelper.display_team_name(team, display_options)
  end

  # Menu Methods Calling Other Classes

  def Menu.create_team
    clear_screen
    team_complete = false
    while team_complete == false
      verify_name = false
      while verify_name == false
        team_name  = MenuHelper.query("Please enter the name of your team")
        if @all_teams.any? {|team| team.name == team_name}
          puts "#{team_name} already taken. Please select a new name."
        else
          verify_name = true
        end
      end
      verify_attack = false
      while verify_attack == false
        attack = MenuHelper.query("Please enter the team attack strength (1 to 10)").to_i
        if attack <= 0 || attack > 10
          puts "Invalid number"
        else
          verify_attack = true
        end
      end
      verify_defense = false
      while verify_defense == false
        defense = MenuHelper.query("Please enter the team defense strength (1 to 10)").to_i
        if defense <= 0 || defense > 10
          puts "Invalid number"
        else
          verify_defense = true
        end
      end
      verify_conditions = false
      while verify_conditions == false
        condition_preference = MenuHelper.query("Does this team play better in wet or dry conditions? ('wet' or 'dry')").downcase
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
      display_options = {name: true, attack: true, defense: true, luck: true, condition_preference: true}
      display_formatted_team(team, display_options)
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
    puts "NOTE:".colorize(:red) + " Leave the field blank to leave the team info the same"
    team_to_edit = find_team
    new_name = MenuHelper.query("Please enter the new name for the team")
    new_attack = MenuHelper.query("Please enter the new attack value for the team")
    new_defense = MenuHelper.query("Please enter the new defense value for the team")
    new_conditions_preference = MenuHelper.query("Please enter the new conditions preference value ('wet' or 'dry') for the team")
    team_to_edit.edit_team_values(new_name, new_attack, new_defense, new_conditions_preference)
    puts "New Values".colorize(:green)
    display_formatted_team(team_to_edit)
    press_any_key_to_continue
  end

  def Menu.find_team
    found = false
    while found == false
      selection = MenuHelper.query("Enter the name of the team")
      result = MenuHelper.find_team(@all_teams, selection)
      result != false ? found = true : found = false
    end
    return result
  end

  def Menu.simulate_game
    clear_screen
    if @all_teams.length < 2
      puts "Not enough teams entered to play a game. Returning to menu."
      press_any_key_to_continue
    else
      page_divide
      display_team_names
      home_team = MenuHelper.query("Enter home team")
      away_team = MenuHelper.query("Enter away team")
      game = Game.new(home_team, away_team)
      game.play
    end
  end

  def Menu.finish_season
    puts "Wiping season"
    press_any_key_to_continue
    MenuHelper.finish_season
  end

  def Menu.see_season_results
    Game.season_results
  end

  def Menu.delete_team
    clear_screen
    display_team_names
    puts "Delete Team"
    team_to_delete = find_team
    @all_teams.delete(team_to_delete)
  end

end
Menu.main_menu
