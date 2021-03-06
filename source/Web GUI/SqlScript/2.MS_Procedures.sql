IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RETRIEVE_ARTEFACT_TYPE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[RETRIEVE_ARTEFACT_TYPE]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDSD]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_WBS_GetDSD]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDataflows]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_WBS_GetDataflows]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetConceptSchemes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_WBS_GetConceptSchemes]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetCodelists]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_WBS_GetCodelists]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_STRUCTURESET]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[INSERT_STRUCTURESET]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_ORGANISATIONUNIT_SCHEME]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[INSERT_ORGANISATIONUNIT_SCHEME]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_LOCALISED_STRING_I]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[INSERT_LOCALISED_STRING_I]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_HCL_I]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[INSERT_HCL_I]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_DSD_I]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[INSERT_DSD_I]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_DATAFLOW_I]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[INSERT_DATAFLOW_I]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_CONCEPT_SCHEME_I]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[INSERT_CONCEPT_SCHEME_I]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_CONCEPT_I]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[INSERT_CONCEPT_I]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_CODELIST_I]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[INSERT_CODELIST_I]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_CATEGORY_SCHEME_I]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[INSERT_CATEGORY_SCHEME_I]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_CATEGORY_I]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[INSERT_CATEGORY_I]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_CATEGORISATION_I]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[INSERT_CATEGORISATION_I]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_ARTEFACT_I]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[INSERT_ARTEFACT_I]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_ANNOTATION_I]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[INSERT_ANNOTATION_I]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GET_CL_ID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GET_CL_ID]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_STRUCTURE_SET]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DELETE_STRUCTURE_SET]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_ORGANISATIONUNIT_SCHEME]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DELETE_ORGANISATIONUNIT_SCHEME]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_DSD]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DELETE_DSD]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_DATAPROVIDER_SCHEME]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DELETE_DATAPROVIDER_SCHEME]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_DATAFLOW]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DELETE_DATAFLOW]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_DATACONSUMER]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DELETE_DATACONSUMER]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_CONCEPT_SCHEME]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DELETE_CONCEPT_SCHEME]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_CODELIST]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DELETE_CODELIST]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_CATEGORY_SCHEME]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DELETE_CATEGORY_SCHEME]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_CATEGORISATION]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DELETE_CATEGORISATION]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_ANNOTATION]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DELETE_ANNOTATION]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_AGENCY_SCHEME]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DELETE_AGENCY_SCHEME]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_AGENCY_SCHEME]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



/*

EXEC DELETE_AGENCY_SCHEME 1
*/
CREATE PROCEDURE [dbo].[DELETE_AGENCY_SCHEME]

@ART_ID BIGINT

AS


/**** TABLE LIST ***
ANNOTATION
LOCALISED_STRING
ITEM
AGENCY
AGENCY_SCHEME
ARTEFACT
*/

	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;


	DECLARE @ART_TYPE VARCHAR(500)
	EXEC RETRIEVE_ARTEFACT_TYPE @ART_ID, @ART_TYPE OUT

	IF @ART_TYPE IS NULL 
		RETURN 
	ELSE IF @ART_TYPE <> ''AGENCY_SCHEME''
		RAISERROR (''Incorrect Artefact Type or Artefact ID!'', -- Message text.
		   16, -- Severity.
		   1 -- State.
		   );	

	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

				EXEC dbo.DELETE_ANNOTATION @ART_ID = @ART_ID;
				
				-- DELETE LOCALISED_STRING
				DELETE LOCALISED_STRING
				FROM AGENCY_SCHEME A 
					INNER JOIN dbo.AGENCY B ON
						A.AG_SCH_ID = B.AG_SCH_ID
					INNER JOIN LOCALISED_STRING C ON
						C.ART_ID = A.AG_SCH_ID 
						OR B.AG_ID = C.ITEM_ID
				WHERE A.AG_SCH_ID = @ART_ID

				SELECT *
				INTO #AGENCY
				FROM AGENCY
				WHERE AG_SCH_ID = @ART_ID

				-- DELETE AGENCY
				DELETE AGENCY
				WHERE AG_SCH_ID = @ART_ID
				
				-- DELETE ITEM
				DELETE ITEM
				FROM #AGENCY A
					INNER JOIN ITEM B ON
						A.AG_ID = B.ITEM_ID
				WHERE AG_SCH_ID = @ART_ID

				-- DELETE AGENCY_SCHEME
				DELETE AGENCY_SCHEME
				WHERE AG_SCH_ID = @ART_ID

				-- DELETE ARTEFACT
				DELETE ARTEFACT
				WHERE ART_ID = @ART_ID
			
		IF @starttrancount = 0 
			COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   16, -- Severity.
				   @ErrorState -- State.
				   );	
	END CATCH








' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_ANNOTATION]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


/*
begin tran 
exec DELETE_ANNOTATION 5
*/
CREATE PROCEDURE [dbo].[DELETE_ANNOTATION]
	@ART_ID BIGINT
AS

	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;


	DECLARE @BYNARY_IDS BIGINT
	DECLARE @BYNARY_DELETE BIGINT

	DECLARE @ART_TYPE VARCHAR(500)
	EXEC RETRIEVE_ARTEFACT_TYPE @ART_ID, @ART_TYPE OUT

	IF @ART_TYPE IS NULL 
		RAISERROR (''Incorrect Artefact Type or Artefact ID!'', -- Message text.
		   16, -- Severity.
		   1 -- State.
		   );
PRINT ''@ART_TYPE: ''+ @ART_TYPE		   
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION
			
			CREATE TABLE #ANN_IDS
			(
				ANN_ID BIGINT
			)
			

			IF @ART_TYPE = ''AGENCY_SCHEME'' 
				SELECT @BYNARY_IDS = 1 + 4, @BYNARY_DELETE = 1 + 2
			ELSE IF @ART_TYPE = ''CATEGORISATION'' 
				SELECT @BYNARY_IDS = 1, @BYNARY_DELETE = 1
			ELSE IF  @ART_TYPE = ''CATEGORY_SCHEME'' 
				SELECT @BYNARY_IDS = 1 + 128, @BYNARY_DELETE = 1 + 2
			ELSE IF  @ART_TYPE = ''CODELIST'' 
				SELECT @BYNARY_IDS = 1 + 2, @BYNARY_DELETE = 1 + 2
			ELSE IF  @ART_TYPE = ''CONCEPT_SCHEME'' 
				SELECT @BYNARY_IDS = 1 + 8, @BYNARY_DELETE = 1 + 2
			ELSE IF  @ART_TYPE = ''DATACONSUMER_SCHEME'' 
				SELECT @BYNARY_IDS = 1 + 16, @BYNARY_DELETE = 1 + 2
			ELSE IF  @ART_TYPE = ''DATAFLOW'' 
				SELECT @BYNARY_IDS = 1, @BYNARY_DELETE = 1
			ELSE IF  @ART_TYPE = ''DATAPROVIDER_SCHEME'' 
				SELECT @BYNARY_IDS = 1 + 32, @BYNARY_DELETE = 1 + 2
			ELSE IF  @ART_TYPE = ''DSD'' 
				SELECT @BYNARY_IDS = 1 + 512 + 1024, @BYNARY_DELETE = 1 + 4 + 8
			ELSE IF  @ART_TYPE = ''HCL'' 
				--PERSONALIZZATO IN DELETE_HCL
				SELECT @BYNARY_IDS = 0, @BYNARY_DELETE = 0
			ELSE IF  @ART_TYPE = ''ORGANISATION_UNIT_SCHEME'' 
				SELECT @BYNARY_IDS = 1 + 64, @BYNARY_DELETE = 1 + 2
			ELSE IF  @ART_TYPE = ''STRUCTURE_SET'' 
				SELECT @BYNARY_IDS = 1 + 256, @BYNARY_DELETE = 1 + 2

			
			-------- **** INSERT ANN_IDS **** -------------
			-- ARTEFACT --			
			IF (@BYNARY_IDS & 1) > 0
				INSERT INTO #ANN_IDS
				SELECT ANN_ID
				FROM ARTEFACT_ANNOTATION
				WHERE ART_ID = @ART_ID

			-- ITEM --
			IF (@BYNARY_IDS & 2) > 0
				INSERT INTO #ANN_IDS
				SELECT C.ANN_ID
				FROM DSD_CODE B
					INNER JOIN dbo.ITEM_ANNOTATION C ON
						C.ITEM_ID = B.LCD_ID
				WHERE B.CL_ID = @ART_ID

			-- AGENCY --
			IF (@BYNARY_IDS & 4) > 0
				INSERT INTO #ANN_IDS
				SELECT C.ANN_ID
				FROM AGENCY B
					INNER JOIN dbo.ITEM_ANNOTATION C ON
						C.ITEM_ID = B.AG_ID
				WHERE B.AG_SCH_ID = @ART_ID			

			-- CONCEPT --
			IF (@BYNARY_IDS & 8) > 0
				INSERT INTO #ANN_IDS
				SELECT C.ANN_ID
				FROM dbo.CONCEPT B
					INNER JOIN dbo.ITEM_ANNOTATION C ON
						C.ITEM_ID = B.CON_ID
				WHERE B.CON_SCH_ID = @ART_ID			

			-- DATA CONSUMER --
			IF (@BYNARY_IDS & 16) > 0
				INSERT INTO #ANN_IDS
				SELECT C.ANN_ID
				FROM dbo.DATACONSUMER B
					INNER JOIN dbo.ITEM_ANNOTATION C ON
						C.ITEM_ID = B.DC_ID
				WHERE B.DC_SCH_ID = @ART_ID			

			-- DATA PROVIDER --
			IF (@BYNARY_IDS & 32) > 0
				INSERT INTO #ANN_IDS
				SELECT C.ANN_ID
				FROM dbo.DATAPROVIDER B
					INNER JOIN dbo.ITEM_ANNOTATION C ON
						C.ITEM_ID = B.DP_ID
				WHERE B.DP_SCH_ID = @ART_ID					

			-- ORGANISATION UNIT --
			IF (@BYNARY_IDS & 64) > 0
				INSERT INTO #ANN_IDS
				SELECT C.ANN_ID
				FROM dbo.ORGANISATION_UNIT B
					INNER JOIN dbo.ITEM_ANNOTATION C ON
						C.ITEM_ID = B.ORG_UNIT_ID
				WHERE B.ORG_UNIT_SCH_ID = @ART_ID	

			-- CATEGORY --
			IF (@BYNARY_IDS & 128) > 0
				INSERT INTO #ANN_IDS
				SELECT C.ANN_ID
				FROM dbo.CATEGORY B
					INNER JOIN dbo.ITEM_ANNOTATION C ON
						C.ITEM_ID = B.CAT_ID
				WHERE B.CAT_SCH_ID = @ART_ID	

			-- STRUCTURE SET --
			IF (@BYNARY_IDS & 256) > 0
				INSERT INTO #ANN_IDS
				SELECT B.ANN_ID
				FROM dbo.CODELIST_MAP A
					INNER JOIN dbo.ITEM_ANNOTATION B ON
						A.CLM_ID = B.ITEM_ID					
				WHERE SS_ID = @ART_ID

			-- COMPONENT --
			IF (@BYNARY_IDS & 512) > 0
				INSERT INTO #ANN_IDS
				SELECT B.ANN_ID
				FROM dbo.COMPONENT A
					INNER JOIN dbo.COMPONENT_ANNOTATION B ON
						A.COMP_ID = B.COMP_ID					
				WHERE A.DSD_ID = @ART_ID

			-- GROUP
			IF (@BYNARY_IDS & 1024) > 0
				INSERT INTO #ANN_IDS
				SELECT B.ANN_ID
				FROM dbo.DSD_GROUP A
					INNER JOIN GROUP_ANNOTATION B ON
						A.GR_ID = B.GR_ID					
				WHERE A.DSD_ID = @ART_ID				
			
	
			--------- **** DELETE ANNOTATION''S TABLES **** --------------
			
			IF (@BYNARY_DELETE & 1) > 0 
				DELETE ARTEFACT_ANNOTATION
				FROM ARTEFACT_ANNOTATION A
					INNER JOIN #ANN_IDS B ON
						A.ANN_ID = B.ANN_ID

			IF (@BYNARY_DELETE & 2) > 0
				DELETE ITEM_ANNOTATION
				FROM ITEM_ANNOTATION A
					INNER JOIN #ANN_IDS B ON
						A.ANN_ID = B.ANN_ID

			IF (@BYNARY_DELETE & 4) > 0 
				DELETE GROUP_ANNOTATION
				FROM GROUP_ANNOTATION A
					INNER JOIN #ANN_IDS B ON
						A.ANN_ID = B.ANN_ID

			IF (@BYNARY_DELETE & 8) > 0 
				DELETE COMPONENT_ANNOTATION
				FROM COMPONENT_ANNOTATION A
					INNER JOIN #ANN_IDS B ON
						A.ANN_ID = B.ANN_ID
			
			
			-- DELETE ANNOTATION_TEXT
			DELETE ANNOTATION_TEXT
			FROM ANNOTATION_TEXT A
				INNER JOIN #ANN_IDS B ON
					A.ANN_ID = B.ANN_ID

			-- DELETE ANNOTATION
			DELETE ANNOTATION
			FROM ANNOTATION A
				INNER JOIN #ANN_IDS B ON
					A.ANN_ID = B.ANN_ID
 
 
 		IF @starttrancount = 0 
			COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   16, -- Severity.
				   @ErrorState -- State.
				   );	
	END CATCH
	



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_CATEGORISATION]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[DELETE_CATEGORISATION]
@ART_ID BIGINT

AS


/**** TABLE LIST ***
ANNOTATION
LOCALISED_STRING
CATEGORISATION
ARTEFACT
*/
	SET NOCOUNT ON;
	SET XACT_ABORT ON;


	DECLARE @ART_TYPE VARCHAR(500)
	EXEC RETRIEVE_ARTEFACT_TYPE @ART_ID, @ART_TYPE OUT

	IF @ART_TYPE IS NULL 
		RETURN 
	ELSE IF @ART_TYPE <> ''CATEGORISATION''
		RAISERROR (''Incorrect Artefact Type or Artefact ID!'', -- Message text.
		   16, -- Severity.
		   1 -- State.
		   );
		   	
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

				EXEC dbo.DELETE_ANNOTATION @ART_ID = @ART_ID;

				-- DELETE LOCALISED_STRING
				DELETE LOCALISED_STRING
				WHERE ART_ID = @ART_ID 

				-- DELETE CATEGORISATION
				DELETE CATEGORISATION
				WHERE CATN_ID = @ART_ID

				-- DELETE ARTEFACT
				DELETE ARTEFACT
				WHERE ART_ID = @ART_ID
			
		IF @starttrancount = 0 
			COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   16, -- Severity.
				   @ErrorState -- State.
				   );	
	END CATCH




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_CATEGORY_SCHEME]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




CREATE PROCEDURE [dbo].[DELETE_CATEGORY_SCHEME]

@ART_ID BIGINT

AS


/**** TABLE LIST ***
ANNOTATION
LOCALISED_STRING
ITEM
CATEGORY
CATEGORY_SCHEME
ARTEFACT
*/
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	
	DECLARE @ART_TYPE VARCHAR(500)
	EXEC RETRIEVE_ARTEFACT_TYPE @ART_ID, @ART_TYPE OUT

	IF @ART_TYPE IS NULL 
		RETURN 
	ELSE IF @ART_TYPE <> ''CATEGORY_SCHEME''
		RAISERROR (''Incorrect Artefact Type or Artefact ID!'', -- Message text.
		   16, -- Severity.
		   1 -- State.
		   );
	
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

				EXEC dbo.DELETE_ANNOTATION @ART_ID = @ART_ID;

				-- DELETE LOCALISED_STRING
				DELETE LOCALISED_STRING
				FROM CATEGORY B
					INNER JOIN LOCALISED_STRING C ON
						C.ART_ID = B.CAT_SCH_ID 
						OR B.CAT_ID = C.ITEM_ID
				WHERE B.CAT_SCH_ID = 5

				-- DELETE ITEM
				DELETE ITEM
				FROM CATEGORY A
					INNER JOIN ITEM B ON
						A.CAT_ID = B.ITEM_ID
				WHERE CAT_SCH_ID = @ART_ID

				-- DELETE CATEGORY
				DELETE CATEGORY
				WHERE CAT_SCH_ID = @ART_ID

				-- DELETE CATEGORY_SCHEME
				DELETE CATEGORY_SCHEME
				WHERE CAT_SCH_ID = @ART_ID

				DELETE dbo.LOCALISED_STRING
				WHERE ART_ID = @ART_ID
				
				-- DELETE ARTEFACT
				DELETE ARTEFACT
				WHERE ART_ID = @ART_ID
			
		IF @starttrancount = 0 
			COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   16, -- Severity.
				   @ErrorState -- State.
				   );	
	END CATCH
	
	





' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_CODELIST]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[DELETE_CODELIST]

@ART_ID BIGINT

AS


/**** TABLE LIST ***
ANNOTATION
LOCALISED_STRING
ITEM
DSD_CODE
CODELIST
ARTEFACT
*/

	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	

	DECLARE @ART_TYPE VARCHAR(500)
	EXEC RETRIEVE_ARTEFACT_TYPE @ART_ID, @ART_TYPE OUT

	IF @ART_TYPE IS NULL 
		RETURN 
	ELSE IF @ART_TYPE <> ''CODELIST''
		RAISERROR (''Incorrect Artefact Type or Artefact ID!'', -- Message text.
		   16, -- Severity.
		   1 -- State.
		   );
	
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

				EXEC dbo.DELETE_ANNOTATION @ART_ID = @ART_ID;
						
				-- DELETE LOCALISED_STRING
				DELETE LOCALISED_STRING
				FROM CODELIST A 
					INNER JOIN DSD_CODE B ON
						A.CL_ID = B.CL_ID
					INNER JOIN LOCALISED_STRING C ON
						C.ART_ID = A.CL_ID 
						OR B.LCD_ID = C.ITEM_ID
				WHERE A.CL_ID = @ART_ID

				-- DELETE ITEM
				DELETE ITEM
				FROM DSD_CODE A
					INNER JOIN ITEM B ON
						A.LCD_ID = B.ITEM_ID
				WHERE CL_ID = @ART_ID

				-- DELETE DSD_CODE
				DELETE DSD_CODE
				WHERE CL_ID = @ART_ID

				-- DELETE CODELIST
				DELETE CODELIST
				WHERE CL_ID = @ART_ID

				-- DELETE ARTEFACT LOCALISED_STRING
				DELETE LOCALISED_STRING
				WHERE ART_ID = @ART_ID

				-- DELETE ARTEFACT
				DELETE ARTEFACT
				WHERE ART_ID = @ART_ID
		
		IF @starttrancount = 0 
			COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   16, -- Severity.
				   @ErrorState -- State.
				   );	
	END CATCH








' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_CONCEPT_SCHEME]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



/*

exec DELETE_CONCEPT_SCHEME 274
*/
CREATE PROCEDURE [dbo].[DELETE_CONCEPT_SCHEME]

@ART_ID BIGINT

AS
/**** TABLE LIST ***
ANNOTATION
LOCALISED_STRING
ITEM
CONCEPT
CONCEPT_SCHEME
ARTEFACT
*/

	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	
	DECLARE @ART_TYPE VARCHAR(500)
	EXEC RETRIEVE_ARTEFACT_TYPE @ART_ID, @ART_TYPE OUT

	IF @ART_TYPE IS NULL 
		RETURN 
	ELSE IF @ART_TYPE <> ''CONCEPT_SCHEME''
		RAISERROR (''Incorrect Artefact Type or Artefact ID!'', -- Message text.
		   16, -- Severity.
		   1 -- State.
		   );
	
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

				EXEC dbo.DELETE_ANNOTATION @ART_ID = @ART_ID;

				-- DELETE LOCALISED_STRING
				DELETE LOCALISED_STRING
				FROM CONCEPT B
					INNER JOIN LOCALISED_STRING C ON
						C.ART_ID = B.CON_SCH_ID 
						OR B.CON_ID = C.ITEM_ID
				WHERE B.CON_SCH_ID = @ART_ID

				-- DELETE LOCALISED STRING
				DELETE LOCALISED_STRING
				FROM CONCEPT_SCHEME A 
					INNER JOIN LOCALISED_STRING C ON
						C.ART_ID = A.CON_SCH_ID 
				WHERE A.CON_SCH_ID = @ART_ID
				
				-- DELETE CONCEPT
				DELETE CONCEPT
				WHERE CON_SCH_ID = @ART_ID

				-- DELETE ITEM
				DELETE ITEM
				FROM CONCEPT A
					INNER JOIN ITEM B ON
						A.CON_ID = B.ITEM_ID
				WHERE CON_SCH_ID = @ART_ID

				-- DELETE CONCEPT_SCHEME
				DELETE CONCEPT_SCHEME
				WHERE CON_SCH_ID = @ART_ID

				-- DELETE ARTEFACT
				DELETE ARTEFACT
				WHERE ART_ID = @ART_ID
			
		IF @starttrancount = 0 
			COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   16, -- Severity.
				   @ErrorState -- State.
				   );	
	END CATCH
	
	





' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_DATACONSUMER]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




CREATE PROCEDURE [dbo].[DELETE_DATACONSUMER]

@ART_ID BIGINT

AS


/**** TABLE LIST ***
ANNOTATION
LOCALISED_STRING
ITEM
DATACONSUMER
DATACONSUMER_SCHEME
ARTEFACT
*/

	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	
	DECLARE @ART_TYPE VARCHAR(500)
	EXEC RETRIEVE_ARTEFACT_TYPE @ART_ID, @ART_TYPE OUT

	IF @ART_TYPE IS NULL 
		RETURN 
	ELSE IF @ART_TYPE <> ''DATACONSUMER_SCHEME''
		RAISERROR (''Incorrect Artefact Type or Artefact ID!'', -- Message text.
		   16, -- Severity.
		   1 -- State.
		   );	
	
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

				EXEC dbo.DELETE_ANNOTATION @ART_ID = @ART_ID;

				-- DELETE LOCALISED_STRING
				DELETE LOCALISED_STRING
				FROM DATACONSUMER_SCHEME A 
					INNER JOIN DATACONSUMER B ON
						A.DC_SCH_ID = B.DC_SCH_ID
					INNER JOIN LOCALISED_STRING C ON
						C.ART_ID = A.DC_SCH_ID 
						OR B.DC_ID = C.ITEM_ID
				WHERE A.DC_SCH_ID = @ART_ID

				SELECT *
				INTO #DATACONSUMER
				FROM DATACONSUMER
				WHERE DC_SCH_ID = @ART_ID

				-- DELETE DATACONSUMER
				DELETE DATACONSUMER
				WHERE DC_SCH_ID = @ART_ID
				
				-- DELETE ITEM
				DELETE ITEM
				FROM #DATACONSUMER A
					INNER JOIN ITEM B ON
						A.DC_ID = B.ITEM_ID
				WHERE DC_SCH_ID = @ART_ID

				-- DELETE DATACONSUMER_SCHEME
				DELETE DATACONSUMER_SCHEME
				WHERE DC_SCH_ID = @ART_ID

				-- DELETE ARTEFACT
				DELETE ARTEFACT
				WHERE ART_ID = @ART_ID
			
		IF @starttrancount = 0 
			COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   16, -- Severity.
				   @ErrorState -- State.
				   );	
	END CATCH








' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_DATAFLOW]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[DELETE_DATAFLOW]

@ART_ID BIGINT

AS
/**** TABLE LIST ***
LOCALISED_STRING
ANNOTATION
DATAFLOW 
ARTEFACT 
*/

	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	
	DECLARE @CATN_ID BIGINT = 0
	DECLARE @ART_TYPE VARCHAR(500)
	EXEC RETRIEVE_ARTEFACT_TYPE @ART_ID, @ART_TYPE OUT

	IF @ART_TYPE IS NULL 
		RETURN 
	ELSE IF @ART_TYPE <> ''DATAFLOW''
		RAISERROR (''Incorrect Artefact Type or Artefact ID!'', -- Message text.
		   16, -- Severity.
		   1 -- State.
		   );	
	
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

				SELECT DF_ID
				FROM dbo.DATAFLOW
				WHERE DF_ID = @ART_ID
				IF @@ROWCOUNT <= 0
					RAISERROR (''Incorrect Artefact Type or Artefact ID!'', -- Message text.
					   16, -- Severity.
					   1 -- State.
					   );	
					   
				EXEC dbo.DELETE_ANNOTATION @ART_ID = @ART_ID;

				-- DELETE LOCALISED_STRING FOR ARTEFACT
				DELETE LOCALISED_STRING
				WHERE ART_ID = @ART_ID
 
				-- DELETE CATEGORISATION
				SELECT TOP 1 @CATN_ID = CATN_ID
				FROM dbo.CATEGORISATION
				WHERE ART_ID = @ART_ID 

				EXEC DELETE_CATEGORISATION @CATN_ID				


				-- DELETE DATAFLOW
				DELETE DATAFLOW
				WHERE DF_ID = @ART_ID

				-- DELETE ARTEFACT
				DELETE ARTEFACT
				WHERE ART_ID = @ART_ID
			
		IF @starttrancount = 0 
			COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   16, -- Severity.
				   @ErrorState -- State.
				   );	
	END CATCH








' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_DATAPROVIDER_SCHEME]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'





CREATE PROCEDURE [dbo].[DELETE_DATAPROVIDER_SCHEME]

@ART_ID BIGINT

AS


/**** TABLE LIST ***
ANNOTATION
LOCALISED_STRING
ITEM
DATAPROVIDER
DATAPROVIDER_SCHEME
ARTEFACT
*/

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @ART_TYPE VARCHAR(500)
	EXEC RETRIEVE_ARTEFACT_TYPE @ART_ID, @ART_TYPE OUT

	IF @ART_TYPE IS NULL 
		RETURN 
	ELSE IF @ART_TYPE <> ''DATAPROVIDER_SCHEME''
		RAISERROR (''Incorrect Artefact Type or Artefact ID!'', -- Message text.
		   16, -- Severity.
		   1 -- State.
		   );

	
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

				EXEC dbo.DELETE_ANNOTATION @ART_ID = @ART_ID;

				-- DELETE LOCALISED_STRING
				DELETE LOCALISED_STRING
				FROM DATAPROVIDER_SCHEME A 
					INNER JOIN dbo.DATAPROVIDER B ON
						A.DP_SCH_ID = B.DP_SCH_ID
					INNER JOIN LOCALISED_STRING C ON
						C.ART_ID = A.DP_SCH_ID 
						OR B.DP_ID = C.ITEM_ID
				WHERE A.DP_SCH_ID = @ART_ID

				SELECT *
				INTO #DATAPROVIDER
				FROM DATAPROVIDER
				WHERE DP_SCH_ID = @ART_ID

				-- DELETE DATAPROVIDER
				DELETE DATAPROVIDER
				WHERE DP_SCH_ID = @ART_ID
				
				-- DELETE ITEM
				DELETE ITEM
				FROM #DATAPROVIDER A
					INNER JOIN ITEM B ON
						A.DP_ID = B.ITEM_ID
				WHERE DP_SCH_ID = @ART_ID

				-- DELETE DATAPROVIDER_SCHEME
				DELETE DATAPROVIDER_SCHEME
				WHERE DP_SCH_ID = @ART_ID

				-- DELETE ARTEFACT
				DELETE ARTEFACT
				WHERE ART_ID = @ART_ID
			
		IF @starttrancount = 0 
			COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   16, -- Severity.
				   @ErrorState -- State.
				   );	
	END CATCH








' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_DSD]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[DELETE_DSD]

@ART_ID BIGINT

AS

/**** TABLE LIST ***
ANNOTATION (ARTEFACT, COMPONENT, GROUP)
LOCALISED_STRING (ANNOTATION, ARTEFACT E DATAFLOW SE PRESENTE)
TEXT_FORMAT 
DIM_GROUP 
DSD_GROUP 
DATAFLOW 
DSD 
ARTEFACT 
*/


	DECLARE @DF_ID BIGINT

	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;

	DECLARE @ART_TYPE VARCHAR(500)
	EXEC RETRIEVE_ARTEFACT_TYPE @ART_ID, @ART_TYPE OUT

	IF @ART_TYPE IS NULL 
		RETURN 
	ELSE IF @ART_TYPE <> ''DSD''
		RAISERROR (''Incorrect Artefact Type or Artefact ID!'', -- Message text.
		   16, -- Severity.
		   1 -- State.
		   );
		   
		   		   	
	-- RETRIEVE DATAFLOW ID 
	SELECT @DF_ID = DF_ID
	FROM DATAFLOW A
			INNER JOIN ARTEFACT B ON
				A.DSD_ID = B.ART_ID
			INNER JOIN ARTEFACT C ON
				A.DF_ID = C.ART_ID
				AND B.ID = C.ID
				AND B.AGENCY = C.AGENCY
				AND B.VERSION1 = C.VERSION1
				AND B.VERSION2 = C.VERSION2
				AND ISNULL(B.VERSION3,0) = ISNULL(C.VERSION3,0)
	WHERE DSD_ID = @ART_ID

	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

				EXEC dbo.DELETE_ANNOTATION @ART_ID = @ART_ID;
				IF @DF_ID IS NOT NULL
					EXEC dbo.DELETE_ANNOTATION @ART_ID = @DF_ID;

				-- DELETE LOCALISED_STRING FOR ARTEFACT & DATAFLOW
				DELETE LOCALISED_STRING
				WHERE ART_ID IN(@ART_ID,@DF_ID)

				-- DELETE TEXT_FORMAT
				DELETE TEXT_FORMAT
				FROM COMPONENT A
					INNER JOIN TEXT_FORMAT B ON
						A.COMP_ID = B.COMP_ID
				WHERE DSD_ID = @ART_ID


				-- DELETE DIM_GROUP
				DELETE DIM_GROUP
				FROM COMPONENT A
					INNER JOIN DIM_GROUP B ON
						A.COMP_ID = B.COMP_ID
				WHERE DSD_ID = @ART_ID

				-- DELETE ATT_GROUP
				DELETE ATT_GROUP
				FROM ATT_GROUP A
					INNER JOIN DSD_GROUP B ON
						B.GR_ID = A.GR_ID
				WHERE B.DSD_ID = @ART_ID
				
				-- DELETE DSD_GROUP
				DELETE DSD_GROUP
				WHERE DSD_ID = @ART_ID


				-- DELETE DATAFLOW
				DELETE DATAFLOW
				WHERE DF_ID = @DF_ID


				-- DELETE DSD
				DELETE DSD
				WHERE DSD_ID = @ART_ID
			

				-- DELETE ARTEFACT
				DELETE ARTEFACT
				WHERE ART_ID IN(@ART_ID,@DF_ID)

			
		IF @starttrancount = 0 
			COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   16, -- Severity.
				   @ErrorState -- State.
				   );	
	END CATCH











' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_ORGANISATIONUNIT_SCHEME]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'





CREATE PROCEDURE [dbo].[DELETE_ORGANISATIONUNIT_SCHEME]

@ART_ID BIGINT

AS


/**** TABLE LIST ***
ANNOTATION
LOCALISED_STRING
ITEM
ORGANISATION_UNIT
ORGANISATION_UNIT_SCHEME
ARTEFACT
*/

	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	
	
	DECLARE @ART_TYPE VARCHAR(500)
	EXEC RETRIEVE_ARTEFACT_TYPE @ART_ID, @ART_TYPE OUT

	IF @ART_TYPE IS NULL 
		RETURN 
	ELSE IF @ART_TYPE <> ''ORGANISATION_UNIT_SCHEME''
		RAISERROR (''Incorrect Artefact Type or Artefact ID!'', -- Message text.
		   16, -- Severity.
		   1 -- State.
		   );
	
	
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION
	
					   
				EXEC dbo.DELETE_ANNOTATION @ART_ID = @ART_ID
				

				-- DELETE LOCALISED_STRING
				DELETE LOCALISED_STRING
				FROM ORGANISATION_UNIT_SCHEME A 
					INNER JOIN dbo.ORGANISATION_UNIT B ON
						A.ORG_UNIT_SCH_ID = B.ORG_UNIT_SCH_ID
					INNER JOIN LOCALISED_STRING C ON
						C.ART_ID = A.ORG_UNIT_SCH_ID 
						OR B.ORG_UNIT_ID = C.ITEM_ID
				WHERE A.ORG_UNIT_SCH_ID = @ART_ID

				SELECT *
				INTO #ORGANISATION_UNIT
				FROM ORGANISATION_UNIT
				WHERE ORG_UNIT_SCH_ID = @ART_ID

				-- DELETE ORGANISATION_UNIT
				DELETE ORGANISATION_UNIT
				WHERE ORG_UNIT_SCH_ID = @ART_ID
				
				-- DELETE ITEM
				DELETE ITEM
				FROM #ORGANISATION_UNIT A
					INNER JOIN ITEM B ON
						A.ORG_UNIT_ID = B.ITEM_ID
				WHERE ORG_UNIT_SCH_ID = @ART_ID

				-- DELETE ORGANISATION_UNIT_SCHEME
				DELETE ORGANISATION_UNIT_SCHEME
				WHERE ORG_UNIT_SCH_ID = @ART_ID

				-- DELETE ARTEFACT
				DELETE ARTEFACT
				WHERE ART_ID = @ART_ID
			
		IF @starttrancount = 0 
			COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   16, -- Severity.
				   @ErrorState -- State.
				   );	
	END CATCH








' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_STRUCTURE_SET]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



/*

EXEC DELETE_STRUCTURE_SET 291
*/
CREATE PROCEDURE [dbo].[DELETE_STRUCTURE_SET]

@ART_ID BIGINT

AS


/**** TABLE LIST ***

*/

	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	
	DECLARE @ART_TYPE VARCHAR(500)
	EXEC RETRIEVE_ARTEFACT_TYPE @ART_ID, @ART_TYPE OUT

	IF @ART_TYPE IS NULL 
		RETURN 
	ELSE IF @ART_TYPE <> ''STRUCTURE_SET''
		RAISERROR (''Incorrect Artefact Type or Artefact ID!'', -- Message text.
		   16, -- Severity.
		   1 -- State.
		   );	
	
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

				-- DELETE STRUCTURESET ANNOTATION
				EXEC dbo.DELETE_ANNOTATION @ART_ID = @ART_ID
				
				-- DELETE STRUCTURESET LOCALISED_STRING
				DELETE LOCALISED_STRING
				FROM LOCALISED_STRING
				WHERE ART_ID = @ART_ID
			
				-- GET THE CODELISTMAP_IDS
				SELECT CLM_ID
				INTO #CODELISTMAP_IDS
				FROM CODELIST_MAP
				WHERE SS_ID = @ART_ID	

				-- DELETE CODE_MAP
				DELETE CODE_MAP
				FROM CODE_MAP A
					INNER JOIN CODELIST_MAP B ON
						A.CLM_ID = B.CLM_ID
				WHERE B.SS_ID = @ART_ID
				
				-- DELETE CODELIST_MAP
				DELETE CODELIST_MAP
				WHERE SS_ID = @ART_ID	
				
				-- DELETE CODELIST_MAP LOCALISED_STRING
				DELETE LOCALISED_STRING
				FROM LOCALISED_STRING
				WHERE ITEM_ID IN(SELECT CLM_ID FROM #CODELISTMAP_IDS)
				
				-- DELETE CODELISTMAP ITEM(EX ARTEFACT)
				DELETE ITEM
				WHERE ITEM_ID IN(SELECT CLM_ID FROM #CODELISTMAP_IDS)

				-- DELETE STRUCTURE_SET
				DELETE STRUCTURE_SET
				WHERE SS_ID = @ART_ID	
				
				-- DELETE STRUCTURE_SET ARTEFACT
				DELETE ARTEFACT
				WHERE ART_ID = @ART_ID				
			
		IF @starttrancount = 0 
			COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   16, -- Severity.
				   @ErrorState -- State.
				   );	
	END CATCH








' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GET_CL_ID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[GET_CL_ID]

@ID VARCHAR(50),
@AGENCY VARCHAR(50),
@VERSION VARCHAR(50),
@CL_ID BIGINT OUT

AS


    DECLARE	@cl_version1 bigint,
			@cl_version2 bigint,
			@cl_version3 bigint;
			

    exec SPLIT_VERSION @VERSION, @cl_version1 OUTPUT, @cl_version2 OUTPUT, @cl_version3 OUTPUT;


	SELECT @CL_ID = B.CL_ID
	FROM dbo.ARTEFACT A
		INNER JOIN dbo.CODELIST B ON
			A.ART_ID = B.CL_ID
	WHERE ID = @ID
		AND AGENCY = @AGENCY
		AND VERSION1 = @cl_version1
		AND VERSION2 = @cl_version2
		AND ISNULL(VERSION3,0) = ISNULL(@cl_version3,0)
	 		
		




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_ANNOTATION_I]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/*

exec INSERT_ANNOTATION ''1'',

*/


CREATE PROCEDURE [dbo].[INSERT_ANNOTATION_I]
	@p_xml_id VARCHAR(50) = NULL,
	@p_art_id BIGINT = NULL,
	@p_item_id BIGINT = NULL,
	@p_comp_id BIGINT = NULL,
	@p_gr_id BIGINT = NULL,
	@p_title VARCHAR(70) = NULL,
	@p_type VARCHAR(50) = NULL,
	@p_url VARCHAR(1000) = NULL,
	@p_pk bigint out
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @ANN_ID BIGINT

	IF @p_xml_id IS NULL OR (EXISTS (SELECT * FROM	dbo.ANNOTATION WHERE ID = @p_xml_id))
		SELECT @p_xml_id = MAX(ANN_ID)+1 FROM dbo.ANNOTATION

	INSERT INTO dbo.ANNOTATION	
	        ( ID, TITLE, [TYPE], URL )
	VALUES  ( @p_xml_id,
	          @p_title,
	          @p_type,
	          @p_url)
	
	SET @ANN_ID = SCOPE_IDENTITY();
	
	IF @p_art_id IS NOT NULL 

		INSERT INTO dbo.ARTEFACT_ANNOTATION	
		        (ANN_ID, ART_ID)
		VALUES  (@ANN_ID,
				@p_art_id)

	ELSE IF @p_item_id IS NOT NULL

		INSERT INTO dbo.ITEM_ANNOTATION
		        ( ANN_ID, ITEM_ID )
		VALUES  (@ANN_ID,
				@p_item_id)
	
	ELSE IF @p_comp_id IS NOT NULL

		INSERT INTO dbo.COMPONENT_ANNOTATION
		        ( ANN_ID, COMP_ID )
		VALUES  (@ANN_ID,
				@p_comp_id)

	ELSE IF @p_gr_id IS NOT NULL
		
		INSERT INTO dbo.GROUP_ANNOTATION
		        ( ANN_ID, GR_ID )
		VALUES  (@ANN_ID,
				@p_gr_id)

	
	set @p_pk = @ANN_ID;


END





' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_ARTEFACT_I]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[INSERT_ARTEFACT_I]
	@p_id varchar(50),
	@p_version varchar(50),
	@p_agency varchar(50),
	@p_valid_from datetime = NULL,
	@p_valid_to datetime = NULL,
	@p_is_final int = NULL,
	@p_uri VARCHAR(255) = NULL,
	@p_last_modified DATETIME = NULL,
	@p_pk bigint out
AS
BEGIN
		SET NOCOUNT ON;
	SET XACT_ABORT ON;
	DECLARE @starttrancount int;
    
    DECLARE	@p_version1 bigint,
		@p_version2 bigint,
		@p_version3 BIGINT,
		@getdate DATETIME;
		
	IF @p_last_modified IS NULL
		SET @p_last_modified = GETDATE();
		
		
	SET @starttrancount = @@TRANCOUNT;
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

        exec SPLIT_VERSION @p_version = @p_version, @p_version1 = @p_version1 OUTPUT, @p_version2 = @p_version2 OUTPUT, @p_version3 = @p_version3 OUTPUT;
	    insert into  ARTEFACT (ID,VERSION1, VERSION2, VERSION3, AGENCY, VALID_FROM, VALID_TO, IS_FINAL,URI,LAST_MODIFIED) values (@p_id,@p_version1,@p_version2,@p_version3,@p_agency,@p_valid_from,@p_valid_to,@p_is_final,@p_uri,@p_last_modified);
	    set @p_pk=SCOPE_IDENTITY();
        IF @starttrancount = 0 
	        COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   @ErrorSeverity, -- Severity.
				   @ErrorState -- State.
				   );
	END CATCH
END




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_CATEGORISATION_I]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[INSERT_CATEGORISATION_I]
	@p_id varchar(50),
	@p_version varchar(50),
	@p_agency varchar(50),
	@p_valid_from datetime = NULL,
	@p_valid_to datetime= NULL,
	@p_is_final int = NULL,
	@p_uri VARCHAR(255) = NULL,
	@p_last_modified DATETIME = NULL,
	@p_art_id bigint,
    @p_cat_id bigint,
    @p_dc_order bigint = NULL,
	@p_pk bigint out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

	exec INSERT_ARTEFACT_I @p_id = @p_id,@p_version = @p_version,@p_agency = @p_agency,@p_valid_from = @p_valid_from,@p_valid_to = @p_valid_to,@p_is_final = @p_is_final,@p_uri = @p_uri, @p_last_modified = @p_last_modified, @p_pk = @p_pk OUTPUT;
	
INSERT INTO CATEGORISATION
           (CATN_ID
           ,ART_ID
           ,CAT_ID
           ,DC_ORDER)
     VALUES
           (@p_pk
           ,@p_art_id
           ,@p_cat_id
           ,@p_dc_order);

	IF @starttrancount = 0 
	        COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   @ErrorSeverity, -- Severity.
				   @ErrorState -- State.
				   );
	END CATCH
END




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_CATEGORY_I]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[INSERT_CATEGORY_I]
	@p_id varchar(50), 
	@p_cat_sch_id bigint,
	@p_parent_cat_id bigint = null,
	@p_corder bigint = 0,
	@p_pk bigint OUT 
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

		insert into ITEM (ID) VALUES (@p_id);
		set @p_pk = SCOPE_IDENTITY();
		insert into CATEGORY (CAT_ID, CAT_SCH_ID, PARENT_CAT_ID, CORDER) VALUES (@p_pk, @p_cat_sch_id, @p_parent_cat_id, @p_corder);
	
		IF @starttrancount = 0 
	        COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   @ErrorSeverity, -- Severity.
				   @ErrorState -- State.
				   );
	END CATCH
END




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_CATEGORY_SCHEME_I]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[INSERT_CATEGORY_SCHEME_I]
	@p_id varchar(50),
	@p_version varchar(50),
	@p_agency varchar(50),
	@p_valid_from datetime = NULL,
	@p_valid_to datetime= NULL,
	@p_is_final int = NULL,
	@p_uri VARCHAR(255) = NULL,
	@p_last_modified DATETIME = NULL,
	@p_cs_order bigint = 0,
    @p_is_partial bit = 0,
	@p_pk bigint out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

	exec INSERT_ARTEFACT_I @p_id = @p_id,@p_version = @p_version,@p_agency = @p_agency,@p_valid_from = @p_valid_from,@p_valid_to = @p_valid_to,@p_is_final = @p_is_final,@p_uri = @p_uri, @p_last_modified = @p_last_modified, @p_pk = @p_pk OUTPUT;
	
	INSERT INTO CATEGORY_SCHEME
           (CAT_SCH_ID, CS_ORDER, IS_PARTIAL)
     VALUES
           (@p_pk, @p_cs_order, @p_is_partial);

	IF @starttrancount = 0 
	        COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   @ErrorSeverity, -- Severity.
				   @ErrorState -- State.
				   );
	END CATCH
END




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_CODELIST_I]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




CREATE PROCEDURE [dbo].[INSERT_CODELIST_I]
	@p_id varchar(50),
	@p_version varchar(50),
	@p_agency varchar(50),
	@p_valid_from datetime = NULL,
	@p_valid_to datetime= NULL,
	@p_is_final int = NULL,
	@p_uri VARCHAR(255) = NULL,
	@p_last_modified DATETIME = NULL,
    @p_is_partial bit = 0,
	@p_pk bigint out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

	exec INSERT_ARTEFACT_I @p_id = @p_id,@p_version = @p_version,@p_agency = @p_agency,@p_valid_from = @p_valid_from,@p_valid_to = @p_valid_to,@p_is_final = @p_is_final,@p_uri = @p_uri, @p_last_modified = @p_last_modified, @p_pk = @p_pk OUTPUT;
	
	INSERT INTO CODELIST
           (CL_ID, IS_PARTIAL)
     VALUES
           (@p_pk, @p_is_partial);

	IF @starttrancount = 0 
	        COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   @ErrorSeverity, -- Severity.
				   @ErrorState -- State.
				   );
	END CATCH
END




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_CONCEPT_I]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'





CREATE PROCEDURE [dbo].[INSERT_CONCEPT_I]
	@p_id varchar(50), 
	@p_con_sch_id bigint,
	@p_parent_id BIGINT = NULL,
	@p_pk bigint OUT 
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

		insert into ITEM (ID) VALUES (@p_id);
		set @p_pk = SCOPE_IDENTITY();
		insert into CONCEPT (CON_ID, CON_SCH_ID,PARENT_CONCEPT_ID) VALUES (@p_pk, @p_con_sch_id,@p_parent_id);
	
		IF @starttrancount = 0 
	        COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   @ErrorSeverity, -- Severity.
				   @ErrorState -- State.
				   );
	END CATCH
END






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_CONCEPT_SCHEME_I]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




CREATE PROCEDURE [dbo].[INSERT_CONCEPT_SCHEME_I]
	@p_id varchar(50),
	@p_version varchar(50),
	@p_agency varchar(50),
	@p_valid_from datetime = NULL,
	@p_valid_to datetime= NULL,
	@p_is_final int = NULL,
	@p_uri VARCHAR(255) = NULL,
	@p_last_modified DATETIME = NULL,
	@p_is_partial bit = 0,
	@p_pk bigint out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

	exec INSERT_ARTEFACT_I @p_id = @p_id,@p_version = @p_version,@p_agency = @p_agency,@p_valid_from = @p_valid_from,@p_valid_to = @p_valid_to,@p_is_final = @p_is_final,@p_uri = @p_uri, @p_last_modified = @p_last_modified, @p_pk = @p_pk OUTPUT;
	
	INSERT INTO CONCEPT_SCHEME
           (CON_SCH_ID, IS_PARTIAL)
     VALUES
           (@p_pk, @p_is_partial);

	IF @starttrancount = 0 
	        COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   @ErrorSeverity, -- Severity.
				   @ErrorState -- State.
				   );
	END CATCH
END




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_DATAFLOW_I]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[INSERT_DATAFLOW_I]
	@p_id varchar(50),
	@p_version varchar(50),
	@p_agency varchar(50),
	@p_valid_from datetime = NULL,
	@p_valid_to datetime= NULL,
	@p_is_final int = NULL,
	@p_uri VARCHAR(255) = NULL,
	@p_last_modified DATETIME = NULL,
	@p_dsd_id bigint,
    @p_map_set_id bigint = null,
	@p_pk bigint out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

	exec INSERT_ARTEFACT_I @p_id = @p_id,@p_version = @p_version,@p_agency = @p_agency,@p_valid_from = @p_valid_from,@p_valid_to = @p_valid_to,@p_is_final = @p_is_final,@p_uri = @p_uri, @p_last_modified = @p_last_modified, @p_pk = @p_pk OUTPUT;
	
INSERT INTO DATAFLOW
           (DF_ID
           ,DSD_ID
           ,MAP_SET_ID)
     VALUES
           (@p_pk
           ,@p_dsd_id
           ,@p_map_set_id);

	IF @starttrancount = 0 
	        COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   @ErrorSeverity, -- Severity.
				   @ErrorState -- State.
				   );
	END CATCH
END




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_DSD_I]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[INSERT_DSD_I]
	@p_id varchar(50),
	@p_version varchar(50),
	@p_agency varchar(50),
	@p_valid_from datetime = NULL,
	@p_valid_to datetime= NULL,
	@p_is_final int = NULL,
	@p_uri VARCHAR(255) = NULL,
	@p_last_modified DATETIME = NULL,
	@p_pk bigint out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

	exec INSERT_ARTEFACT_I @p_id = @p_id,@p_version = @p_version,@p_agency = @p_agency,@p_valid_from = @p_valid_from,@p_valid_to = @p_valid_to,@p_is_final = @p_is_final,@p_uri = @p_uri, @p_last_modified = @p_last_modified, @p_pk = @p_pk OUTPUT;
	
	INSERT INTO DSD
           (DSD_ID)
     VALUES
           (@p_pk);


	IF @starttrancount = 0 
	        COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   @ErrorSeverity, -- Severity.
				   @ErrorState -- State.
				   );
	END CATCH
END




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_HCL_I]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[INSERT_HCL_I]
	@p_id varchar(50),
	@p_version varchar(50),
	@p_agency varchar(50),
	@p_valid_from datetime = NULL,
	@p_valid_to datetime= NULL,
	@p_is_final int = NULL,
	@p_uri VARCHAR(255) = NULL,
	@p_last_modified DATETIME = NULL,
	@p_pk bigint out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

	exec INSERT_ARTEFACT_I @p_id = @p_id,@p_version = @p_version,@p_agency = @p_agency,@p_valid_from = @p_valid_from,@p_valid_to = @p_valid_to,@p_is_final = @p_is_final,@p_uri = @p_uri, @p_last_modified = @p_last_modified, @p_pk = @p_pk OUTPUT;
	insert into HCL (HCL_ID) values(@p_pk);

	IF @starttrancount = 0 
	        COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   @ErrorSeverity, -- Severity.
				   @ErrorState -- State.
				   );
	END CATCH
END




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_LOCALISED_STRING_I]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'






CREATE PROCEDURE [dbo].[INSERT_LOCALISED_STRING_I]
	@p_item_id bigint = null,
	@p_art_id bigInt = null,
	@p_text nvarchar(4000),
	@p_type varchar(10),
	@p_language varchar(50),
	@p_pk bigint OUT 
AS
BEGIN
	SET NOCOUNT ON;
	insert into LOCALISED_STRING (ART_ID, ITEM_ID, TEXT, TYPE, LANGUAGE) values (@p_art_id, @p_item_id, @p_text, @p_type, @p_language);
	set @p_pk = SCOPE_IDENTITY();
END





' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_ORGANISATIONUNIT_SCHEME]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'





CREATE PROCEDURE [dbo].[INSERT_ORGANISATIONUNIT_SCHEME]
	@p_id varchar(50),
	@p_version varchar(50),
	@p_agency varchar(50),
	@p_valid_from datetime = NULL,
	@p_valid_to datetime= NULL,
	@p_is_final int = NULL,
    @p_is_partial bit = 0,
	@p_uri VARCHAR(255) = NULL,
	@p_last_modified DATETIME = NULL,
	@p_pk bigint out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

	exec INSERT_ARTEFACT_I @p_id = @p_id,@p_version = @p_version,@p_agency = @p_agency,@p_valid_from = @p_valid_from,@p_valid_to = @p_valid_to,@p_is_final = @p_is_final,@p_uri = @p_uri, @p_last_modified = @p_last_modified, @p_pk = @p_pk OUTPUT;
	
	INSERT INTO ORGANISATION_UNIT_SCHEME
	        ( ORG_UNIT_SCH_ID, IS_PARTIAL )
     VALUES
           (@p_pk, @p_is_partial);

	IF @starttrancount = 0 
	        COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   @ErrorSeverity, -- Severity.
				   @ErrorState -- State.
				   );
	END CATCH
END







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INSERT_STRUCTURESET]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'





CREATE PROCEDURE [dbo].[INSERT_STRUCTURESET]
	@p_id varchar(50),
	@p_version varchar(50),
	@p_agency varchar(50),
	@p_valid_from datetime = NULL,
	@p_valid_to datetime= NULL,
	@p_is_final int = NULL,
    @p_is_partial bit = 0,
	@p_uri VARCHAR(255) = NULL,
	@p_last_modified DATETIME = NULL,
	@p_pk bigint out
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	DECLARE @starttrancount int;
	SET @starttrancount = @@TRANCOUNT;
	BEGIN TRY
		IF @starttrancount = 0 
			BEGIN TRANSACTION

	exec INSERT_ARTEFACT_I @p_id = @p_id,@p_version = @p_version,@p_agency = @p_agency,@p_valid_from = @p_valid_from,@p_valid_to = @p_valid_to,@p_is_final = @p_is_final,@p_uri = @p_uri, @p_last_modified = @p_last_modified, @p_pk = @p_pk OUTPUT;
	
	INSERT INTO dbo.STRUCTURE_SET
	        (SS_ID)
     VALUES
           (@p_pk);

	IF @starttrancount = 0 
	        COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		IF XACT_STATE() <> 0 AND @starttrancount = 0 
			ROLLBACK TRANSACTION
	   RAISERROR (@ErrorMessage, -- Message text.
				   @ErrorSeverity, -- Severity.
				   @ErrorState -- State.
				   );
	END CATCH
END




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetCodelists]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[proc_WBS_GetCodelists]
(

	@CodelistCode varchar(150)= '''', 
	@CodelistAgencyId varchar(50)= '''', 
	@CodelistVersion varchar(50)= '''', 

	@DSDCode varchar(150)= '''', 
	@DSDAgencyId varchar(50)= '''', 
	@DSDVersion varchar(50)= '''', 

	@ConceptSchemeCode varchar(150)= '''', 
	@ConceptSchemeAgencyId varchar(150)= '''', 
	@ConceptSchemeVersion varchar(150)= '''', 
	
	@IsStub bit=0,
	@UserName sysname = '''',
	@Domain sysname = '''',
	@TimeStamp datetime = null
)
AS

declare @CLList table
(
	CodelistID bigint,
	CodelistCode varchar(50),
	AGENCY varchar(50), 
	CodelistVersion varchar(50),
	lang varchar(50),
	descr varchar(4000),
	ConceptSchemeCode varchar(50),
	ConceptSchemeAgency varchar(50),
	ConceptSchemeVersion varchar(50),
	DSDCode  varchar(50),    
	DSDAgency varchar(50), 
	DSDVersion varchar(50)
)

create table #CLITEMList 
(
	CodelistID bigint,
	ItemId bigint,
	ItemCode varchar(50),
	lang varchar(50),
	descr varchar(4000),
	ParentCodeID bigint,
	ParentCode varchar(150),
	Livel int,
	Ordinamento varchar(250)
	
)

INSERT INTO @CLList 	
select DISTINCT CODELIST.CL_ID as CodelistId, ARTEFACT.ID as CodelistCode, ARTEFACT.AGENCY, LTRIM(STR(ARTEFACT.VERSION1)) + ''.'' + LTRIM(STR(ARTEFACT.VERSION2)) as SdmxVersion,
LANGUAGE as lang, TEXT as descr ,

ARTConceptScheme.ID as  ConceptSchemeCode,
ARTConceptScheme.AGENCY as  ConceptSchemeCode,
LTRIM(STR(ARTConceptScheme.VERSION1)) + ''.'' + LTRIM(STR(ARTConceptScheme.VERSION2))  as  ConceptSchemeVersion,

ARTDSD.ID as DSDCode,
ARTDSD.AGENCY  as DSDAgency,
LTRIM(STR(ARTDSD.VERSION1)) + ''.'' + LTRIM(STR(ARTDSD.VERSION2))  as DSDVersion

from CODELIST
inner join ARTEFACT on ARTEFACT.ART_ID= CODELIST.CL_ID
inner join LOCALISED_STRING on ARTEFACT.ART_ID= LOCALISED_STRING.ART_ID
LEFT join COMPONENT on CODELIST.CL_ID = COMPONENT.CL_ID
LEFT join ARTEFACT as ARTDSD on ARTDSD.ART_ID= COMPONENT.DSD_ID

LEFT JOIN CONCEPT on CONCEPT.CON_ID= COMPONENT.CON_ID
LEFT JOIN ARTEFACT as ARTConceptScheme on ARTConceptScheme.ART_ID = CONCEPT.CON_SCH_ID
--Where Codelist Code
where ARTEFACT.ID = case when LEN(@CodelistCode)>0 then @CodelistCode else ARTEFACT.ID end
--Codelist Agency e Version
AND ARTEFACT.AGENCY = case when LEN(@CodelistAgencyId)>0 then @CodelistAgencyId else ARTEFACT.AGENCY end
AND  LTRIM(STR(ARTEFACT.VERSION1)) + ''.'' + LTRIM(STR(ARTEFACT.VERSION2))= case when LEN(@CodelistVersion)>0 then @CodelistVersion else LTRIM(STR(ARTEFACT.VERSION1)) + ''.'' + LTRIM(STR(ARTEFACT.VERSION2)) end
-- ConceptScheme
AND ARTConceptScheme.ID =
case when LEN(@ConceptSchemeCode)>0 then @ConceptSchemeCode else ARTConceptScheme.ID end
--ConceptScheme Agency e Version
AND ARTConceptScheme.AGENCY = case when LEN(@ConceptSchemeAgencyId)>0 then @ConceptSchemeAgencyId else ARTConceptScheme.AGENCY end
AND  LTRIM(STR(ARTConceptScheme.VERSION1)) + ''.'' + LTRIM(STR(ARTConceptScheme.VERSION2))= case when LEN(@ConceptSchemeVersion)>0 then @ConceptSchemeVersion else LTRIM(STR(ARTConceptScheme.VERSION1)) + ''.'' + LTRIM(STR(ARTConceptScheme.VERSION2)) end

-- DSDCode
AND ARTDSD.ID = 
case when LEN(@DSDCode)>0 then @DSDCode else ARTDSD.ID end
--DSD Agency e Version
AND ARTDSD.AGENCY = case when LEN(@DSDAgencyId)>0 then @DSDAgencyId else ARTDSD.AGENCY end
AND  LTRIM(STR(ARTDSD.VERSION1)) + ''.'' + LTRIM(STR(ARTDSD.VERSION2))= case when LEN(@DSDVersion)>0 then @DSDVersion else LTRIM(STR(ARTDSD.VERSION1)) + ''.'' + LTRIM(STR(ARTDSD.VERSION2)) end


IF @IsStub=0
BEGIN
INSERT INTO #CLITEMList 
select CODELIST.CL_ID, ITEM.ITEM_ID,  ITEM.ID, LANGUAGE as lang, TEXT as txt, PARENT_CODE_ID,
(select ITEM.ID from ITEM where ITEM.ITEM_ID=PARENT_CODE_ID) as ParentCode,
Case when PARENT_CODE_ID is null then 0 else 1 end as livel,
Case when PARENT_CODE_ID is null then LTRIM(STR(ITEM.ITEM_ID)) else (select LTRIM(STR(ITEM.ITEM_ID)) from ITEM where ITEM.ITEM_ID=PARENT_CODE_ID) + ''-'' + LTRIM(STR(ITEM.ITEM_ID)) end as ordinamento
from CODELIST
inner join DSD_CODE on DSD_CODE.CL_ID=  CODELIST.CL_ID
inner join COMPONENT on CODELIST.CL_ID = COMPONENT.CL_ID
inner join ITEM on DSD_CODE.LCD_ID= ITEM.ITEM_ID
inner join LOCALISED_STRING on ITEM.ITEM_ID= LOCALISED_STRING.ITEM_ID
where  CODELIST.CL_ID in (select DISTINCT CodelistID from  @CLList)
order by CODELIST.CL_ID
END



declare @RicQuanti int=1
SET NOCOUNT ON;

WHILE(@RicQuanti>0)
BEGIN
	
	UPDATE #CLITEMList 
	set Livel=Livel+1,
	Ordinamento = (select  DISTINCT pa.Ordinamento from #CLITEMList as pa where pa.ItemId = #CLITEMList.ParentCodeID) +''-'' + LTRIM(STR(ItemId))
	where ParentCode is not null
	AND (select  DISTINCT pa.Ordinamento from #CLITEMList as pa where pa.ItemId = #CLITEMList.ParentCodeID)
	<> REPLACE(Ordinamento,''-'' + LTRIM(STR(ItemId)),'''')
	set @RicQuanti=@@ROWCOUNT
	
END
SET NOCOUNT OFF;

create table #T
(
	Tag int,
	Parent int null,
	[CodeLists!1!xmlns] varchar(100) null,
	[CodeList!2!Order!hide] varchar(500) null,
	[CodeList!2!Order2!hide] varchar(500) null,
	[CodeList!2!Code] varchar(50) null,
	[CodeList!2!AgencyID] varchar(50) null,
	[CodeList!2!Version] varchar(50) null,
	
	[Name!3!LocaleIsoCode] char(2) null,
	[Name!3!!cdata] varchar(500) null,

)
declare @i int
declare @si0 varchar(50)
declare @si1 varchar(50)
declare @si2 varchar(50)
declare @siParent varchar(50)
declare @execstr varchar(8000)
declare @maxdepth int;
set @maxdepth =(select MAX(Livel) from #CLITEMList) +1

set @execstr = ''''
set @i = 1
while (@i <= @maxdepth)
begin
	set @si1 = cast(2*@i+2 as varchar(50))
	set @si2 = cast(2*@i+3 as varchar(50))
	if (len(@execstr) > 0)
		set @execstr = @execstr + '',''
	set @execstr = @execstr + ''
[Code!''+@si1+''!value] varchar(50) null,
[Code!''+@si1+''!ID!hide] int null,
[Name!''+@si2+''!LocaleIsoCode] char(2) null,
[Name!''+@si2+''!!cdata] varchar(500) null''
	set @i = @i+1
end

if (len(@execstr) > 0)
--	print(''alter table #T add ''+@execstr)
	exec(''alter table #T add ''+@execstr)

INSERT INTO #T (Tag,[CodeLists!1!xmlns]) Values (1,''http://istat.it/OnTheFly'')

INSERT INTO #T (Tag,Parent,[CodeList!2!Order!hide], [CodeList!2!Code], [CodeList!2!AgencyID], [CodeList!2!Version]) 
select distinct 2,1,CodelistID, CodelistCode
, AGENCY, CodelistVersion 
from @CLList

INSERT INTO #T (Tag,Parent,[CodeList!2!Order!hide], [CodeList!2!Code],[Name!3!LocaleIsoCode],[Name!3!!cdata]) 
select distinct 3,2,CodelistID, CodelistCode, lang,descr from @CLList




set @i = 1
while (@i <= @maxdepth)
begin
	set @si1 = cast(2*@i+2 as varchar(50))
	set @si2 = cast(2*@i+3 as varchar(50))
	set @siParent= cast(2*@i as varchar(50))
	
	EXEC(''INSERT INTO #T (Tag,Parent,[CodeList!2!Order!hide],[CodeList!2!Order2!hide],
	[Code!''+@si1+''!value],[Code!''+@si1+''!ID!hide]) 
	select DISTINCT ''+@si1+'' as Tag, ''+@siParent+'' as Parent, CodelistID, Ordinamento, 
	ItemCode, ItemId
	from #CLITEMList where Livel=''+@i + ''-1'')

	EXEC(''INSERT INTO #T (Tag,Parent,[CodeList!2!Order!hide],[CodeList!2!Order2!hide],
	[Code!''+@si1+''!value],[Code!''+@si1+''!ID!hide],
	[Name!''+@si2+''!LocaleIsoCode], [Name!''+@si2+''!!cdata]) 
	select distinct ''+@si2+'' as Tag, ''+@si1+'' as Parent,   CodelistID, Ordinamento + '''' '''' +lang,
	ItemCode, ItemId,
	lang, descr 
	from #CLITEMList where Livel=''+@i + ''-1'')
	set @i = @i+1
end

select * from #T order by [CodeList!2!Order!hide], [CodeList!2!Order2!hide],[Name!3!LocaleIsoCode]
FOR XML EXPLICIT' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetConceptSchemes]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[proc_WBS_GetConceptSchemes]
(
	@ConceptSchemeCode varchar(150)= '''', 
	@ConceptSchemeAgencyId varchar(150)= '''', 
	@ConceptSchemeVersion varchar(150)= '''', 
	
	@DSDCode varchar(150)= '''', 
	@DSDAgencyId varchar(50)= '''', 
	@DSDVersion varchar(50)= '''', 

	@CodelistCode varchar(150)= '''', 
	@CodelistAgencyId varchar(50)= '''', 
	@CodelistVersion varchar(50)= '''', 

	@IsStub bit=0,
	@UserName sysname = '''',
	@Domain sysname = '''',
	@TimeStamp datetime = null
)
AS

declare @CSList table
(
	ConceptSchemeID varchar(50),
	AGENCY varchar(50), 
	ConceptSchemeVersion varchar(50),
	lang varchar(50),
	descr varchar(4000),
	DSDCode  varchar(50),    
	DSDAgency varchar(50), 
	DSDVersion varchar(50),

	CompType varchar(50),
	ConceptCode varchar(50),
	ConceptID varchar(50),

	CodelistCode varchar(50),
	CodelistAgency varchar(50),
	CodelistVersion varchar(50),

	assignmentStatus varchar(50),
	attachmentLevel varchar(50)
)

INSERT INTO @CSList 	
select distinct ARTEFACT.ID as ConceptSchemeID, ARTEFACT.AGENCY, LTRIM(STR(ARTEFACT.VERSION1)) + ''.'' + LTRIM(STR(ARTEFACT.VERSION2)) as SdmxVersion, LANGUAGE as lang, TEXT as descr,
ARTDSD.ID as DSDCode,
ARTDSD.AGENCY  as DSDAgency,
LTRIM(STR(ARTDSD.VERSION1)) + ''.'' + LTRIM(STR(ARTDSD.VERSION2))  as DSDVersion,

COMPONENT.TYPE as CompType, COMPONENT.ID as ConceptCode,COMPONENT.CON_ID as ConceptID,
ARTCodelist.ID  as CodelistCode,
ARTCodelist.AGENCY  as CodelistAgency,
LTRIM(STR(ARTCodelist.VERSION1)) + ''.'' + LTRIM(STR(ARTCodelist.VERSION2)) as CodelistVersion,
Case  COMPONENT.TYPE When ''Attribute'' then 
COMPONENT.ATT_STATUS
else Null end as assignmentStatus,

 Case  COMPONENT.TYPE When ''Attribute'' then 
(
	Case COMPONENT.ATT_ASS_LEVEL 
	When ''Series'' THEN ''DimensionGroup''
	When ''Observation'' THEN ''Observation''
	When ''DataSet'' THEN ''Dataset''
	When ''Group'' THEN ''Group''
    END	
)
else Null end as attachmentLevel

from CONCEPT_SCHEME
inner join ARTEFACT on ARTEFACT.ART_ID= CONCEPT_SCHEME.CON_SCH_ID
inner join LOCALISED_STRING on ARTEFACT.ART_ID= LOCALISED_STRING.ART_ID
inner join CONCEPT on CONCEPT_SCHEME.CON_SCH_ID= CONCEPT.CON_SCH_ID
inner join COMPONENT on COMPONENT.CON_ID= CONCEPT.CON_ID
LEFT join ARTEFACT as ARTDSD on ARTDSD.ART_ID= COMPONENT.DSD_ID
LEFT join ARTEFACT as ARTCodelist on ARTCodelist.ART_ID= COMPONENT.CL_ID
--Where ConceptScheme Code
where ARTEFACT.ID = case when LEN(@ConceptSchemeCode)>0 then @ConceptSchemeCode else ARTEFACT.ID end
--ConceptScheme Agency e Version
AND ARTEFACT.AGENCY = case when LEN(@ConceptSchemeAgencyId)>0 then @ConceptSchemeAgencyId else ARTEFACT.AGENCY end
AND  LTRIM(STR(ARTEFACT.VERSION1)) + ''.'' + LTRIM(STR(ARTEFACT.VERSION2))= case when LEN(@ConceptSchemeVersion)>0 then @ConceptSchemeVersion else LTRIM(STR(ARTEFACT.VERSION1)) + ''.'' + LTRIM(STR(ARTEFACT.VERSION2)) end

-- DSDCode
AND ARTDSD.ID = 
case when LEN(@DSDCode)>0 then @DSDCode else ARTDSD.ID end
--DSD Agency e Version
AND ARTDSD.AGENCY = case when LEN(@DSDAgencyId)>0 then @DSDAgencyId else ARTDSD.AGENCY end
AND  LTRIM(STR(ARTDSD.VERSION1)) + ''.'' + LTRIM(STR(ARTDSD.VERSION2))= case when LEN(@DSDVersion)>0 then @DSDVersion else LTRIM(STR(ARTDSD.VERSION1)) + ''.'' + LTRIM(STR(ARTDSD.VERSION2)) end

-- Codelist Code
AND (ARTCodelist.ID =
case when LEN(@CodelistCode)>0 then @CodelistCode else ARTCodelist.ID end
OR ARTCodelist.ID is NULL) 
--Codelist Agency e Version
AND (ARTCodelist.AGENCY = case when LEN(@CodelistAgencyId)>0 then @CodelistAgencyId else ARTCodelist.AGENCY end
	OR ARTCodelist.AGENCY is NULL) 
AND  (LTRIM(STR(ARTCodelist.VERSION1)) + ''.'' + LTRIM(STR(ARTCodelist.VERSION2))= case when LEN(@CodelistVersion)>0 then @CodelistVersion else LTRIM(STR(ARTCodelist.VERSION1)) + ''.'' + LTRIM(STR(ARTCodelist.VERSION2)) end
	OR LTRIM(STR(ARTCodelist.VERSION1)) + ''.'' + LTRIM(STR(ARTCodelist.VERSION2)) is NULL)


declare @ConceptNames table
(
	ConceptID varchar(50),
	lang varchar(50),
	descr varchar(4000)
)

insert into @ConceptNames
SELECT DISTINCT CSList.ConceptID,
	LOCALISED_STRING.LANGUAGE, LOCALISED_STRING.TEXT
	from @CSList as CSList
	inner join ITEM on CSList.ConceptID= ITEM.ITEM_ID
	inner join LOCALISED_STRING on ITEM.ITEM_ID= LOCALISED_STRING.ITEM_ID
	where LOCALISED_STRING.TYPE=''Name''


declare @CSXML table
(
	Tag int,
	Parent int null,
	[Concepts!1!xmlns] varchar(100) null,
	[ConceptScheme!2!Order!hide] varchar(500) null,
	[ConceptScheme!2!Order2!hide] varchar(500) null,
	[ConceptScheme!2!Code] varchar(50) null,
	[ConceptScheme!2!Agency] varchar(50) null,
	[ConceptScheme!2!Version] varchar(50) null,
	[Name!3!LocaleIsoCode] char(2) null,
	[Name!3!!cdata] varchar(4000) null,
	[Concept!4!Code] varchar(50) null,
	[Concept!4!Type] varchar(50) null,
	[Concept!4!assignmentStatus] varchar(50) null,
	[Concept!4!attachmentLevel] varchar(50) null,
	[Name!5!LocaleIsoCode] char(2) null,
	[Name!5!!cdata] varchar(4000) null
)

INSERT INTO @CSXML (Tag,[Concepts!1!xmlns],[ConceptScheme!2!Order!hide],[ConceptScheme!2!Order2!hide]) Values (1,''http://istat.it/OnTheFly'',0,0)

INSERT INTO @CSXML (Tag,Parent, [ConceptScheme!2!Order!hide],[ConceptScheme!2!Order2!hide] ,
	[ConceptScheme!2!Code] ,	[ConceptScheme!2!Agency] ,	[ConceptScheme!2!Version] 
	)
	SELECT DISTINCT 2,1,ConceptSchemeID, 0,
	ConceptSchemeID, AGENCY, ConceptSchemeVersion
	from @CSList

INSERT INTO @CSXML (Tag,Parent, [ConceptScheme!2!Order!hide],[ConceptScheme!2!Order2!hide] ,
	[ConceptScheme!2!Code] ,	[ConceptScheme!2!Agency] ,	[ConceptScheme!2!Version] ,
	[Name!3!LocaleIsoCode], [Name!3!!cdata] )  
	SELECT DISTINCT 3,2,ConceptSchemeID, 0,
	ConceptSchemeID, AGENCY, ConceptSchemeVersion,
	lang, descr
	from @CSList

IF @IsStub=0 BEGIN
INSERT INTO @CSXML (Tag,Parent, [ConceptScheme!2!Order!hide],[ConceptScheme!2!Order2!hide] ,
	[Concept!4!Code] ,	[Concept!4!Type] , [Concept!4!assignmentStatus], [Concept!4!attachmentLevel]	)
	SELECT DISTINCT 4,2,ConceptSchemeID, ConceptCode,
	ConceptCode, CompType, assignmentStatus, attachmentLevel
	from @CSList

INSERT INTO @CSXML (Tag,Parent, [ConceptScheme!2!Order!hide],[ConceptScheme!2!Order2!hide] ,
	[Concept!4!Code] ,	[Concept!4!Type] , [Concept!4!assignmentStatus], [Concept!4!attachmentLevel],
	[Name!5!LocaleIsoCode],	[Name!5!!cdata]	)
	SELECT DISTINCT  5,4,ConceptSchemeID, ConceptCode + ''_l'',
	ConceptCode, CompType, assignmentStatus, attachmentLevel
	,CN.lang, CN.descr
	from @CSList as CSList
	inner join @ConceptNames as CN on CSList.ConceptID= CN.ConceptID
	
END



select * from @CSXML 
order by [ConceptScheme!2!Order!hide], [ConceptScheme!2!Order2!hide], [Name!3!LocaleIsoCode],
[Concept!4!Type], [Concept!4!Code], [Name!5!LocaleIsoCode]
FOR XML EXPLICIT' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDataflows]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[proc_WBS_GetDataflows]
(
	@DFId int=null,
	
	@UserName sysname = '''',
	@Domain sysname = '''',
	@TimeStamp datetime = null
)
AS

declare @DFList table
(
	DF_ID bigint,
	PRODUCTION int
)

insert into @DFList
select DISTINCT DF_ID, PRODUCTION
from DATAFLOW
WHERE DF_ID = 
case when @DFId is not null then @DFId else DF_ID end
AND (PRODUCTION=1 OR PRODUCTION=9)

declare @DFXML table
(
	Tag int,
	Parent int null,
	[Dataflows!1!xmlns] varchar(100) null,
	[Dataflow!2!id] varchar(50) null,
	[Dataflow!2!Production] varchar(50) null
)

INSERT INTO @DFXML (Tag,[Dataflows!1!xmlns]) Values (1,''http://istat.it/OnTheFly'')

INSERT INTO @DFXML (Tag,Parent, [Dataflow!2!id], [Dataflow!2!Production])  
	SELECT DISTINCT 2,1,DF_ID,
	Case PRODUCTION
	when 1 then ''MA''
	when 9 then ''DL''
	end
	from @DFList


select * from @DFXML 
FOR XML EXPLICIT




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDSD]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[proc_WBS_GetDSD]
(
	@DSDCode varchar(150)= '''',
	@DSDAgencyId varchar(50)= '''', 
	@DSDVersion varchar(50)= '''', 

	@ConceptSchemeCode varchar(150)= '''',
	@ConceptSchemeAgencyId varchar(150)= '''', 
	@ConceptSchemeVersion varchar(150)= '''', 

	@CodelistCode varchar(150)= '''',
	@CodelistAgencyId varchar(50)= '''', 
	@CodelistVersion varchar(50)= '''', 

	@DFId int=null,
	
	@IsStub bit=0,
	@UserName sysname = '''',
	@Domain sysname = '''',
	@TimeStamp datetime = null
)
AS

declare @DSDList table
(
	DF_ID bigint,
	DSD_ID bigint,
	DsdCode varchar(50),
	DSDAgency varchar(50), 
	DsdVersion varchar(50),
	lang varchar(50),
	descr varchar(4000),
	
	COMP_ID bigint,
	conceptRef varchar(50),
	ConceptType varchar(50),
	IsFrequencyDimension int,
	ATT_STATUS varchar(50),
	ATT_ASS_LEVEL varchar(50),

	conceptSchemeRef varchar(50),
	conceptSchemeAgency varchar(50),
	conceptVersion varchar(50),

	codelist varchar(50),
	codelistAgency varchar(50),
	codelistVersion varchar(50)
)

insert into @DSDList
select DISTINCT DF_ID, DSD.DSD_ID, ARTDSD.ID as DsdCode, ARTDSD.AGENCY as DSDAgency, LTRIM(STR(ARTDSD.VERSION1)) + ''.'' + LTRIM(STR(ARTDSD.VERSION2)) as DsdVersion, LANGUAGE as lang, TEXT as descr
, COMPONENT.COMP_ID ,COMPONENT.ID as conceptRef, COMPONENT.TYPE as ConceptType,COMPONENT.IS_FREQ_DIM as IsFrequencyDimension,
COMPONENT.ATT_STATUS, COMPONENT.ATT_ASS_LEVEL,
ARTConceptScheme.ID as conceptSchemeRef,
ARTConceptScheme.AGENCY as conceptSchemeAgency,
LTRIM(STR(ARTConceptScheme.VERSION1)) + ''.'' + LTRIM(STR(ARTConceptScheme.VERSION2))  as conceptVersion,

ARTcodelist.ID  as codelist,
ARTcodelist.AGENCY  as codelistAgency,
LTRIM(STR(ARTcodelist.VERSION1)) + ''.'' + LTRIM(STR(ARTcodelist.VERSION2))  as codelistVersion


from DSD
inner join ARTEFACT as ARTDSD  on ARTDSD.ART_ID= DSD.DSD_ID
inner join LOCALISED_STRING on ARTDSD.ART_ID= LOCALISED_STRING.ART_ID
inner join COMPONENT on COMPONENT.DSD_ID=DSD.DSD_ID
inner join DATAFLOW on DATAFLOW.DSD_ID=DSD.DSD_ID

LEFT JOIN CONCEPT on CONCEPT.CON_ID= COMPONENT.CON_ID
LEFT JOIN ARTEFACT as ARTConceptScheme on ARTConceptScheme.ART_ID = CONCEPT.CON_SCH_ID
LEFT JOIN ARTEFACT as ARTcodelist on ARTcodelist.ART_ID = COMPONENT.CL_ID
--Where DSDCode
where ARTDSD.ID = case when LEN(@DSDCode)>0 then @DSDCode else ARTDSD.ID end
--Agency e Version
AND ARTDSD.AGENCY = case when LEN(@DSDAgencyId)>0 then @DSDAgencyId else ARTDSD.AGENCY end
AND  LTRIM(STR(ARTDSD.VERSION1)) + ''.'' + LTRIM(STR(ARTDSD.VERSION2))= case when LEN(@DSDVersion)>0 then @DSDVersion else LTRIM(STR(ARTDSD.VERSION1)) + ''.'' + LTRIM(STR(ARTDSD.VERSION2)) end
-- ConceptScheme
AND ARTDSD.ID =
case when LEN(@ConceptSchemeCode)>0 then (Select DISTINCT ARTEFACT.ID 
FROM DSD
inner join ARTEFACT  on ARTEFACT.ART_ID= DSD.DSD_ID 
inner join COMPONENT on COMPONENT.DSD_ID=DSD.DSD_ID
LEFT JOIN CONCEPT on CONCEPT.CON_ID= COMPONENT.CON_ID
LEFT JOIN ARTEFACT as ARTConceptScheme on ARTConceptScheme.ART_ID = CONCEPT.CON_SCH_ID
where ARTConceptScheme.ID=@ConceptSchemeCode AND ARTEFACT.ID=ARTDSD.ID
AND ARTConceptScheme.AGENCY = case when LEN(@ConceptSchemeAgencyId)>0 then @ConceptSchemeAgencyId else ARTConceptScheme.AGENCY end
AND  LTRIM(STR(ARTConceptScheme.VERSION1)) + ''.'' + LTRIM(STR(ARTConceptScheme.VERSION2))= case when LEN(@ConceptSchemeVersion)>0 then @ConceptSchemeVersion else LTRIM(STR(ARTConceptScheme.VERSION1)) + ''.'' + LTRIM(STR(ARTConceptScheme.VERSION2)) end
)
else ARTDSD.ID end

-- Codelist
AND ARTDSD.ID =
case when LEN(@CodelistCode)>0 then (Select DISTINCT ARTEFACT.ID 
FROM DSD
inner join ARTEFACT  on ARTEFACT.ART_ID= DSD.DSD_ID 
inner join COMPONENT on COMPONENT.DSD_ID=DSD.DSD_ID
LEFT JOIN ARTEFACT as ARTCodelist on ARTcodelist.ART_ID = COMPONENT.CL_ID
where ARTCodelist.ID=@CodelistCode AND ARTEFACT.ID=ARTDSD.ID
AND ARTCodelist.AGENCY = case when LEN(@CodelistAgencyId)>0 then @CodelistAgencyId else ARTCodelist.AGENCY end
AND  LTRIM(STR(ARTCodelist.VERSION1)) + ''.'' + LTRIM(STR(ARTCodelist.VERSION2))= case when LEN(@CodelistVersion)>0 then @CodelistVersion else LTRIM(STR(ARTCodelist.VERSION1)) + ''.'' + LTRIM(STR(ARTCodelist.VERSION2)) end
)
  else ARTDSD.ID end
-- DF
AND DF_ID = 
case when @DFId is not null then @DFId else DF_ID end

declare @DSDXML table
(
	Tag int,
	Parent int null,
	[DataStructures!1!xmlns] varchar(100) null,
	[DataStructure!2!Order!hide] varchar(500) null,
	[DataStructure!2!Order2!hide] varchar(500) null,
	[DataStructure!2!id] varchar(50) null,
	[DataStructure!2!agencyID] varchar(50) null,
	[DataStructure!2!version] varchar(50) null,
	[Name!3!LocaleIsoCode] char(2) null,
	[Name!3!!cdata] varchar(4000) null,
	[Components!4!] varchar(50) null,
	
	[Dimension!5!conceptRef] varchar(50) null,
	[Dimension!5!codelist] varchar(50) null,
	[Dimension!5!codelistAgency] varchar(50) null,
	[Dimension!5!codelistVersion] varchar(50) null,
	[Dimension!5!conceptSchemeRef] varchar(50) null,
	[Dimension!5!conceptSchemeAgency] varchar(50) null,
	[Dimension!5!conceptVersion] varchar(50) null,
	[Dimension!5!isFrequencyDimension] varchar(50) null,
	
	[TimeDimension!6!conceptRef] varchar(50) null,
	[TimeDimension!6!codelist] varchar(50) null,
	[TimeDimension!6!codelistAgency] varchar(50) null,
	[TimeDimension!6!codelistVersion] varchar(50) null,
	[TimeDimension!6!conceptSchemeRef] varchar(50) null,
	[TimeDimension!6!conceptSchemeAgency] varchar(50) null,
	[TimeDimension!6!conceptVersion] varchar(50) null,

	[PrimaryMeasure!7!conceptRef] varchar(50) null,
	[PrimaryMeasure!7!codelist] varchar(50) null,
	[PrimaryMeasure!7!codelistAgency] varchar(50) null,
	[PrimaryMeasure!7!codelistVersion] varchar(50) null,
	[PrimaryMeasure!7!conceptSchemeRef] varchar(50) null,
	[PrimaryMeasure!7!conceptSchemeAgency] varchar(50) null,
	[PrimaryMeasure!7!conceptVersion] varchar(50) null,
	
	[Attribute!8!conceptRef] varchar(50) null,
	[Attribute!8!codelist] varchar(50) null,
	[Attribute!8!codelistAgency] varchar(50) null,
	[Attribute!8!codelistVersion] varchar(50) null,
	[Attribute!8!conceptSchemeRef] varchar(50) null,
	[Attribute!8!conceptSchemeAgency] varchar(50) null,
	[Attribute!8!conceptVersion] varchar(50) null,
	[Attribute!8!assignmentStatus] varchar(50) null,
	[Attribute!8!attachmentLevel] varchar(50) null,
	[Attribute!8!attachmentGroup] varchar(50) null,
	
	[Group!9!id] varchar(50) null,
	[GroupDimension!10!id] varchar(50) null


)

INSERT INTO @DSDXML (Tag,[DataStructures!1!xmlns]) Values (1,''http://istat.it/OnTheFly'')

INSERT INTO @DSDXML (Tag,Parent, [DataStructure!2!Order!hide],			
	[DataStructure!2!Order2!hide]	,		
	[DataStructure!2!id],					
	[DataStructure!2!agencyID],				
	[DataStructure!2!version])  
	SELECT DISTINCT 2,1,DSD_ID, ''02'',
	DsdCode, DSDAgency, DsdVersion
	from @DSDList

	INSERT INTO @DSDXML (Tag,Parent, [DataStructure!2!Order!hide],			
	[DataStructure!2!Order2!hide],		
	[DataStructure!2!id],					
	[DataStructure!2!agencyID],				
	[DataStructure!2!version],[Name!3!LocaleIsoCode],					
	[Name!3!!cdata]	)  
	SELECT DISTINCT 3,2,DSD_ID, ''03'',
	DsdCode, DSDAgency, DsdVersion, lang, descr
	from @DSDList

IF @IsStub=0 BEGIN
	INSERT INTO @DSDXML (Tag,Parent, [DataStructure!2!Order!hide],			
	[DataStructure!2!Order2!hide]	,		
	[DataStructure!2!id],					
	[DataStructure!2!agencyID],				
	[DataStructure!2!version], [Components!4!])  
	SELECT DISTINCT 4,2,DSD_ID, ''04'',
	DsdCode, DSDAgency, DsdVersion,NULL
	from @DSDList


	--Dimensions
	INSERT INTO @DSDXML (Tag,Parent, [DataStructure!2!Order!hide],			
	[DataStructure!2!Order2!hide]	,		
	
	[Dimension!5!conceptRef],				
	[Dimension!5!codelist]		,			
	[Dimension!5!codelistAgency],			
	[Dimension!5!codelistVersion],			
	[Dimension!5!conceptSchemeRef]	,		
	[Dimension!5!conceptSchemeAgency],		
	[Dimension!5!conceptVersion],
	[Dimension!5!isFrequencyDimension])  
	SELECT DISTINCT 5,4,DSD_ID, ''1Dimension'',
	conceptRef, codelist, codelistAgency, codelistVersion,
	conceptSchemeRef, conceptSchemeAgency, conceptVersion,
	case when IsFrequencyDimension is null then null else ''true'' end
	from @DSDList
	where ConceptType=''Dimension''

	--TimeDimension
	INSERT INTO @DSDXML (Tag,Parent, [DataStructure!2!Order!hide],			
	[DataStructure!2!Order2!hide]	,		
	
	[TimeDimension!6!conceptRef],				
	[TimeDimension!6!codelist]		,			
	[TimeDimension!6!codelistAgency],			
	[TimeDimension!6!codelistVersion],			
	[TimeDimension!6!conceptSchemeRef]	,		
	[TimeDimension!6!conceptSchemeAgency],		
	[TimeDimension!6!conceptVersion])  
	SELECT DISTINCT 6,4,DSD_ID, ''2TimeDimension'',
	conceptRef, codelist, codelistAgency, codelistVersion,
	conceptSchemeRef, conceptSchemeAgency, conceptVersion
	from @DSDList
	where ConceptType=''TimeDimension''

	
	--PrimaryMeasure
	INSERT INTO @DSDXML (Tag,Parent, [DataStructure!2!Order!hide],			
	[DataStructure!2!Order2!hide]	,		
	
	[PrimaryMeasure!7!conceptRef],				
	[PrimaryMeasure!7!codelist]		,			
	[PrimaryMeasure!7!codelistAgency],			
	[PrimaryMeasure!7!codelistVersion],			
	[PrimaryMeasure!7!conceptSchemeRef]	,		
	[PrimaryMeasure!7!conceptSchemeAgency],		
	[PrimaryMeasure!7!conceptVersion])  
	SELECT DISTINCT 7,4,DSD_ID, ''3PrimaryMeasure'',
	conceptRef, codelist, codelistAgency, codelistVersion,
	conceptSchemeRef, conceptSchemeAgency, conceptVersion
	from @DSDList
	where ConceptType=''PrimaryMeasure''

	--Attribute
	INSERT INTO @DSDXML (Tag,Parent, [DataStructure!2!Order!hide],			
	[DataStructure!2!Order2!hide]	,		
	
	[Attribute!8!conceptRef],				
	[Attribute!8!codelist]		,			
	[Attribute!8!codelistAgency],			
	[Attribute!8!codelistVersion],			
	[Attribute!8!conceptSchemeRef]	,		
	[Attribute!8!conceptSchemeAgency],		
	[Attribute!8!conceptVersion],
	[Attribute!8!assignmentStatus],
	[Attribute!8!attachmentLevel],
	[Attribute!8!attachmentGroup] )  
	SELECT DISTINCT 8,4,DSD_ID, ''4Attribute'',
	conceptRef, codelist, codelistAgency, codelistVersion,
	conceptSchemeRef, conceptSchemeAgency, conceptVersion,
	ATT_STATUS as assignmentStatus,
	Case ATT_ASS_LEVEL 
	When ''Series'' THEN ''DimensionGroup''
	When ''Observation'' THEN ''Observation''
	When ''DataSet'' THEN ''Dataset''
	When ''Group'' THEN ''Group''
    END	 as attachmentLevel,

	Case ATT_ASS_LEVEL 
	When ''Group'' THEN 
	(Select DISTINCT DSD_GROUP.ID from ATT_GROUP inner join DSD_GROUP on DSD_GROUP.GR_ID=ATT_GROUP.GR_ID where ATT_GROUP.COMP_ID= COMP_ID)
	else Null   END	 as attachmentGroup

	from @DSDList
	where ConceptType=''Attribute''

	

	--Groups
	INSERT INTO @DSDXML (Tag,Parent, [DataStructure!2!Order!hide],			
	[DataStructure!2!Order2!hide]	,	
	[Group!9!id])
	SELECT DISTINCT 9,4,DSD_GROUP.DSD_ID, ''5Group'' + 
	DSDList.conceptRef, DSD_GROUP.ID  
	from ATT_GROUP 
	inner join DSD_GROUP on DSD_GROUP.GR_ID=ATT_GROUP.GR_ID 
	inner join @DSDList as DSDList on DSDList.COMP_ID= ATT_GROUP.COMP_ID
	where DSDList.ATT_ASS_LEVEL=''Group''

	--DimensionGroups
	INSERT INTO @DSDXML (Tag,Parent, [DataStructure!2!Order!hide],			
	[DataStructure!2!Order2!hide]	,	
	[Group!9!id], [GroupDimension!10!id])
	SELECT DISTINCT 10,9,DSD_GROUP.DSD_ID, ''5Group'' + 
	DSDList.conceptRef + DimensionGroup.conceptRef, DSD_GROUP.ID  ,DimensionGroup.conceptRef
	from ATT_GROUP 
	inner join DSD_GROUP on DSD_GROUP.GR_ID=ATT_GROUP.GR_ID 
	inner join @DSDList as DSDList on DSDList.COMP_ID= ATT_GROUP.COMP_ID
	inner join DIM_GROUP on DIM_GROUP.GR_ID=  ATT_GROUP.GR_ID
	inner join @DSDList as DimensionGroup on DimensionGroup.COMP_ID = DIM_GROUP.COMP_ID
	where DSDList.ATT_ASS_LEVEL=''Group''


END

select * from @DSDXML 
order by  [DataStructure!2!Order!hide], [DataStructure!2!Order2!hide]--,[Attribute!8!conceptRef],[Group!9!id],[GroupDimension!10!id]
FOR XML EXPLICIT




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RETRIEVE_ARTEFACT_TYPE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



/*

DECLARE @ART_TYPE VARCHAR(500)
EXEC RETRIEVE_ARTEFACT_TYPE 1, @ART_TYPE OUT

SELECT @ART_TYPE

*/
CREATE PROCEDURE [dbo].[RETRIEVE_ARTEFACT_TYPE]

@ART_ID BIGINT,
@ART_TYPE VARCHAR(500) OUT

AS


SELECT @ART_TYPE = 
		CASE 
			WHEN B.AG_SCH_ID IS NOT NULL THEN
				''AGENCY_SCHEME''
			WHEN C.CATN_ID IS NOT NULL THEN
				''CATEGORISATION''
			WHEN D.CAT_SCH_ID IS NOT NULL THEN
				''CATEGORY_SCHEME''
			WHEN E.CL_ID IS NOT NULL THEN
				''CODELIST''
			WHEN F.CON_SCH_ID IS NOT NULL THEN
				''CONCEPT_SCHEME''
			WHEN G.DC_SCH_ID IS NOT NULL THEN
				''DATACONSUMER_SCHEME''
			WHEN H.DF_ID IS NOT NULL THEN
				''DATAFLOW''
			WHEN I.DP_SCH_ID IS NOT NULL THEN
				''DATAPROVIDER_SCHEME''
			WHEN L.DSD_ID IS NOT NULL THEN
				''DSD''
			WHEN M.HCL_ID IS NOT NULL THEN
				''HCL''
			WHEN N.ORG_UNIT_SCH_ID IS NOT NULL THEN
				''ORGANISATION_UNIT_SCHEME''
			WHEN O.SS_ID IS NOT NULL THEN
				''STRUCTURE_SET''
			END
FROM dbo.ARTEFACT A
	LEFT OUTER JOIN dbo.AGENCY_SCHEME B ON
		A.ART_ID = B.AG_SCH_ID
	LEFT OUTER JOIN	dbo.CATEGORISATION C ON
		A.ART_ID = C.CATN_ID
	LEFT OUTER JOIN	dbo.CATEGORY_SCHEME D ON
		A.ART_ID = D.CAT_SCH_ID
	LEFT OUTER JOIN	dbo.CODELIST E ON
		A.ART_ID = E.CL_ID
	LEFT OUTER JOIN	dbo.CONCEPT_SCHEME F ON
		A.ART_ID = F.CON_SCH_ID
	LEFT OUTER JOIN	dbo.DATACONSUMER_SCHEME G ON
		A.ART_ID = G.DC_SCH_ID
	LEFT OUTER JOIN	dbo.DATAFLOW H ON
		A.ART_ID = H.DF_ID
	LEFT OUTER JOIN	dbo.DATAPROVIDER_SCHEME I ON
		A.ART_ID = I.DP_SCH_ID
	LEFT OUTER JOIN	dbo.DSD L ON
		A.ART_ID = L.DSD_ID
	LEFT OUTER JOIN	dbo.HCL M ON
		A.ART_ID = M.HCL_ID
	LEFT OUTER JOIN	dbo.ORGANISATION_UNIT_SCHEME N ON
		A.ART_ID = N.ORG_UNIT_SCH_ID
	LEFT OUTER JOIN dbo.STRUCTURE_SET O ON
		A.ART_ID = O.SS_ID
WHERE A.ART_ID = @ART_ID




				




' 
END
GO
