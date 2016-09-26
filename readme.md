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
