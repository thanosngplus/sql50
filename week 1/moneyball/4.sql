SELECT "first_name",
       "last_name",
       "salary"
FROM "salaries"
JOIN "players" ON "salaries"."player_id" = "players"."id"
WHERE "salaries"."year" = 2001
ORDER  BY "salary" ASC,
          "first_name" ASC,
          "last_name" ASC,
          "players"."id" ASC
LIMIT 50;
