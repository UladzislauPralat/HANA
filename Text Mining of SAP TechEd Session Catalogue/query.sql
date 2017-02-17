SET SCHEMA TM_DEMO;

-- Find all documents in the collection that are similar to the above document.
    SELECT T.SESSION, T.TITLE, T.TOTAL_TERM_COUNT, T.SCORE
	FROM TM_GET_RELATED_DOCUMENTS (
		DOCUMENT IN FULLTEXT INDEX WHERE  session = 'DEV260'
		SEARCH "DESCRIPTION" FROM "TM_DEMO"."tm_demo::session"
		RETURN TOP 20
		SESSION, TITLE
	) AS T;

-- Find key terms representing a given document (relative to the overall collection).
    SELECT T.TERM, T.NORMALIZED_TERM, T.TERM_TYPE, T.TERM_FREQUENCY, T.DOCUMENT_FREQUENCY, T.SCORE
	FROM TM_GET_RELEVANT_TERMS (
    DOCUMENT IN FULLTEXT INDEX WHERE  session = 'DEV260'
		SEARCH "DESCRIPTION" FROM "TM_DEMO"."tm_demo::session"
		RETURN TOP 20
	) AS T;

-- Find other terms closely related to a given term (e.g., "Fiori") in this collection.
    SELECT T.TERM, T.NORMALIZED_TERM, T.TERM_TYPE, T.TERM_FREQUENCY, T.DOCUMENT_FREQUENCY, T.SCORE
	FROM TM_GET_RELATED_TERMS (
		TERM 'Fiori'
		SEARCH "DESCRIPTION" FROM "TM_DEMO"."tm_demo::session"
		RETURN TOP 20
	) AS T;
	
-- Use Text Mining to find documents relevant to some search term (e.g., "Fiori").
    SELECT T.SESSION, T.TITLE, T.TOTAL_TERM_COUNT, T.SCORE
	FROM TM_GET_RELEVANT_DOCUMENTS (
		TERM 'Fiori'
		SEARCH "DESCRIPTION" FROM "TM_DEMO"."tm_demo::session"
		RETURN TOP 20
  		SESSION, TITLE
	) AS T;	
	
-- Categorize a DEV161 2014 new document (not already in the collection).
SELECT T.RANK, T.CATEGORY_VALUE, NEIGHBOR_COUNT, SCORE
	FROM TM_CATEGORIZE_KNN (
		DOCUMENT '
        In this hands-on session, we cover how to code stored procedures and user-defined functions in SQLScript. 
        We explore some of the more advanced features of the SQLScript language, such as arrays, exception handling, 
        dynamic filtering, and cursors. Finally, learn how to consume SQLScript stored procedures from ABAP applications.'
		SEARCH NEAREST NEIGHBORS 20 "DESCRIPTION" FROM "TM_DEMO"."tm_demo::session"
		RETURN TOP 20
		CATEGORY FROM "TM_DEMO"."tm_demo::session"
	) AS T;	
	
