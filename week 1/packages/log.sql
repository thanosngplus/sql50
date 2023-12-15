
-- *** The Lost Letter ***
-- Get the id for the address where the sender (Anneke) lives
SELECT "id" FROM "addresses"
WHERE "address" = '900 Somerville Avenue';
-- Find the package whose from_address_id matches the id I got from the query above
SELECT * FROM "packages"
WHERE "from_address_id" = (
    SELECT "id" FROM "addresses"
    WHERE "address" = '900 Somerville Avenue'
);
-- There's only one congratulatory letter! Let's see where the t_address_id 585 matches
SELECT * FROM "addresses"
WHERE "id" = 854;
-- The address seems correct, meaning the sender didn't accidentally used the wrong address.
-- Let's check the package id on scans to see its status
SELECT * FROM "scans"
WHERE "package_id" = 384;

-- The package was delivered successfully to its destination!
-- Alternatively, let's compose some queries!
SELECT "address", "type" FROM "addresses"
WHERE "id" = (
    SELECT "address_id" FROM "scans"
    WHERE "package_id" = (
        SELECT "id" FROM "packages"
        WHERE "from_address_id" = (
            SELECT "id" FROM "addresses"
            WHERE "address" = '900 Somerville Avenue'
        ) AND "contents" LIKE 'Congratulatory%'
    ) AND "action" = 'Drop'
);
-- *** The Devious Delivery ***
-- Since my first clue is thatt the package ahs no FROM address, I'll start from there!
SELECT * FROM "packages"
WHERE "from_address_id" IS NULL;
-- Then I'll check its delivery status (where it got picked up, and dropped to) from scans
SELECT * FROM "scans"
WHERE "package_id" = (
  	SELECT "id" FROM "packages"
	WHERE "from_address_id" IS NULL
);
-- it looks like it got dropped off somewhere!
SELECT type FROM addresses
WHERE id = (
	SELECT address_id FROM scans
	WHERE package_id = (
  		SELECT id FROM packages
		WHERE from_address_id IS NULL
	) AND "action" = 'Drop'
);
-- Oops! Police station!

-- *** The Forgotten Gift ***
-- First I'll detect the package
SELECT * FROM packages
WHERE from_address_id = (
  SELECT id from addresses
  WHERE address = '109 Tileston Street'
);
-- One package of flowers! Let's use the id to see where it got dropped
SELECT * FROM scans
WHERE package_id = (
  	SELECT id FROM packages
	WHERE from_address_id = (
  		SELECT id from addresses
  		WHERE address = '109 Tileston Street'
	)
) ORDER BY timestamp DESC;
-- Looks like the last scan was from the driver with the id 11 but it never got delivered
SELECT "name" FROM "drivers"
WHERE "id" = (
    SELECT "driver_id"
    FROM "scans"
    WHERE "package_id" = (
        SELECT "id"
        FROM "packages"
        WHERE "from_address_id" = (
            SELECT "id"
            FROM "addresses"
            WHERE "address" = '109 Tileston Street'
        )
        ORDER BY "timestamp" DESC
    )
);
-- Mikel has it
