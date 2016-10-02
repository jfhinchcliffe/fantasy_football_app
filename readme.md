## Fantasy Football terminal app

### Week 3 CoderFactoryAcademy project

*Use*

1. Download
2. Navigate to home directory in terminal
3. Run `ruby .lib/menu.rb` in terminal
4. Bask in the glow of what is probably the most full-featured and user friendly football simulator ever concieved by man ⚽  "

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
- ~~DRY up menu~~
- ~~Setup verification for values  attack and defense should be 1-10 and conditions dry or wet~~
- ~~Make sure that team names can't be the same.~~
- ~~refactor / dry up some of those long gnarly methods in the menu.rb file~~
- ~~split out 'create_team' into its' own method~~
- ~~create an algorithm to simulate a game and return a game result~~
  - ~~home team get a bonus~~
  - ~~preferred conditions (dry or wet) gets a bonus~~
  - ~~need to turn attack and defense stats against one another~~
  - ~~luck can play a part (underdogs can occasionally win)~~

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
