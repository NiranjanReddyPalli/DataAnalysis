/*IPL Data Analysis (2008-2016) using MySQL

source of Data: https://github.com/12345k/IPL-Dataset

Analysis:

{1} Table Schema information using DESC command:*/

show databases;
use ipl;
show tables;
desc matches;

-- {2} Sample records to get idea of data present in the table matches:--

select * from matches;

-- {3} Total records in matches table:

select count(id) as total_records from matches;

-- {4} Number of matches played in each season:

select season, count(id) from matches 
group by season;

-- {5} a)Team won Batting first: 
SELECT count(id) as Team_won_Batting_First FROM matches 
WHERE win_by_runs>0;


    -- b)Team Won Batting Second:

SELECT count(id) as Team_won_Batting_Second FROM matches 
WHERE win_by_wickets>0;

   -- c)Tied Matches (No Result):
SELECT count(id) as No_Result FROM matches 
WHERE win_by_wickets=0 AND win_by_runs=0;

-- {6} Tied match details:
select id, season, date, team1, team2, result, city, venue  from matches 
where result = 'tie' or result = 'no result';

-- {7} Most successful team - Team which won most number of matches:

select winner, count(winner) as no_of_matches_won from matches 
group by winner 
order by count(winner) desc;

-- {8} Total matches played by each team:

-- Definition of matches played : Teams playing a match can be in both the columns team1 and team2. 
-- Hence we are counting the the no.of matches played by each team seperately and combining them by using union all.

select t.team1 as team, sum(total) as total_matches_played
from (select team1, count(team1) as total from matches 
	  group by team1
union all
      select team2, count(team2) as total from matches 
      group by team2) as t
group by team
order by total_matches_played desc;

-- {9}  Count of no.of times each team winning the toss:
select team1 as team, count(toss_winner) as no_of_toss_wins from matches 
group by toss_winner 
order by no_of_toss_wins desc; 

-- {10}  Toss winning percentage (TWP)
select tm.team, tm.no_of_matches_played, tc.toss_count, (tc.toss_count/tm.no_of_matches_played)*100 as TWP 
from (select t.team1 as team, sum(total) as no_of_matches_played from (select team1, count(team1) as total from matches group by team1
union all
select team2, count(team2) as total from matches group by team2) as t
group by team) as tm
inner join 
(select toss_winner, count(toss_winner) as toss_count from matches group by toss_winner) as tc
on tm.team = tc.toss_winner
order by TWP desc;

-- {11} Team with highest no.of wins in a given year:
select season, winner, count(winner) as most_wins from matches
where season = 2008
group by (winner)
order by most_wins desc
limit 1;


