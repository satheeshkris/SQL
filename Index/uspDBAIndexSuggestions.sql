/**********************************************************************************
*   Name:      			uspDBAIndexSuggestions 
*   Author:           	Bob Delamater
*   Creation Date:    	04/16/2007
*   Description:     	DBA helper: Helps to identify which columns 
*						could benefit from indexing
*		     	
*   Parameters: 		None
*	Requirements:		Must be deployed at the Phoenix location. 
*   Returns: 			Nothing
*	Known Issues:		This procedure may fail if there are any database restorations
						occurring. 
*************************************************************************************/
CREATE PROCEDURE [dbo].[uspDBAIndexSuggestions] AS

SELECT 
	avg_total_user_cost * avg_user_impact * (user_seeks + user_scans) AS Quantifier,
	*
FROM sys.dm_db_missing_index_group_stats AS migs
	JOIN sys.dm_db_missing_index_groups AS mig
		ON (migs.group_handle = mig.index_group_handle)
	JOIN sys.dm_db_missing_index_details AS mid
		ON (mig.index_handle = mid.index_handle)
WHERE database_id = db_id('prod_dfent_v32')
ORDER BY 
	avg_total_user_cost * avg_user_impact * (user_seeks + user_scans)DESC;


