require 'colorize'
require './team'

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
      luck = rand(1..10)
      puts "Team luck has been randomly calculated as #{luck}"
      page_divide
      puts "Name: ".colorize(:yellow) + "#{team_name}"
      puts "Attack: ".colorize(:yellow) + "#{attack}"
      puts "Defense:".colorize(:yellow) + " #{defense}"
      puts "Luck:".colorize(:yellow) + " #{luck}"
      puts "Are you happy with this? (Y/N)"
      prompt
      happy = get_input.upcase
      happy == "Y" ? team_complete = true : team_complete = false
    end
    team_information = {name: team_name, attack: attack.to_i, defense: defense.to_i, luck: luck}
    team = Team.new(team_information)
    puts team
    @all_teams << team
    puts @all_teams
    # puts "NAME: #{team.name}"
    # puts "ATTACK: #{team.attack}"
    # puts "DEFENSE: #{team.defense}"
    # puts "LUCK: #{team.luck}"
    press_any_key_to_continue
  end

  def Menu.see_all_teams
    @all_teams.each do |team|
      puts team.name
      puts team.attack
      puts team.defense
      puts team.luck
    end
    press_any_key_to_continue
  end


end
Menu.main_menu
