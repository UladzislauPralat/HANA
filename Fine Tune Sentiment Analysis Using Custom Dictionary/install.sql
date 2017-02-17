CALL "_SYS_REPO"."GRANT_ACTIVATED_ROLE"('ta_demo::TA_DEMO_ROLE','SYSTEM');

SET SCHEMA TA_DEMO;

CREATE COLUMN TABLE REVIEW(
     id integer primary key,
     username CHAR(40),
     CONTENT NVARCHAR(2000));
	
INSERT INTO REVIEW VALUES (1, 'John Smith', 'Beware of high power microwave. After 20 seconds of melting chocolate in a microwave safe bowl it caught fire');
INSERT INTO REVIEW VALUES (2, 'Dave Williams', 'The worst company I have ever had to deal with ! 
I bought a 42" LCD TV. In 10 months into having this product 2 of my HDMI inputs no longer work. This is unacceptable');     
INSERT INTO REVIEW VALUES (3, 'Peter Brown', 'The movers smashed the screen on my 50" plasma. It was the best picture we''ve ever seen. I know this is a long shot, but what are the chances of finding a replacement screen for it?
Please help');

CREATE FULLTEXT INDEX REVIEW_IDX ON "REVIEW"(CONTENT) FAST PREPROCESS OFF
LANGUAGE DETECTION ('EN', 'FR') TEXT ANALYSIS ON
CONFIGURATION  'EXTRACTION_CORE_VOICEOFCUSTOMER';