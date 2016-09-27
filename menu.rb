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
      puts "1. Simulate Game WIP"
      puts "2. See Season Results"
      puts "3. See All Teams"
      puts "4. Build New Team"
      puts "5. Edit Team"
      puts "6. Delete Team WIP"
      puts "7. Deletes Season Information WIP"
      page_divide
      puts "8. Exit Application".colorize(:red)
      page_divide
      puts "9. CHEAT MODE! Auto-populate a team".colorize(:yellow)
      selection = MenuHelper.query("Please make a selection")
      case selection
        when "1"
          simulate_game
        when "2"
          see_season_results
        when "3"
          see_all_teams
        when "4"
          build_new_team
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

  def Menu.build_new_team
    clear_screen
    team_complete = false
    while team_complete == false
      team_name = MenuHelper.unique_team_name_verification(@all_teams)
      attack = MenuHelper.stat_verification("attack")
      defense = MenuHelper.stat_verification("defense")
      condition_preference = MenuHelper.acceptable_response(["wet","dry"])
      luck = MenuHelper.num_generator(10, "luck")
      page_divide
      MenuHelper.pretty_format_team({name: team_name, attack: attack, defense: defense, luck: luck, condition_preference: condition_preference})
      happy = MenuHelper.query("Are you happy with these stats? (y/n)").downcase
      happy == "y" ? team_complete = true : team_complete = false
    end
    team_information = {name: team_name, attack: attack, defense: defense, luck: luck, condition_preference: condition_preference}
    create_team(team_information)
  end

  def Menu.create_team(team_information)
    team = Team.new(team_information)
    @all_teams << team
    puts "#{team.name} added."
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
    new_team = MenuHelper.team_constructor
    create_team(new_team)
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
