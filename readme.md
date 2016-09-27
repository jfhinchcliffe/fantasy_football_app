## Fantasy Football terminal app

### Week 3 CoderFactoryAcademy project

*Problem*
- User wants to simulate the result of a football game without having to play.
*Actions*
- Create teams (with stats)
- Save teams
- Simulate games between teams
- Save results to file
*User Stories*
- As a user, I want to be able to enter team information
- As a user, I want to simulate a game and save the results

### To Do
- Setup verification for values  attack and defense should be 1-10 and conditions dry or wet
- Make sure that team names can't be the same.
- refactor / dry up some of those long gnarly methods in the menu.rb file
- split out 'create_team' into its' own method
- create an algorithm to simulate a game and return a game result
  - home team get a bonus
  - preferred conditions (dry or wet) gets a bonus
  - need to turn attack and defense stats against one another
  - luck can play a part (underdogs can occasionally win)

  team_1_name | attack(5) | defense(7) | luck(8)
  team_2_name | attack(10) | defense(9) | luck(5)

  1. team_1_name.attack - team_2_name.defense == -4 + 10 == 6
  2. team_2_name.attack - team_2_name.defense == 3 + 10 == 14
  3. add luck rand(0..team_1_name.luck) * luck == 6 * 2
  4. add luck rand(0..team_2_name.luck) * luck == 3 * 5

  home_team modifier

##Setup

_Classes_

*Team*
  - name
  - attack
  - defense
  - weather_preference (1 (dry)-10(wet))
  - luck
  - home_ground

*Game*
(takes home team, away team, )
  - result (saves to file)
Methods
  - Play game
  - save result

*Ground*
  - name
  - weather (dry, wet)
Methods
  - set weather

_Modules_  
*Menu*
  - (Display amount of teams in competition)
  - Simulate Game
  - See Results
  - See all teams
  - Create Team
  - Delete Team
  - Edit Team
  - New Season
2 file s- past season and current season.
