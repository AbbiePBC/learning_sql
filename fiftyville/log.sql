-- Keep a log of any SQL queries you execute as you solve the mystery.
-- find out more about the crimes on this street at the time
 SELECT description FROM crime_scene_reports WHERE year = 2020 AND month = 7 AND day = 28 AND street = "Chamberlin Street";
 -- 10:15 am, at courthouse. 3 witnesses => look through transcripts to find mention of courthouse.
 SELECT transcript, name  FROM interviews WHERE month = 7 AND year = 2020 AND transcript LIKE "%courthouse%";
 -- Ruth says thief gets in car after 10 min ish; check security footage
 -- Eugene says they recognised the thief -> withdrawal at ATM on Fifer street
 -- Raymond: thief was on the phone for < 1 min. planning earliest flight tomorrow; other end purchased ticket.

 -- check security first and check license plate against people table
 SELECT name FROM people JOIN courthouse_security_logs ON people.license_plate = courthouse_security_logs.license_plate  WHERE month = 7 AND year = 2020 AND day = 28 AND minute BETWEEN 15 AND 25 AND hour = 10;
 --Patrick
--Ernest
--Amber
--Danielle
--Roger
--Elizabeth
--Russell
--Evelyn
SELECT name FROM people JOIN bank_accounts ON people.id = bank_accounts.person_id JOIN atm_transactions ON bank_accounts.account_number = atm_transactions.account_number WHERE day = 28 AND month = 7 AND year = 2020 AND atm_location LIKE "%Fifer%" AND transaction_type = "withdraw";
--Ernest
--Russell
--Roy
--Bobby
--Elizabeth
--Danielle
--Madison
--Victoria
--SHORTLIST = ernest, russel, elizabeth
SELECT name FROM people JOIN  phone_calls ON phone_calls.caller = people.phone_number  WHERE day = 28 AND month = 7 AND year = 2020 AND duration < 100;
-- not elizabeth; could be russell or ernest; can do smae w recievers.
SELECT caller,receiver, name, duration  FROM phone_calls JOIN people ON phone_calls.caller = people.phone_number WHERE phone_calls.day = 28 AND month = 7 AND year = 2020 AND duration < 100;
-- ernest called two numbers: (Carl) (704) 555-5790  (375) 555-8161 (Berthold);
SELECT name FROM people WHERE phone_number = "(704) 555-5790" ;
SELECT name FROM people WHERE phone_number = "(375) 555-8161" ;
-- russell called (725) 555-3243 
SELECT name FROM people WHERE phone_number = "(725) 555-3243" ;
-- russell called phillip

-- which flights could the thief be on? 
SELECT city, airports.id  FROM airports JOIN flights ON airports.id = flights.destination_airport_id WHERE day = 29 AND year = 2020 AND month = 7 ORDER BY flights.hour ASC;
-- flight to London
SELECT name FROM people JOIN  passengers ON people.passport_number = passengers.passport_number JOIN flights ON passengers.flight_id = flights.id WHERE day = 29 AND year = 2020 AND month = 7 AND destination_airport_id = 4 ;
-- ernest.
-- is his accomplice carl or berthold??
-- carl took > 1 min; Berthold < 1 min