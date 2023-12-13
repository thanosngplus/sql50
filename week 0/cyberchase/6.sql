/* list the titles of episodes from season 6 (2008) that were released early, in 2007 */
SELECT "title" FROM "episodes"
WHERE "air_date" LIKE '2007%'
AND "season" = 6;
