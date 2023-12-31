USE [master]
GO
/****** Object:  Database [HWSInternal]    Script Date: 12/01/2015 09:16:47 ******/
/*
CREATE DATABASE [HWSInternal]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HWSInternal', FILENAME = N'I:\Database\HWSInternal_Primary.mdf' , SIZE = 524288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 131072KB )
 LOG ON 
( NAME = N'HWSInternal_log', FILENAME = N'J:\TransactionLogs\HWSInternal_Primary.ldf' , SIZE = 524288KB , MAXSIZE = 2048GB , FILEGROWTH = 131072KB )
GO
*/
ALTER DATABASE [HWSInternal] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HWSInternal].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HWSInternal] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HWSInternal] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HWSInternal] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HWSInternal] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HWSInternal] SET ARITHABORT OFF 
GO
ALTER DATABASE [HWSInternal] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HWSInternal] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [HWSInternal] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HWSInternal] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HWSInternal] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HWSInternal] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HWSInternal] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HWSInternal] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HWSInternal] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HWSInternal] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HWSInternal] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HWSInternal] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HWSInternal] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HWSInternal] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HWSInternal] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HWSInternal] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HWSInternal] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HWSInternal] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HWSInternal] SET RECOVERY FULL 
GO
ALTER DATABASE [HWSInternal] SET  MULTI_USER 
GO
ALTER DATABASE [HWSInternal] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HWSInternal] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HWSInternal] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HWSInternal] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'HWSInternal', N'ON'
GO
USE [HWSInternal]
GO
/****** Object:  User [HWSAuthenticationUser]    Script Date: 12/01/2015 09:16:47 ******/
--CREATE USER [HWSAuthenticationUser] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[Authentication]
--GO
/****** Object:  User [FFW\SVC-FFWWEBSERVICES]    Script Date: 12/01/2015 09:16:47 ******/
--CREATE USER [FFW\SVC-FFWWEBSERVICES] FOR LOGIN [FFW\SVC-FFWWEBSERVICES] WITH DEFAULT_SCHEMA=[dbo]
--GO
/****** Object:  User [FFW\SVC-FFWAPPSERVICES]    Script Date: 12/01/2015 09:16:47 ******/
--CREATE USER [FFW\SVC-FFWAPPSERVICES] FOR LOGIN [FFW\SVC-FFWAPPSERVICES] WITH DEFAULT_SCHEMA=[dbo]
--GO
/****** Object:  User [FFW\APP_FFWS_User]    Script Date: 12/01/2015 09:16:47 ******/
--CREATE USER [FFW\APP_FFWS_User] FOR LOGIN [FFW\APP_FFWS_User]
--GO
/****** Object:  DatabaseRole [HWSUserRole]    Script Date: 12/01/2015 09:16:47 ******/
CREATE ROLE [HWSUserRole]
GO
/****** Object:  DatabaseRole [HWSAuthenticationRole]    Script Date: 12/01/2015 09:16:47 ******/
CREATE ROLE [HWSAuthenticationRole]
GO
--ALTER ROLE [HWSAuthenticationRole] ADD MEMBER [HWSAuthenticationUser]
--GO
--ALTER ROLE [HWSAuthenticationRole] ADD MEMBER [FFW\SVC-FFWWEBSERVICES]
--GO
--ALTER ROLE [HWSUserRole] ADD MEMBER [FFW\SVC-FFWWEBSERVICES]
--GO
--ALTER ROLE [HWSUserRole] ADD MEMBER [FFW\SVC-FFWAPPSERVICES]
--GO
--ALTER ROLE [HWSUserRole] ADD MEMBER [FFW\APP_FFWS_User]
--GO
/****** Object:  Schema [Appointment]    Script Date: 12/01/2015 09:16:47 ******/
CREATE SCHEMA [Appointment]
GO
/****** Object:  Schema [Assessment]    Script Date: 12/01/2015 09:16:47 ******/
CREATE SCHEMA [Assessment]
GO
/****** Object:  Schema [Audit]    Script Date: 12/01/2015 09:16:47 ******/
CREATE SCHEMA [Audit]
GO
/****** Object:  Schema [Authentication]    Script Date: 12/01/2015 09:16:47 ******/
CREATE SCHEMA [Authentication]
GO
/****** Object:  Schema [Case]    Script Date: 12/01/2015 09:16:47 ******/
CREATE SCHEMA [Case]
GO
/****** Object:  Schema [Clinic]    Script Date: 12/01/2015 09:16:47 ******/
CREATE SCHEMA [Clinic]
GO
/****** Object:  Schema [Complaint]    Script Date: 12/01/2015 09:16:47 ******/
CREATE SCHEMA [Complaint]
GO
/****** Object:  Schema [INVU]    Script Date: 12/01/2015 09:16:47 ******/
CREATE SCHEMA [INVU]
GO
/****** Object:  Schema [Logging]    Script Date: 12/01/2015 09:16:47 ******/
CREATE SCHEMA [Logging]
GO
/****** Object:  Schema [Lookup]    Script Date: 12/01/2015 09:16:47 ******/
CREATE SCHEMA [Lookup]
GO
/****** Object:  Schema [Referral]    Script Date: 12/01/2015 09:16:47 ******/
CREATE SCHEMA [Referral]
GO
/****** Object:  Schema [Resources]    Script Date: 12/01/2015 09:16:47 ******/
CREATE SCHEMA [Resources]
GO
/****** Object:  Schema [Template]    Script Date: 12/01/2015 09:16:47 ******/
CREATE SCHEMA [Template]
GO
/****** Object:  StoredProcedure [dbo].[spAddClinicianSpecialisation]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		Andy Bickers
-- Create date: 26/08/2014
-- Description:	Create mapping between Clinician & Specialisations
-- =============================================
CREATE PROCEDURE [dbo].[spAddClinicianSpecialisation] 
	@uidClinician uniqueidentifier,
	@specialisation varchar(255)
AS
BEGIN
	insert into tblClinician2Specialisation 
    (fkSpecialisation,fkNetworkOHP)
    select uidSpecialisation,@uidClinician as ClinicianUID
    from tblSpecialisations where strName = @specialisation
END
GO
/****** Object:  StoredProcedure [dbo].[spAddClinicSpecialisation]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[spAddClinicSpecialisation] 
@uidClinic uniqueidentifier,
@specialisation varchar(255)
as
BEGIN
  insert into tblClinic2Specialisation 
    (fkSpecialisation,fkClinic)
    select uidSpecialisation,@uidClinic as ClinicUID
    from tblSpecialisations where strName = @specialisation
END
GO
/****** Object:  StoredProcedure [dbo].[spClearClinicianToSpecialisation]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		Andy Bickers
-- Create date: 26/08/2014
-- Description:	Clear Clinician / Specialisation mapping
-- =============================================
CREATE PROCEDURE [dbo].[spClearClinicianToSpecialisation] 
	@ClinicianID uniqueidentifier
AS
DELETE FROM tblClinician2Specialisation where fkNetWorkOHP = @ClinicianID
GO
/****** Object:  StoredProcedure [dbo].[spClearClinicToSpecialisation]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
create PROC [dbo].[spClearClinicToSpecialisation]
(
	@ClinicID UNIQUEIDENTIFIER
)
AS
DELETE FROM dbo.tblClinic2Specialisation WHERE fkClinic = @ClinicID
GO
/****** Object:  StoredProcedure [dbo].[spDocumentTemplate_GetBookmark]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		Dean
-- Create date: 27/04/11
-- Description:	Given a bookmark name returns a full bookmark object
-- =============================================
CREATE PROCEDURE [dbo].[spDocumentTemplate_GetBookmark] 
	-- Add the parameters for the stored procedure here
	@bookmarkName varchar(255) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT *
  FROM tblBookmarks
  where bookmarkName = @bookmarkName
END
GO
/****** Object:  StoredProcedure [dbo].[spGetAllClinicians]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllClinicians] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT
	[uidNetworkOHP]
      ,[strTitle]
      ,[strFirstName]
      ,[strLastName]
      ,[strMobile]
      ,[strTelWork]
      ,[strTelHome]
      ,[strEmail]
      ,[isEnabled]
      ,[strModBy]
      ,[dtmMod]
      ,[strCreatedBy]
      ,[dtmCreated]
      ,[ccyDefaultFee]
      ,[isActive]
      ,[strComments]
      ,[strNetOHPType]
      ,[strClass]
      ,[ccyDefaultFeeDNA]
      ,[isSpecialist]
      ,[isOHP]
      ,[ccyDefaultFeeCanx]
      ,[fkOHQualification]
      ,[strTelWork2]
      ,[isPreferred]
      ,[isChase]
      ,[isBookNow]
      ,[dtmPIRenewal]
      ,[dtmGMCRenewal]
      ,[isOHA]
      ,[isHML]
      ,[ResourceId]
      ,[NetworkDoctorId]
FROM            tblNetworkOHPs
						 ORDER BY strLastName, strFirstName
END
GO
/****** Object:  StoredProcedure [dbo].[spGetAllClinics]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[spGetAllClinics]
AS

SELECT * FROM dbo.tblOHPClinics
ORDER BY strName
GO
/****** Object:  StoredProcedure [dbo].[spGetAllDocumentTemplateButtonGroups]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[spGetAllDocumentTemplateButtonGroups]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT 
	bg.*
FROM 
	[dbo].[tblButtonGroups] bg
ORDER BY
	bg.strName
END
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
/****** Object:  StoredProcedure [dbo].[spGetAllHMLClinics]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[spGetAllHMLClinics]
AS

SELECT * FROM dbo.tblOHPClinics
WHERE isHML = 1
ORDER BY strName
GO
/****** Object:  StoredProcedure [dbo].[spGetAllOHQualifications]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		Andy Bickers
-- Create date: 26/08/2014
-- Description:	Return list of all OHQualifications
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllOHQualifications] 
AS
BEGIN
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblOHQualifications Order by strName
END
GO
/****** Object:  StoredProcedure [dbo].[spGetClinicByClinicianID]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetClinicByClinicianID] 
	-- Add the parameters for the stored procedure here
	@ClinicianID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT
	tblOHPClinics.*, tblClinic2OHP.fkNetworkOHP
FROM            tblClinic2OHP INNER JOIN
                         tblOHPClinics ON tblClinic2OHP.fkClinic = tblOHPClinics.uidClinic
						 WHERE tblClinic2OHP.fkNetworkOHP = @ClinicianID
						 ORDER BY tblOHPClinics.strName
END
GO
/****** Object:  StoredProcedure [dbo].[spGetClinicianByClinicID]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetClinicianByClinicID] 
	-- Add the parameters for the stored procedure here
	@ClinicID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT tblNetworkOHPs.*
FROM            tblNetworkOHPs INNER JOIN
                tblClinic2OHP ON tblNetworkOHPs.uidNetworkOHP = tblClinic2OHP.fkNetworkOHP
				WHERE tblClinic2OHP.fkClinic = @ClinicID
				ORDER BY strLastName, strFirstName
END
GO
/****** Object:  StoredProcedure [dbo].[spGetClinicianByID]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetClinicianByID]
	-- Add the parameters for the stored procedure here

@ClinicianID uniqueidentifier

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from tblNetworkOHPs where uidNetworkOHP = @clinicianID
END
GO
/****** Object:  StoredProcedure [dbo].[spGetClinicianByResourceId]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		Andy Bickers
-- Create date: 23/09/2014
-- Description:	Retrieve clinician guid from HWS resource
-- =============================================
CREATE PROCEDURE [dbo].[spGetClinicianByResourceId] 
	@ResourceId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM tblNetworkOHPs WHERE ResourceId = @ResourceId
END
GO
/****** Object:  StoredProcedure [dbo].[spGetDocumentCategories]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetDocumentCategories]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT 
	dc.*
FROM
	dbo.tblDocumentCategories dc
WHERE 
	dc.CategoryName != ''
ORDER BY
	dc.DisplayOrder
END
GO
/****** Object:  StoredProcedure [dbo].[spGetDocumentsByCategoryID]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetDocumentsByCategoryID]
	-- Add the parameters for the stored procedure here

@CategoryID uniqueidentifier

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT 
	t.*
FROM
	dbo.tblTemplates t
WHERE 
	t.CategoryID = @CategoryID
ORDER BY
	t.strName
END
GO
/****** Object:  StoredProcedure [dbo].[spGetGlobalVars]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[spGetGlobalVars]
AS

SELECT * FROM tblGlobalVars WHERE isCurrent = 1
GO
/****** Object:  StoredProcedure [dbo].[spGetInvuDocumentsForProcessing]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
Create PROCEDURE [dbo].[spGetInvuDocumentsForProcessing] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    
	SELECT TOP 100 d.*, c.CaseNumber fROM tblInvuDocuments d (NOLOCK) INNER JOIN [case].[Case] c on d.caseId=c.Id  where processed = 0
END
GO
/****** Object:  StoredProcedure [dbo].[spGetInvuDocumentTypeByID]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[spGetInvuDocumentTypeByID]
@id int
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT 
	ID
	,FullyQualifiedTypeName 
	,DisplayName 
	,IsClinical
 FROM tblInvuDocumentTypes where ID = @id
GO
/****** Object:  StoredProcedure [dbo].[spGetNearByHMLHPs]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetNearByHMLHPs]
	@topStart int,
	@topEnd int,
	@searchText varchar(50) = NULL,
	@inLong float = NULL,
	@inLat float = NULL,
	@searchMode TINYINT, --appointmenttype
	@apptType TINYINT
AS
BEGIN
  --get a set of clinics with associated HML doctors near a grid reference        
  -- omit doctors second clinics
IF @topStart < 1 SET @topStart = 1
  IF @topEnd < @topStart SET @topEnd = @topStart 
  SET @topStart = @topStart -1

	CREATE TABLE #tTmp
	(uid UNIQUEIDENTIFIER
	, thisClinic UNIQUEIDENTIFIER
	, ClinicName VARCHAR(150)
	, DoctorName VARCHAR(150)
	, distance FLOAT)
	
	  CREATE TABLE #tAll 
	(uid UNIQUEIDENTIFIER
	, thisClinic UNIQUEIDENTIFIER
	, ClinicName VARCHAR(150)
	, DoctorName VARCHAR(150)
	, distance FLOAT)
 
  --full set of close Client/doctor ID's
  --Get a unique list of the doctors / clinics

		 INSERT INTO #tTmp
		  SELECT DISTINCT
			vwDetail.fkNetworkOHP
			,vwDetail.uidClinic
			,vwDetail.Clinic
			,vwDetail.Clinician
			,CASE WHEN @searchMode = 0 OR @searchMode = 1 THEN dbo.udfComputeDistance(vwDetail.flClinicLat ,vwDetail.flClinicLong ,@inLat ,@inLong)
			ELSE 0 END AS 'distance'
		  FROM 
			dbo.vwClinic2OHPDetail vwDetail
		  WHERE
				vwDetail.flClinicLat IS NOT NULL
			AND 
				vwDetail.flClinicLong IS NOT NULL
			AND 
				vwDetail.fkNetworkOHP IS NOT NULL
			AND 
				(
					(@searchMode = 0 OR @searchMode = 1)--postcode???
					OR
					(@searchMode = 2 AND LOWER(vwDetail.Clinic) LIKE '%' + LOWER(@searchText) + '%')
					OR
					(@searchMode = 3 AND LOWER(vwDetail.Clinician) LIKE '%' + LOWER(@searchText) + '%')
				)
			AND
				(
					--OHP IMA appt
					(@apptType = 0 AND vwDetail.isOHP = 1)
					OR
					--OHA IMA appt
					(@apptType = 1 AND vwDetail.isOHA = 1)
					OR
					--HMLHP appt
					(@apptType = 3 AND vwDetail.HMLResourceId IS NOT NULL)
				)

SET ROWCOUNT @topEnd
IF @searchMode = 0 OR @searchMode = 1
BEGIN
INSERT INTO #tAll
SELECT  * FROM #tTmp
ORDER BY distance
END
ELSE
BEGIN
INSERT INTO #tAll
SELECT  * FROM #tTmp
ORDER BY ClinicName, DoctorName
END

    --Now find the first n of these for later discard
	CREATE TABLE #tOmit 
		(uid UNIQUEIDENTIFIER
		, thisClinic UNIQUEIDENTIFIER)
		
	IF @topStart > 0 
		BEGIN
			SET ROWCOUNT @topStart
			INSERT INTO #tOmit
				SELECT
					#tAll.uid
					,#tAll.thisClinic
				FROM
					#tAll
				ORDER BY
				CASE WHEN @searchMode = 1 OR @searchMode = 0 THEN distance
				WHEN @searchMode = 2 THEN ClinicName
				ELSE DoctorName END
		END


	SET ROWCOUNT 0 -- Return all the results from the next query
	
	SELECT 
		distance
		,vwDetail.*  
	FROM
		dbo.vwClinic2OHPDetail vwDetail
		LEFT JOIN #tAll ON vwDetail.uidClinic = #tAll.thisClinic
			AND vwDetail.fkNetworkOHP = #tAll.uid 
		LEFT JOIN #tOmit ON vwDetail.uidClinic = #tOmit.thisClinic 
			AND vwDetail.fkNetworkOHP = #tOmit.uid 
	WHERE
			#tOmit.thisClinic IS NULL
		AND
			#tAll.thisClinic IS NOT NULL
	ORDER BY #tAll.distance asc
END
GO
/****** Object:  StoredProcedure [dbo].[spGetNearbyIMAClinics]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[spGetNearbyIMAClinics]
(
 @topStart int,
 @topEnd int,
 @searchText varchar(50) = NULL,
 @inLong FLOAT = NULL,
 @inLat FLOAT = NULL,
 @searchMode TINYINT,
 @apptType TINYINT,
 @ClientID UNIQUEIDENTIFIER,
 @CaseTypeID INT = 0
)
AS
BEGIN

  --get a set of clinics with associated doctors near a grid reference        
  -- omit doctors second clinics
IF @topStart < 1 SET @topStart = 1
  IF @topEnd < @topStart SET @topEnd = @topStart 
  SET @topStart = @topStart -1

	CREATE TABLE #tTmp
	(uid UNIQUEIDENTIFIER
	, thisClinic UNIQUEIDENTIFIER
	, ClinicName VARCHAR(150)
	, DoctorName VARCHAR(150)
	, distance FLOAT)
	
	  CREATE TABLE #tAll 
	(uid UNIQUEIDENTIFIER
	, thisClinic UNIQUEIDENTIFIER
	, ClinicName VARCHAR(150)
	, DoctorName VARCHAR(150)
	, distance FLOAT)
 
  --full set of close Client/doctor ID's
  --Get a unique list of the doctors / clinics

		 INSERT INTO #tTmp
		  SELECT DISTINCT
			vwDetail.fkNetworkOHP
			,vwDetail.uidClinic
			,vwDetail.Clinic
			,vwDetail.Clinician
			,CASE WHEN @searchMode = 0 OR @searchMode = 1 THEN dbo.udfComputeDistance(vwDetail.flClinicLat ,vwDetail.flClinicLong ,@inLat ,@inLong)
			ELSE 0 END AS 'distance'
		  FROM 
			dbo.vwClinic2OHPDetail vwDetail
				--		JOIN
				--(
				--	SELECT 
				--		wt2cl.*
				--	FROM 
				--		dbo.tblWorkStates ws
				--		JOIN dbo.tblClientDefaultFees cdf on ws.ID = cdf.fkWorkState
				--		JOIN dbo.tblContracts con on cdf.fkContract = con.uidContract AND getdate() between dtmStart AND dtmEnd
				--		JOIN dbo.tblWorkTypes wt on ws.fkWorkType = wt.uidWorkType
				--		JOIN dbo.tblWorkTypeToClinicLink wt2cl ON wt2cl.WorkTypeID = ws.fkWorkType
				--	WHERE 
				--		ws.fkCaseType = @CaseTypeID
				--		AND ws.fkState4Work = '9EA84EF7-B328-4D19-ACD6-C329809166D3'
				--		AND wt.fkWorkCategory = 1
				--		AND cdf.fkClient = @ClientID
				--		AND cdf.IsEnabled = 1
				--) wStates ON vwDetail.IsHML = 1 
				--	AND ((vwDetail.IsOHP = 1 AND wStates.IsOHP = 1 AND @apptType = 0) OR (@apptType = 1 AND vwDetail.isOHA = 1 AND wStates.IsOHP = 0))
				--	AND vwDetail.IsOnsite = wStates.IsOnsite
		  WHERE
				vwDetail.flClinicLat IS NOT NULL
			AND 
				vwDetail.flClinicLong IS NOT NULL
			AND 
				vwDetail.fkNetworkOHP IS NOT NULL
			AND 
				(
					(@searchMode = 0 OR @searchMode = 1)
					OR
					(@searchMode = 2 AND vwDetail.Clinic LIKE '%' + @searchText + '%')
					OR
					(@searchMode = 3 AND vwDetail.Clinician LIKE '%' + @searchText + '%')
				)
			--AND
			--	(
			--		--OHP IMA appt
			--		(@apptType = 0 AND vwDetail.isOHP = 1)
			--		OR
			--		--OHA IMA appt
			--		(@apptType = 1 AND vwDetail.isOHA = 1)
			--	)
			

SET ROWCOUNT @topEnd
IF @searchMode = 0 OR @searchMode = 1
BEGIN
INSERT INTO #tAll
SELECT  * FROM #tTmp
ORDER BY distance asc
END
ELSE
BEGIN
INSERT INTO #tAll
SELECT  * FROM #tTmp
ORDER BY ClinicName, DoctorName
END
    --Now find the first n of these for later discard
	CREATE TABLE #tOmit 
		(uid UNIQUEIDENTIFIER
		, thisClinic UNIQUEIDENTIFIER)
		
	IF @topStart > 0 
		BEGIN
			SET ROWCOUNT @topStart
			INSERT INTO #tOmit
				SELECT
					#tAll.uid
					,#tAll.thisClinic
				FROM
					#tAll
				ORDER BY
				CASE WHEN @searchMode = 1 OR @searchMode = 0 THEN distance
				WHEN @searchMode = 2 THEN ClinicName
				ELSE DoctorName END
		END


	SET ROWCOUNT 0 -- Return all the results from the next query
	
	SELECT 
		distance
		,vwDetail.*  
	FROM
		dbo.vwClinic2OHPDetail vwDetail
		LEFT JOIN #tAll ON vwDetail.uidClinic = #tAll.thisClinic
			AND vwDetail.fkNetworkOHP = #tAll.uid 
		LEFT JOIN #tOmit ON vwDetail.uidClinic = #tOmit.thisClinic 
			AND vwDetail.fkNetworkOHP = #tOmit.uid 
	WHERE
			#tOmit.thisClinic IS NULL
		AND
			#tAll.thisClinic IS NOT NULL
			ORDER BY #tAll.distance asc
END
GO
/****** Object:  StoredProcedure [dbo].[spGetNearbySpecialists]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[spGetNearbySpecialists]
(
 @topStart int,
 @topEnd int,
 @specialisations varchar(MAX),
 @searchText varchar(50) = NULL,
 @inLong float = NULL,
 @inLat float = NULL,
 @searchMode TINYINT
)
AS
BEGIN

--first we need to grab the current contract 
--so that we can grab the work types associated with it

--SELECT @ClientID = fkCompany, @CaseTypeID = fkCaseType FROM tblCases WHERE uidCase = @CaseID

  --get a set of clinics with associated doctors near a grid reference        
  -- omit doctors second clinics
IF @topStart < 1 SET @topStart = 1
  IF @topEnd < @topStart SET @topEnd = @topStart 
  SET @topStart = @topStart -1

	CREATE TABLE #tTmp
	(uid UNIQUEIDENTIFIER
	, thisClinic UNIQUEIDENTIFIER
	, ClinicName VARCHAR(150)
	, DoctorName VARCHAR(150)
	, distance FLOAT)
	
	  CREATE TABLE #tAll 
	(uid UNIQUEIDENTIFIER
	, thisClinic UNIQUEIDENTIFIER
	, ClinicName VARCHAR(150)
	, DoctorName VARCHAR(150)
	, distance FLOAT)
 
  --full set of close Client/doctor ID's
  --Get a unique list of the doctors / clinics

		 INSERT INTO #tTmp
		  SELECT DISTINCT
			vwDetail.fkNetworkOHP
			,vwDetail.uidClinic
			,vwDetail.Clinic
			,vwDetail.Clinician
			,CASE WHEN @searchMode = 0 OR @searchMode = 1 THEN dbo.udfComputeDistance(vwDetail.flClinicLat ,vwDetail.flClinicLong ,@inLat ,@inLong)
			ELSE 0 END AS 'distance'
		  FROM 
			dbo.vwClinic2OHPDetail vwDetail
			JOIN dbo.tblClinician2Specialisation dr ON vwDetail.fkNetworkOHP = dr.fkNetworkOHP
		  WHERE
				vwDetail.flClinicLat IS NOT NULL
			AND 
				vwDetail.flClinicLong IS NOT NULL
			AND 
				vwDetail.fkNetworkOHP IS NOT NULL
			AND 
				(
					(@searchMode = 0 OR @searchMode = 1)
					OR
					(@searchMode = 2 AND vwDetail.Clinic LIKE '%' + @searchText + '%')
					OR
					(@searchMode = 3 AND vwDetail.Clinician LIKE '%' + @searchText + '%')
				)
			AND dr.fkSpecialisation IN
			(
				SELECT CAST(Data AS UNIQUEIDENTIFIER) FROM dbo.Split(@specialisations, ',')
			)

SET ROWCOUNT @topEnd
IF @searchMode = 0 OR @searchMode = 1
BEGIN
INSERT INTO #tAll
SELECT  * FROM #tTmp
ORDER BY distance
END
ELSE
BEGIN
INSERT INTO #tAll
SELECT  * FROM #tTmp
ORDER BY ClinicName, DoctorName
END

    --Now find the first n of these for later discard
	CREATE TABLE #tOmit 
		(uid UNIQUEIDENTIFIER
		, thisClinic UNIQUEIDENTIFIER)
		
	IF @topStart > 0 
		BEGIN
			SET ROWCOUNT @topStart
			INSERT INTO #tOmit
				SELECT
					#tAll.uid
					,#tAll.thisClinic
				FROM
					#tAll
				ORDER BY
				CASE WHEN @searchMode = 1 OR @searchMode = 0 THEN distance
				WHEN @searchMode = 2 THEN ClinicName
				ELSE DoctorName END
		END


	SET ROWCOUNT 0 -- Return all the results from the next query
	
	SELECT 
		distance
		,vwDetail.*  
	FROM
		dbo.vwClinic2OHPDetail vwDetail
		LEFT JOIN #tAll ON vwDetail.uidClinic = #tAll.thisClinic
			AND vwDetail.fkNetworkOHP = #tAll.uid 
		LEFT JOIN #tOmit ON vwDetail.uidClinic = #tOmit.thisClinic 
			AND vwDetail.fkNetworkOHP = #tOmit.uid 
	WHERE
			#tOmit.thisClinic IS NULL
		AND
			#tAll.thisClinic IS NOT NULL
END
GO
/****** Object:  StoredProcedure [dbo].[spGetOHPClinic]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE procedure [dbo].[spGetOHPClinic]
@uidClinic uniqueidentifier
as
begin
Set transaction isolation level read uncommitted

SELECT 
	clinic.*
FROM 
	dbo.tblOHPClinics clinic
WHERE 
	clinic.uidClinic = @uidClinic
        
        
end
GO
/****** Object:  StoredProcedure [dbo].[spGetOHQualification]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetOHQualification]
	-- Add the parameters for the stored procedure here

@OHQualificationID uniqueidentifier

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT * FROM tblOHQualifications where uidOHQualification = @OHQualificationID
END
GO
/****** Object:  StoredProcedure [dbo].[spGetScannedDocTypes]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[spGetScannedDocTypes]
AS

SELECT * FROM tblScannedDocumentTypes
ORDER BY [Description]
GO
/****** Object:  StoredProcedure [dbo].[spGetSpecialisations]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[spGetSpecialisations]
as
BEGIN
Set transaction isolation level read uncommitted
select tblSpecialisations.uidSpecialisation,tblSpecialisations.strShortDesc,tblSpecialisations.strName,
tblSpecialisations.isActive,tblSpecialisations.strModBy,tblSpecialisations.dtmMod
from tblSpecialisations order by strName
  
End
GO
/****** Object:  StoredProcedure [dbo].[spGetSpecialisationsForClinicByID]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[spGetSpecialisationsForClinicByID]
	-- Add the parameters for the stored procedure here

@ID uniqueidentifier

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		sp.uidSpecialisation
		,sp.strName
		,sp.strModBy
		,sp.dtmMod
		,sp.strCreatedBy
		,sp.dtmCreated
		,sp.strShortDesc
		,sp.intOrder
		,sp.isActive
		,cls.fkClinic
	FROM
		tblClinic2Specialisation cls
		INNER JOIN tblSpecialisations sp ON cls.fkSpecialisation = sp.uidSpecialisation
	WHERE
		(cls.fkClinic = @ID)
		

	
END
GO
/****** Object:  StoredProcedure [dbo].[spGetSpecialisationsForClinicianByID]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetSpecialisationsForClinicianByID]
	-- Add the parameters for the stored procedure here

@ID uniqueidentifier

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		sp.uidSpecialisation
		,sp.strName
		,sp.strModBy
		,sp.dtmMod
		,sp.strCreatedBy
		,sp.dtmCreated
		,sp.strShortDesc
		,sp.intOrder
		,sp.isActive
		,cls.fkNetworkOHP
	FROM tblClinician2Specialisation cls
		INNER JOIN tblSpecialisations sp ON cls.fkSpecialisation = sp.uidSpecialisation
	--FROM
	--	tblDr2Specialisation drs
	--	INNER JOIN tblSpecialisations sp ON drs.fkSpecialisation = sp.uidSpecialisation
	WHERE
		(cls.fkNetworkOHP = @ID)
		

	
END
GO
/****** Object:  StoredProcedure [dbo].[spGetTemplateDocumentsForButtonGroup]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spGetTemplateDocumentsForButtonGroup]
	@ButtonGroupID uniqueidentifier
	,@ClientID uniqueidentifier = null
as
begin
set nocount on

SELECT
	tb.strName 
	,tb.uidTemplateButton
	,t.strURL
	,t.uidTemplate
	,tb.strModBy
	,tb.dtmMod
	,tb.strCreatedBy
	,tb.dtmCreated
	,t.isEmail
	,t.fkInvuDocType
	,t.CategoryID
	,t.NotForHR
	,t.IntendedAudience
	, tb.EmailSubject
FROM
	dbo.tblTemplateButtons tb
	join dbo.tblTemplates t on tb.fkTemplate = t.uidTemplate
	join dbo.tblButtonGroups bg on tb.fkButtonGroup = bg.uidButtonGroup
WHERE 
	bg.uidbuttongroup = @ButtonGroupID
	
ORDER BY 
	tb.strName      
END
GO
/****** Object:  StoredProcedure [dbo].[spInvuGetDocumentTypes]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[spInvuGetDocumentTypes] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [INVU].[DocumentType] order by DisplayName
END
GO
/****** Object:  StoredProcedure [dbo].[spLinkClinicToClinician]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		Andy Bickers
-- Create date: 29/08/2014
-- Description:	Maps clinic to clinician & vice versa
-- =============================================
CREATE PROCEDURE [dbo].[spLinkClinicToClinician] 
	@clinicId UNIQUEIDENTIFIER,
	@clinicianId UNIQUEIDENTIFIER,
	@strCreatedBy varchar(100)
AS
DECLARE @ClinicToClinicianCount TINYINT
SELECT @ClinicToClinicianCount = COUNT(*) FROM dbo.tblClinic2OHP WHERE fkNetworkOHP = @clinicianId and fkClinic = @clinicId

IF @ClinicToClinicianCount = 0
begin 
	insert into dbo.tblClinic2OHP
	(
		fkClinic,
		fkNetworkOHP,
		strModBy,
		strCreatedBy
	)
	values
	(
		@clinicId,
		@clinicianId,
		@strCreatedBy,
		@strCreatedBy
	)
END
GO
/****** Object:  StoredProcedure [dbo].[spLinkResourceToClinician]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		Andy Bickers
-- Create date: 23/09/2014
-- Description:	Links HWS Resource to a Clinician
-- =============================================
CREATE PROCEDURE [dbo].[spLinkResourceToClinician] 
	@ClinicianID UNIQUEIDENTIFIER
	,@ResourceId int = null
AS
BEGIN
	--remove existing resource from clinician
	if @ResourceId is not null
	begin
	UPDATE tblNetworkOHPs Set ResourceId = NULL WHERE ResourceId = @ResourceId
	end

	UPDATE tblNetworkOHPs SET ResourceId = @ResourceId WHERE uidNetworkOHP = @ClinicianID
END
GO
/****** Object:  StoredProcedure [dbo].[spSaveClinic]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[spSaveClinic]
(
	@ClinicID UNIQUEIDENTIFIER
	,@PostCode varchar(10) = null
	,@Address nvarchar(255) = null
	,@Contact1Name nvarchar(70) = null
	,@Contact1Email varchar(60) = null
	,@Contact1Telephone varchar(50) = null
	,@Contact1Mobile varchar(50) = null
	,@Contact2Name nvarchar(70) = null
	,@Contact2Email varchar(60) = null
	,@Contact2Telephone varchar(50) = null	
	,@Contact2Mobile varchar(50) = null
	,@ClinicEmail nvarchar(60) = null
	,@Switchboard varchar(20) = null
	,@Country char(2) = null
	,@ModBy varchar(30) = null
	,@dtmMod datetime
	,@CreatedBy varchar(30) = null	
	,@Name varchar(60)
	,@IsActive bit
	,@Comments varchar(512) = null
	,@AdminCentre uniqueidentifier = null
	,@Lat float = null
	,@Lon float = null
	,@IsPaperWork bit
	,@Fee money = null
	,@FeeDNA money = null
	,@IsVAT bit = null
	,@Fax varchar(50) = null
	,@URLDirections varchar(500) = null
	,@URLWebSite varchar(500) = null
	,@IsAdminOnly bit
	,@IsSpecialist bit
	,@IsOH bit
	,@FeeCanx money = null
	,@IsPreferred bit
	,@IsChases bit
	,@IsBookNow bit
	,@IsHML bit
	,@IsOnsite bit
)
AS

DECLARE @ClinicCount TINYINT
SELECT @ClinicCount = COUNT(*) FROM dbo.tblOHPClinics WHERE uidClinic = @ClinicID

IF @ClinicCount = 0
BEGIN
	INSERT INTO dbo.tblOHPClinics
	(
		[strPostCode]
        ,[strAddress]
        ,[strContact1]
        ,[strContact1Email]
        ,[strContact1Tel]
        ,[strContact2]
        ,[strContact2Email]
        ,[strContact2Tel]
        ,[strEmail]
        ,[strSwitchboard]
        ,[strCountry]
        ,[strModBy]      
        ,[strCreatedBy]        
        ,[strName]
        ,[isActive]
        ,[strComments]
        ,[fkAdminCentre]
        ,[flClinicLat]
        ,[flClinicLong]
        ,[isUseForPaperWork]
        ,[strContact1Mobile]
        ,[strContact2Mobile]
        ,[ccyFee]
        ,[ccyFeeDNA]
        ,[isVAT]
        ,[strFax]
        ,[strURLDirections]
        ,[strURLWebSite]
        ,[isAdminOnly]
        ,[isSpecialist]
        ,[isOH]
        ,[ccyFeeCanx]
        ,[isPreferred]
        ,[isChase]
        ,[isBookNow]
        ,[isHML]
        ,[isOnsite]
    )
	VALUES  
	( 
		@PostCode
		,@Address 
		,@Contact1Name
		,@Contact1Email
		,@Contact1Telephone		
		,@Contact2Name 
		,@Contact2Email
		,@Contact2Telephone		
		,@ClinicEmail 
		,@Switchboard 
		,@Country 
		,@ModBy 		
		,@CreatedBy		
		,@Name 
		,@IsActive
		,@Comments
		,@AdminCentre
		,@Lat 
		,@Lon 
		,@IsPaperWork
		,@Contact1Mobile 
		,@Contact2Mobile 
		,@Fee 
		,@FeeDNA
		,@IsVAT
		,@Fax 
		,@URLDirections
		,@URLWebSite 
		,@IsAdminOnly
		,@IsSpecialist
		,@IsOH 
		,@FeeCanx
		,@IsPreferred
		,@IsChases 
		,@IsBookNow
		,@IsHML 
		,@IsOnsite
	)

	Select top 1 uidClinic FROM tblOHPClinics order by dtmCreated desc 
END
ELSE
BEGIN
	UPDATE dbo.tblOHPClinics
		SET
			[strPostCode] = @PostCode
			,[strAddress] = @Address
			,[strContact1] = @Contact1Name
			,[strContact1Email] = @Contact1Email
			,[strContact1Tel] = @Contact1Telephone
			,[strContact2] = @Contact2Name
			,[strContact2Email] = @Contact2Email
			,[strContact2Tel] = @Contact2Telephone
			,[strEmail] = @ClinicEmail
			,[strSwitchboard] = @Switchboard
			,[strCountry] = @Country
			,[strModBy] = @ModBy			
			,[dtmMod] = @dtmMod			
			,[strName] = @Name
			,[isActive] = @IsActive
			,[strComments] = @Comments
			,[fkAdminCentre] = @AdminCentre
			,[flClinicLat] = @Lat
			,[flClinicLong] = @Lon
			,[isUseForPaperWork] = @IsPaperWork
			,[strContact1Mobile] = @Contact1Mobile
			,[strContact2Mobile] = @Contact2Name
			,[ccyFee] = @Fee
			,[ccyFeeDNA] = @FeeDNA
			,[isVAT] = @IsVAT
			,[strFax] = @Fax
			,[strURLDirections] = @URLDirections
			,[strURLWebSite] = @URLWebSite
			,[isAdminOnly] = @IsAdminOnly
			,[isSpecialist] = @IsSpecialist
			,[isOH] = @IsOH
			,[ccyFeeCanx] = @FeeCanx
			,[isPreferred] = @IsPreferred
			,[isChase] = @IsChases
			,[isBookNow] = @IsBookNow
			,[isHML] = @IsHML
			,[isOnsite] = @IsOnsite
	WHERE uidClinic = @ClinicID

	select @ClinicID
END
GO
/****** Object:  StoredProcedure [dbo].[spSaveClinician]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		Andy Bickers
-- Create date: 01/09/2014
-- Description:	Save Clinician
-- =============================================
CREATE PROCEDURE [dbo].[spSaveClinician] 
	@ClinicianID UNIQUEIDENTIFIER
	,@Title varchar(10) = null
	,@FirstName nvarchar(50) = null
	,@LastName nvarchar(50) = null
	,@Mobile varchar(20) = null
	,@TelWork varchar(20) = null
	,@TelHome varchar(20) = null
	,@Email nvarchar(80) = null
	,@IsEnabled bit
	,@ModBy varchar(50) = null
	,@dtmMod datetime
	,@CreatedBy varchar(30) = null
	,@DefaultFee money = null
	,@IsActive bit	
	,@Comments varchar(1024) = null	
	,@NetOHPType varchar(20)
	,@Class varchar(10) = null
	,@DefaultFeeDNA money = null
	,@IsSpecialist bit
	,@IsOHP bit
	,@DefaultFeeCanx money = null
	,@OHQualifications uniqueidentifier = null
	,@TelWork2 varchar(20) = null
	,@IsPreferred bit
	,@IsChase bit
	,@IsBookNow bit
	,@PIRenewal datetime = null
	,@GMCRenewal datetime = null
	,@IsOHA bit
	,@IsHML bit

AS

DECLARE @ClinicianCount TINYINT
SELECT @ClinicianCount = COUNT(*) FROM dbo.tblNetworkOHPs WHERE uidNetworkOHP = @ClinicianID

IF @ClinicianCount = 0
BEGIN
	INSERT INTO dbo.tblNetworkOHPs
	(
        [strTitle],
		[strFirstName],
		[strLastName],
		[strMobile],
		[strTelWork],
		[strTelHome],
		[strEmail],
		[isEnabled],
		[strModBy],
		[strCreatedBy],
		[ccyDefaultFee],
		[isActive],
		[strComments],
		[strNetOHPType],
		[strClass],
		[ccyDefaultFeeDNA],
		[isSpecialist],
		[isOHP],
		[ccyDefaultFeeCanx],
		[fkOHQualification],
		[strTelWork2],
		[isPreferred],
		[isChase],
		[isBookNow],
		[dtmPIRenewal],
		[dtmGMCRenewal],
		[isOHA],
		[isHML]
    )
	VALUES  
	( 
		@Title
		,@FirstName
		,@LastName
		,@Mobile
		,@TelWork
		,@TelHome
		,@Email
		,@IsEnabled
		,@ModBy	
		,@CreatedBy
		,@DefaultFee
		,@IsActive	
		,@Comments	
		,@NetOHPType
		,@Class
		,@DefaultFeeDNA
		,@IsSpecialist
		,@IsOHP
		,@DefaultFeeCanx
		,@OHQualifications
		,@TelWork2
		,@IsPreferred
		,@IsChase
		,@IsBookNow
		,@PIRenewal
		,@GMCRenewal
		,@IsOHA
		,@IsHML
	)
	select top 1 uidNetworkOHP from tblNetworkOHPs order by dtmCreated desc
END
ELSE
BEGIN
	UPDATE dbo.tblNetworkOHPs
		SET
			[strTitle] = @Title,
			[strFirstName] = @FirstName,
			[strLastName] = @LastName,
			[strMobile] = @Mobile,
			[strTelWork] = @TelWork,
			[strTelHome] = @TelHome,
			[strEmail] = @Email,
			[isEnabled] = @IsEnabled,
			[strModBy] = @ModBy,
			[dtmMod] = @dtmMod,
			[ccyDefaultFee] = @DefaultFee,
			[isActive] = @IsActive,
			[strComments] = @Comments,
			[strNetOHPType] = @NetOHPType,
			[strClass] = @Class,
			[ccyDefaultFeeDNA] = @DefaultFeeDNA,
			[isSpecialist] = @IsSpecialist,
			[isOHP] = @IsOHP,
			[ccyDefaultFeeCanx] = @DefaultFeeCanx,
			[fkOHQualification] = @OHQualifications,
			[strTelWork2] = @TelWork2,
			[isPreferred] = @IsPreferred,
			[isChase] = @IsChase,
			[isBookNow] = @IsBookNow,
			[dtmPIRenewal] = @PIRenewal,
			[dtmGMCRenewal] = @GMCRenewal,
			[isOHA] = @IsOHA,
			[isHML] = @IsHML
	WHERE uidNetworkOHP = @ClinicianID

	select @ClinicianID
END
GO
/****** Object:  StoredProcedure [dbo].[spSaveDocumentTemplateButtonContext]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[spSaveDocumentTemplateButtonContext]
	
@DisplayName VARCHAR(255)
,@PathToFile VARCHAR(500)
,@IsEmail BIT
,@InvuDocTypeID INT
,@GroupID UNIQUEIDENTIFIER
,@CategoryId UNIQUEIDENTIFIER	
,@IntendedAudience TINYINT = NULL
,@ClientID UNIQUEIDENTIFIER = NULL
,@User VARCHAR(30)
,@EmailSubject VARCHAR(255) = NULL

AS
BEGIN
    -- Insert statements for procedure here
DECLARE @NewTemplateID UNIQUEIDENTIFIER
SET @NewTemplateID = NEWID()

DECLARE @NewTemplateButtonID UNIQUEIDENTIFIER
SET @NewTemplateButtonID = NEWID()

DECLARE @now DATETIME
SET @now = GETDATE()

-- firstly the template
INSERT INTO dbo.tblTemplates
        ( 
        uidTemplate 
        ,strName 
        ,strURL 
        ,strModBy 
        ,dtmMod 
        ,dtmCreated 
        ,strCreatedBy 
        ,isEmail 
        ,fkInvuDocType 
        ,CategoryID 
        ,NotForHR 
        ,IntendedAudience
        )
	VALUES  
		( 
		@NewTemplateID
		,@DisplayName 
        ,@PathToFile
        ,@User	 
        ,@now
        ,@now 
        ,@User 
        ,@IsEmail 
        ,@InvuDocTypeID
        ,@CategoryId
        ,NULL --not for hr
        ,@IntendedAudience
        )

--now the button group
INSERT INTO dbo.tblTemplateButtons
        ( 
        uidTemplateButton 
        ,fkButtonGroup 
        ,strName 
        ,fkTemplate 
        ,strModBy 
        ,dtmMod 
        ,dtmCreated 
        ,strCreatedBy 
        ,isDateCert 
        ,EmailSubject
        )
	VALUES  ( 
		@NewTemplateButtonID 
		,@GroupID 
		,@DisplayName
		,@NewTemplateID 
		,@User 
		,@now
		,@now 
		,@User 
		,0 
		,@EmailSubject 
        )
end
GO
/****** Object:  StoredProcedure [dbo].[spSaveInvuDocument]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		Dean
-- Create date: 05/09/2011
-- Description:	Inserts a serialized InvuDocument type ready for processing into Invu
-- =============================================
CREATE PROCEDURE [dbo].[spSaveInvuDocument] 
	-- Add the parameters for the stored procedure here
	@invuDocument nvarchar(max), 
	@createdBy nvarchar(30),
	@caseId int,
	@caseNoteId int,
	@docAssembly nvarchar(255),
	@docBaseTypeFullName nvarchar(255),
	@docTypeFullName nvarchar(255),
	@invuId int = null,
	@docPath nvarchar(510)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO tblInvuDocuments
           ([invuDocument]
           ,[createdBy]
           ,[caseId]
           ,[caseNoteId]
           ,[docAssembly]
           ,[docBaseTypeFullName]
           ,[docTypeFullName]
           ,[invuId]
           ,[docPath])
     VALUES
           (@invuDocument
           ,@createdBy
           ,@caseId
           ,@caseNoteId
           ,@docAssembly
           ,@docBaseTypeFullName
           ,@docTypeFullName
           ,@invuId
           ,@docPath)
           
     SELECT IDENT_CURRENT ('tblInvuDocuments') AS recordId;
END
GO
/****** Object:  StoredProcedure [dbo].[spSaveInvuIndexException]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spSaveInvuIndexException]
	@invuDocumentId INT
	,@exception NVARCHAR(max)
	,@caseId int
	,@caseNoteId int
AS
BEGIN

SET NOCOUNT ON;

INSERT INTO tblInvuIndexExceptions
           ([invuDocumentId]
           ,[exception]
           ,[caseId]
           ,[caseNoteId])
     VALUES
           (@invuDocumentId
           ,@exception
           ,@caseId
           ,@caseNoteId)
end
GO
/****** Object:  StoredProcedure [dbo].[spUnLinkClinicToClinician]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		Andy Bickers
-- Create date: 02/09/2014
-- Description:	Remove maps clinic to clinician & vice versa
-- =============================================
CREATE PROCEDURE [dbo].[spUnLinkClinicToClinician] 
	@clinicId UNIQUEIDENTIFIER,
	@clinicianId UNIQUEIDENTIFIER
AS

begin 
	delete from tblClinic2OHP
	where fkClinic = @clinicId and fkNetworkOHP = @clinicianId
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateCaseNoteWithInvuId]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[spUpdateCaseNoteWithInvuId]
	@id int
	,@invuId int
AS
BEGIN

SET NOCOUNT ON;
UPDATE [Case].[CaseNote]
   SET InvuId = @invuId
 WHERE  id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateInvuDocument_Failed]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spUpdateInvuDocument_Failed]
	@id int
AS
BEGIN

SET NOCOUNT ON;

UPDATE tblInvuDocuments
   SET
		processed = 1,
		failed = 1
 WHERE  id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateInvuDocument_Processed]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spUpdateInvuDocument_Processed]
	@id int
	,@invuId int
AS
BEGIN

SET NOCOUNT ON;

UPDATE tblInvuDocuments
   SET
		processed = 1,
		invuId = @invuId
 WHERE  id = @id
END
GO
/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE FUNCTION [dbo].[Split]
(
	@RowData nvarchar(MAX),
	@SplitOn nvarchar(5)
)  
RETURNS @RtnValue table 
(
	Id int identity(1,1),
	Data nvarchar(100)
) 
AS  
BEGIN 
	Declare @Cnt int
	Set @Cnt = 1

	While (Charindex(@SplitOn,@RowData)>0)
	Begin
		Insert Into @RtnValue (data)
		Select 
			Data = ltrim(rtrim(Substring(@RowData,1,Charindex(@SplitOn,@RowData)-1)))

		Set @RowData = Substring(@RowData,Charindex(@SplitOn,@RowData)+1,len(@RowData))
		Set @Cnt = @Cnt + 1
	End
	
	Insert Into @RtnValue (data)
	Select Data = ltrim(rtrim(@RowData))

	Return
END
GO
/****** Object:  UserDefinedFunction [dbo].[udfComputeDistance]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE FUNCTION [dbo].[udfComputeDistance]
(
  @lat1 float,
  @lon1 float,
  @lat2 float,
  @lon2 float
)
RETURNS float
AS
begin
  -- dLong represents the differences in longitudes
  -- while dLat is the difference in latitudes
  declare @dLong float
  declare @dLat float
  -- To keep the calculation easier to understand,
  -- we have simplified it by computing it by parts.
  -- This value temporarily holds the value of the
  -- first calculation.
  declare @temp float
  -- Convert the decimal degrees to radians
  set @lat2 = radians(@lat2)
  set @lon1 = radians(@lon1)
  set @lat1 = radians(@lat1)
  set @lon2 = radians(@lon2)
  -- Compute the degree differences
  set @dLong = @lon2 - @lon1
  set @dLat = @lat1 - @lat2
  -- Compute the first part of the equation
  set @temp = (square(sin(@dLat/2.0))) + cos(@lat2) * cos(@lat1) * (square(sin(@dLong/2.0)))
  -- Return the approximate distance in miles
  -- Note that 3956 is the approximate median radius of the Earth.
  return (2.0 * atn2(sqrt(@temp), sqrt(1.0-@temp)))*3956.0
end
GO
/****** Object:  UserDefinedFunction [dbo].[udfPreferredClinicDoctor]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE FUNCTION [dbo].[udfPreferredClinicDoctor]
(
  @clinicIsPreferred bit,
  @doctorIsPreferred bit
)
RETURNS varchar(13)
AS
begin
  declare @s varchar(13)     
  if ((@clinicIsPreferred = 1) and (@doctorIsPreferred = 1)) set @s = 'Clinic&Doctor'
  else begin
    if (@clinicIsPreferred = 1) set @s = 'Clinic'
    else begin
      if (@doctorIsPreferred = 1) set @s = 'Doctor'
      else set @s = ''
    end
  end
  return @s
end
GO
/****** Object:  Table [Appointment].[Appointment]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Appointment].[Appointment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CaseId] [int] NOT NULL,
	[ResourceId] [int] NULL,
	[ClinicId] [uniqueidentifier] NULL,
	[ClinicName] [varchar](200) NULL,
	[ClinicianId] [uniqueidentifier] NULL,
	[ClinicianName] [varchar](200) NULL,
	[IsFaceToFace] [bit] NOT NULL,
	[AppointmentDate] [datetime] NOT NULL,
	[AppointmentBookingDate] [datetime] NOT NULL,
	[AppointmentStatusId] [int] NOT NULL,
	[ElapsedTime] [int] NOT NULL,
	[AssessmentTypeId] [int] NOT NULL,
	[TravelTime] [int] NULL,
	[ReasonForChange] [varchar](200) NULL,
	[RescheduledDate] [datetime] NULL,
	[Actions] [varchar](max) NULL,
	[OutcomeId] [int] NULL,
 CONSTRAINT [PK_Appointment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Appointment].[AppointmentDocument]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Appointment].[AppointmentDocument](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AppointmentId] [int] NOT NULL,
	[Data] [varbinary](max) NULL,
	[Filename] [varchar](255) NOT NULL,
	[Size] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedByUser] [varchar](35) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedByUser] [varchar](35) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_AppointmentDocument] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Appointment].[AppointmentStatus]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Appointment].[AppointmentStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_AppointmentStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Appointment].[AppointmentType]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Appointment].[AppointmentType](
	[Id] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_AppointmentType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Assessment].[Answer]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Assessment].[Answer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AssessmentObstacleId] [int] NOT NULL,
	[QuestionTemplateId] [int] NOT NULL,
	[YesNoAnswer] [bit] NULL,
	[FreeTextAnswer] [varchar](200) NULL,
 CONSTRAINT [PK_AssessmentAnswer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Assessment].[AnswerLookup]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Assessment].[AnswerLookup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AnswerId] [int] NOT NULL,
	[LookupItemId] [int] NOT NULL,
 CONSTRAINT [PK_AnswerLookup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Assessment].[Assessment]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Assessment].[Assessment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VersionNumber] [int] NULL,
	[CaseId] [int] NOT NULL,
	[EmployeeConsent] [bit] NOT NULL,
	[DateOfAssessment] [datetime] NULL,
	[AssessmentTypeId] [int] NULL,
	[AdviceLineContacted] [bit] NULL,
	[IsPublished] [bit] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[FinishDate] [datetime] NULL,
	[AssessmentStatusId] [int] NULL,
	[PreAssessmentComplete] [bit] NOT NULL,
	[HealthAssessmentComplete] [bit] NOT NULL,
	[PsychAssessmentComplete] [bit] NOT NULL,
	[HomeAssessmentComplete] [bit] NOT NULL,
	[WorkAssessmentComplete] [bit] NOT NULL,
	[HealthQuestionnairesComplete] [bit] NOT NULL,
	[SuicideQuestionnaireComplete] [bit] NOT NULL,
	[CaseManagerResourceId] [int] NULL,
	[CaseManagerName] [varchar](100) NULL,
	[EQ5DCompleted] [bit] NULL,
	[EQ5DScore] [int] NULL,
	[IsClone] [bit] NOT NULL,
 CONSTRAINT [PK_Assessment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Assessment].[AssessmentObstacle]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Assessment].[AssessmentObstacle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AssessmentId] [int] NOT NULL,
	[ObstacleId] [int] NOT NULL,
 CONSTRAINT [PK_AssessmentObstacle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Assessment].[AssessmentObstacleRecomendation]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Assessment].[AssessmentObstacleRecomendation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AssessmentObstacleId] [int] NOT NULL,
	[RecomendationText] [varchar](500) NOT NULL,
	[RecomendationId] [int] NOT NULL,
 CONSTRAINT [PK_AssessmentObstacleRecomendation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Assessment].[AssessmentObstacleSignpost]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Assessment].[AssessmentObstacleSignpost](
	[AssessmentObstacleId] [int] NOT NULL,
	[SignpostId] [int] NOT NULL,
 CONSTRAINT [PK_AssessmentObstacleSignpost_1] PRIMARY KEY CLUSTERED 
(
	[AssessmentObstacleId] ASC,
	[SignpostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Assessment].[AssessmentQuestionnaire]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Assessment].[AssessmentQuestionnaire](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AssessmentId] [int] NULL,
	[QuestionnaireId] [int] NULL,
	[Score] [int] NULL,
 CONSTRAINT [PK_AssessmentQuestionnaire] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Assessment].[AssessmentQuestionnaireAnswer]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Assessment].[AssessmentQuestionnaireAnswer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AssessmentQuestionnaireId] [int] NULL,
	[QuestionnaireQuestionId] [int] NULL,
	[Score] [int] NULL,
 CONSTRAINT [PK_AssessmentQuestionnaireAnswer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Assessment].[AssessmentStatus]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Assessment].[AssessmentStatus](
	[Id] [int] NOT NULL,
	[Description] [varchar](50) NOT NULL,
 CONSTRAINT [PK_AssessmentStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Assessment].[FitStatus]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Assessment].[FitStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NOT NULL,
 CONSTRAINT [PK_FitStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Assessment].[Obstacle]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Assessment].[Obstacle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[ObstacleTypeId] [int] NOT NULL,
	[SectionId] [int] NOT NULL,
 CONSTRAINT [PK_Obstacle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Assessment].[ObstacleType]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Assessment].[ObstacleType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NOT NULL,
	[Description] [varchar](255) NOT NULL,
 CONSTRAINT [PK_ObstacleType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Assessment].[Questionnaire]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Assessment].[Questionnaire](
	[Id] [int] NOT NULL,
	[Name] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Questionnaire] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Assessment].[QuestionnaireAnswer]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Assessment].[QuestionnaireAnswer](
	[Id] [int] NOT NULL,
	[Score] [int] NOT NULL,
	[Text] [varchar](200) NULL,
 CONSTRAINT [PK_QuestionnaireAnswer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Assessment].[QuestionnaireQuestion]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Assessment].[QuestionnaireQuestion](
	[Id] [int] NOT NULL,
	[QuestionnaireId] [int] NOT NULL,
	[Text] [varchar](200) NOT NULL,
	[Guidance] [varchar](200) NULL,
	[OrderId] [int] NULL,
 CONSTRAINT [PK_QuestionnaireQuestion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Assessment].[QuestionnaireQuestionAnswer]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Assessment].[QuestionnaireQuestionAnswer](
	[Id] [int] NOT NULL,
	[QuestionnaireQuestionId] [int] NOT NULL,
	[QuestionnaireAnswerId] [int] NOT NULL,
 CONSTRAINT [PK_QuestionnaireQuestionAnswer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Assessment].[QuestionnaireTotalBand]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Assessment].[QuestionnaireTotalBand](
	[Id] [int] NOT NULL,
	[QuestionnaireId] [int] NOT NULL,
	[MinScore] [int] NULL,
	[MaxScore] [int] NULL,
	[Meaning] [varchar](500) NOT NULL,
 CONSTRAINT [PK_QuestionnaireTotalBand] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Assessment].[QuestionTemplate]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Assessment].[QuestionTemplate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[QuestionText] [varchar](250) NOT NULL,
	[QuestionGuidance] [varchar](500) NULL,
	[LookupId] [int] NULL,
	[HasFreetext] [bit] NOT NULL,
	[HasMultipleAnswers] [bit] NOT NULL,
	[HasYesNo] [bit] NOT NULL,
 CONSTRAINT [PK_AssessmentQuestion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Assessment].[Recommendation]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Assessment].[Recommendation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ObstacleId] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[RecommendationText] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Recommendation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Assessment].[ReturnToWorkObstacle]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Assessment].[ReturnToWorkObstacle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ObstacleId] [int] NULL,
	[ReturnToWorkPlanId] [int] NOT NULL,
	[RecommendationText] [nvarchar](1000) NULL,
	[SignpostText] [nvarchar](1000) NULL,
	[WorkplaceText] [nvarchar](1000) NULL,
	[EmployerConsent] [bit] NULL,
	[GPConsent] [bit] NULL,
	[ThirdPartyConsent] [bit] NULL,
	[RecommendationTargetDate] [datetime] NULL,
	[SignpostTargetDate] [datetime] NULL,
	[WorkplaceTargetDate] [datetime] NULL,
	[ExcludeSignpost] [bit] NULL,
	[ExcludeWorkplace] [bit] NULL,
 CONSTRAINT [PK_ReturnToWorkObstacle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Assessment].[ReturnToWorkOption]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Assessment].[ReturnToWorkOption](
	[Id] [int] NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ReturnToWorkOption] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Assessment].[ReturnToWorkPlan]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Assessment].[ReturnToWorkPlan](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AssessmentId] [int] NULL,
	[FitStatusId] [int] NULL,
	[ReturnToWorkOptionId] [int] NULL,
	[ReturnToWorkOptionInfo] [varchar](200) NULL,
	[RecommendedReturnDate] [date] NULL,
	[EmployeeFirst] [bit] NULL,
	[FactualInaccuracyDetail] [varchar](max) NULL,
	[TouchPointId] [int] NULL,
	[TouchPointDate] [datetime] NULL,
	[ValidFrom] [datetime] NULL,
	[ValidTo] [datetime] NULL,
	[OtherSignpostings] [varchar](200) NULL,
 CONSTRAINT [PK_ReturnToWorkPlan] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Assessment].[ReturnToWorkPlanIntervention]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Assessment].[ReturnToWorkPlanIntervention](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReturnToWorkPlanId] [int] NOT NULL,
	[InterventionId] [int] NOT NULL,
 CONSTRAINT [PK_ReturnToWorkPlanIntervention] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Assessment].[ReturnToWorkPlanSignposting]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Assessment].[ReturnToWorkPlanSignposting](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReturnToWorkPlanId] [int] NOT NULL,
	[SignpostingId] [int] NOT NULL,
 CONSTRAINT [PK_ReturnToWorkPlanSignposting] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Assessment].[Section]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Assessment].[Section](
	[Id] [int] NOT NULL,
	[Name] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Section] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Assessment].[SectionQuestion]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Assessment].[SectionQuestion](
	[Id] [int] NOT NULL,
	[AssessmentSectionId] [int] NOT NULL,
	[QuestionTemplateId] [int] NOT NULL,
	[OrderId] [int] NOT NULL,
 CONSTRAINT [PK_SectionQuestion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Assessment].[Signpost]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Assessment].[Signpost](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[ObstacleId] [int] NOT NULL,
	[SignpostText] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Signpost] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Assessment].[ViewCounter]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Assessment].[ViewCounter](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReturnToWorkPlanId] [int] NULL,
	[CaseNoteId] [int] NULL,
	[Token] [varchar](100) NOT NULL,
	[Pin] [varchar](4) NULL,
	[FailedAccessCount] [int] NOT NULL,
	[SuccessfulAccessCount] [int] NOT NULL,
	[UserTypeId] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[TokenExpiry] [datetime] NULL,
	[EmailSentTo] [varchar](200) NULL,
	[EmailSentDate] [datetime] NULL,
	[TypeId] [int] NOT NULL,
 CONSTRAINT [PK_ViewCounter] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Assessment].[WorkplaceAdjustment]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Assessment].[WorkplaceAdjustment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ObstacleId] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[WorkplaceAdjustmentText] [varchar](255) NOT NULL,
 CONSTRAINT [PK_WorkplaceAdjustment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Audit].[AuditAction]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Audit].[AuditAction](
	[ActionId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](10) NOT NULL,
 CONSTRAINT [PK_AuditAction] PRIMARY KEY CLUSTERED 
(
	[ActionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Audit].[AuditLog]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Audit].[AuditLog](
	[AuditId] [int] IDENTITY(1,1) NOT NULL,
	[AuditDate] [datetime] NOT NULL,
	[MachineName] [varchar](40) NULL,
	[UserName] [varchar](50) NULL,
	[ActionId] [int] NOT NULL,
	[EntityId] [varchar](25) NULL,
	[EntityName] [varchar](100) NOT NULL,
 CONSTRAINT [PK_AuditLog] PRIMARY KEY CLUSTERED 
(
	[AuditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Audit].[AuditProperty]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Audit].[AuditProperty](
	[AuditPropertyId] [int] IDENTITY(1,1) NOT NULL,
	[AuditId] [int] NOT NULL,
	[PropertyName] [varchar](30) NOT NULL,
	[PreviousValue] [varchar](700) NULL,
	[CurrentValue] [varchar](700) NULL,
 CONSTRAINT [PK_AuditProperty] PRIMARY KEY CLUSTERED 
(
	[AuditPropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Authentication].[NetworkDoctor]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Authentication].[NetworkDoctor](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserEmail] [nvarchar](56) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[UserEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Authentication].[webpages_Membership]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Authentication].[webpages_Membership](
	[UserId] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[ConfirmationToken] [nvarchar](128) NULL,
	[IsConfirmed] [bit] NULL,
	[LastPasswordFailureDate] [datetime] NULL,
	[PasswordFailuresSinceLastSuccess] [int] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordChangedDate] [datetime] NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[PasswordVerificationToken] [nvarchar](128) NULL,
	[PasswordVerificationTokenExpirationDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Authentication].[webpages_Roles]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Authentication].[webpages_Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Authentication].[webpages_UsersInRoles]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Authentication].[webpages_UsersInRoles](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Case].[Case]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Case].[Case](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReferralId] [int] NOT NULL,
	[CaseStatusId] [int] NULL,
	[CaseNumber] [varchar](50) NULL,
	[CreatedTimestamp] [datetime] NOT NULL,
	[ClientId] [int] NULL,
	[CaseManagerId] [int] NULL,
	[DischargeDate] [datetime] NULL,
	[CaseFamilyId] [uniqueidentifier] NOT NULL,
	[ClosedDate] [datetime] NULL,
	[DischargeReasonId] [int] NULL,
	[IsMarkedForDeletion] [bit] NOT NULL,
	[RecallDate] [datetime] NULL,
	[CaseAdminTeamId] [int] NULL,
 CONSTRAINT [PK_Case] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Case].[CaseCTATeam]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Case].[CaseCTATeam](
	[CaseId] [int] NOT NULL,
	[CTATeamId] [int] NOT NULL,
 CONSTRAINT [PK_CaseCTATeam] PRIMARY KEY CLUSTERED 
(
	[CaseId] ASC,
	[CTATeamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Case].[CaseFamily]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Case].[CaseFamily](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CaseFamilyId] [uniqueidentifier] NOT NULL,
	[CaseId] [int] NOT NULL,
	[CaseNumber] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CaseFamily] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Case].[CaseHPTeam]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Case].[CaseHPTeam](
	[CaseId] [int] NOT NULL,
	[HPTeamId] [int] NOT NULL,
 CONSTRAINT [PK_CaseHPTeam] PRIMARY KEY CLUSTERED 
(
	[CaseId] ASC,
	[HPTeamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Case].[CaseNote]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Case].[CaseNote](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CaseId] [int] NOT NULL,
	[CaseNoteTypeId] [int] NOT NULL,
	[Comment] [varchar](512) NULL,
	[FilePath] [varchar](512) NULL,
	[IsClinical] [bit] NOT NULL,
	[InvuId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[FileTypeId] [int] NULL,
	[DocumentTypeId] [int] NULL,
	[IsPinned] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](60) NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](60) NULL,
 CONSTRAINT [PK_CaseNote] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Case].[CaseNotesFileType]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Case].[CaseNotesFileType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NOT NULL,
 CONSTRAINT [PK_CaseNotesFileType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Case].[CaseNoteType]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Case].[CaseNoteType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NOT NULL,
 CONSTRAINT [PK_CaseNoteType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Case].[CaseStatus]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Case].[CaseStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[IsInternalState] [bit] NOT NULL,
	[IsAdminTask] [bit] NOT NULL,
 CONSTRAINT [PK_CaseStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Case].[CaseStatusHistory]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Case].[CaseStatusHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CaseId] [int] NOT NULL,
	[CaseStatusId] [int] NOT NULL,
	[EffectiveFrom] [datetime] NOT NULL,
	[EffectiveTo] [datetime] NULL,
 CONSTRAINT [PK_CaseStatusHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Clinic].[Clinic]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Clinic].[Clinic](
	[ClinicId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](60) NOT NULL,
	[Address] [nvarchar](255) NULL,
	[PostCode] [varchar](10) NULL,
	[CountryCode] [char](2) NULL,
	[Fax] [varchar](50) NULL,
	[Contact1] [nvarchar](70) NULL,
	[Contact1Email] [varchar](70) NULL,
	[Contact1Mobile] [varchar](50) NULL,
	[Contact1Tel] [varchar](50) NULL,
	[Contact2] [nvarchar](70) NULL,
	[Contact2Email] [varchar](60) NULL,
	[Contact2Tel] [varchar](50) NULL,
	[Contact2Mobile] [varchar](50) NULL,
	[Email] [nvarchar](60) NULL,
	[Switchboard] [varchar](20) NULL,
	[ClinicLat] [float] NULL,
	[ClinicLong] [float] NULL,
	[URLDirections] [varchar](500) NULL,
	[URLWebSite] [varchar](500) NULL,
	[Active] [bit] NOT NULL,
	[Comments] [varchar](512) NULL,
	[UseForPaperWork] [bit] NULL,
	[Fee] [money] NULL,
	[FeeDNA] [money] NULL,
	[FeeCanx] [money] NULL,
	[VAT] [bit] NULL,
	[AdminOnly] [bit] NOT NULL,
	[Specialist] [bit] NOT NULL,
	[OH] [bit] NOT NULL,
	[Preferred] [bit] NOT NULL,
	[Chase] [bit] NOT NULL,
	[BookNow] [bit] NOT NULL,
	[HML] [bit] NOT NULL,
	[Onsite] [bit] NOT NULL,
	[UpdatedBy] [varchar](30) NULL,
	[Updated] [datetime] NULL,
	[CreatedBy] [varchar](30) NOT NULL,
	[Created] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ClinicId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Clinic].[Clinic_Clinician]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Clinic].[Clinic_Clinician](
	[Clinic_ClinicianId] [int] IDENTITY(1,1) NOT NULL,
	[ClinicId] [int] NULL,
	[ClinicianId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Clinic_ClinicianId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Clinic].[Clinic_Specialisation]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Clinic].[Clinic_Specialisation](
	[Clinic_SpecialisationId] [int] IDENTITY(1,1) NOT NULL,
	[ClinicId] [int] NULL,
	[SpecialisationId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Clinic_SpecialisationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Clinic].[Clinician]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Clinic].[Clinician](
	[ClinicianId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](10) NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Mobile] [varchar](20) NULL,
	[TelWork] [varchar](20) NULL,
	[TelWork2] [varchar](20) NULL,
	[TelHome] [varchar](20) NULL,
	[Email] [varchar](80) NULL,
	[Enabled] [bit] NULL,
	[Active] [bit] NOT NULL,
	[OHP] [bit] NOT NULL,
	[Preferred] [bit] NOT NULL,
	[Chase] [bit] NOT NULL,
	[BookNow] [bit] NOT NULL,
	[OHA] [bit] NULL,
	[HML] [bit] NULL,
	[Specialist] [bit] NOT NULL,
	[NetOHPType] [varchar](20) NULL,
	[Class] [varchar](10) NULL,
	[PIRenewal] [datetime] NULL,
	[GMCRenewal] [datetime] NULL,
	[DefaultFee] [money] NULL,
	[DefaultFeeDNA] [money] NULL,
	[DefaultFeeCanx] [money] NULL,
	[Comments] [varchar](1024) NULL,
	[UpdatedBy] [varchar](30) NULL,
	[Updated] [datetime] NULL,
	[CreatedBy] [varchar](30) NOT NULL,
	[Created] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ClinicianId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Clinic].[Clinician_Specialisation]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Clinic].[Clinician_Specialisation](
	[Clinician_SpecialisationId] [int] IDENTITY(1,1) NOT NULL,
	[ClinicianId] [int] NULL,
	[SpecialisationId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Clinician_SpecialisationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Clinic].[Specialisation]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Clinic].[Specialisation](
	[SpecialisationId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[ShortDesc] [varchar](10) NOT NULL,
	[Active] [bit] NOT NULL,
	[UpdatedBy] [varchar](30) NULL,
	[Updated] [datetime] NULL,
	[CreatedBy] [varchar](30) NOT NULL,
	[Created] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SpecialisationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Complaint].[Complaint]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Complaint].[Complaint](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Reference] [varchar](20) NOT NULL,
	[Title] [varchar](20) NOT NULL,
	[FirstName] [varchar](35) NOT NULL,
	[LastName] [varchar](35) NOT NULL,
	[Role] [varchar](20) NULL,
	[TelephoneNumber] [varchar](20) NULL,
	[EmailAddress] [varchar](50) NULL,
	[AddressData] [varchar](200) NULL,
	[Postcode] [varchar](10) NULL,
	[GeoData] [geography] NULL,
	[Category] [varchar](20) NULL,
	[Origin] [varchar](20) NOT NULL,
	[Status] [varchar](20) NOT NULL,
	[Details] [varchar](max) NOT NULL,
	[CaseText] [varchar](200) NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedByUser] [varchar](71) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedByUser] [varchar](71) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[LanguagePreference] [varchar](2) NOT NULL,
	[CommsPreference] [varchar](10) NOT NULL,
	[IsEscalated] [bit] NOT NULL,
	[EscalationDestination] [varchar](200) NULL,
	[OwnedByUser] [varchar](71) NULL,
	[AcknowledgementSentDate] [datetime] NULL,
	[AcknowledgementSentChannel] [varchar](20) NULL,
	[ComplaintScope] [varchar](20) NULL,
	[ComplaintRelatesTo] [varchar](20) NULL,
	[ReceivedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Complaint] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Complaint].[ComplaintAction]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Complaint].[ComplaintAction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ComplaintId] [int] NOT NULL,
	[Category] [varchar](50) NOT NULL,
	[Details] [varchar](max) NOT NULL,
	[FollowUpDate] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedByUser] [varchar](35) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedByUser] [varchar](35) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ComplaintAction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Complaint].[ComplaintCase]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Complaint].[ComplaintCase](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ComplaintId] [int] NOT NULL,
	[CaseId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedByUser] [varchar](35) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedByUser] [varchar](35) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ComplaintCase] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Complaint].[ComplaintDocument]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Complaint].[ComplaintDocument](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ComplaintId] [int] NOT NULL,
	[Data] [varbinary](max) NULL,
	[Filename] [varchar](255) NOT NULL,
	[Description] [varchar](255) NOT NULL,
	[Size] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedByUser] [varchar](35) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedByUser] [varchar](35) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[Category] [varchar](100) NOT NULL,
 CONSTRAINT [PK_ComplaintDocument] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Complaint].[ComplaintNote]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Complaint].[ComplaintNote](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ComplaintId] [int] NOT NULL,
	[Details] [varchar](max) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Priority] [int] NOT NULL,
	[CreatedByUser] [varchar](35) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedByUser] [varchar](35) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ComplaintNote] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AuditLog]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AuditLog](
	[AuditLogId] [uniqueidentifier] NOT NULL,
	[ActionId] [uniqueidentifier] NOT NULL,
	[UserId] [int] NOT NULL,
	[EventDate] [datetime] NOT NULL,
	[EventType] [char](1) NOT NULL,
	[TableName] [nvarchar](100) NOT NULL,
	[RecordId] [nvarchar](100) NULL,
	[ColumnName] [nvarchar](100) NULL,
	[OriginalValue] [nvarchar](max) NULL,
	[NewValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AuditLog] PRIMARY KEY NONCLUSTERED 
(
	[AuditLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblBookmarks]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBookmarks](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[bookmarkName] [nvarchar](255) NOT NULL,
	[propertyName] [nvarchar](255) NULL,
	[reflectedType] [nvarchar](255) NULL,
	[isCSF] [bit] NOT NULL,
	[Format] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblButtonGroups]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblButtonGroups](
	[uidButtonGroup] [uniqueidentifier] NOT NULL,
	[strName] [varchar](50) NOT NULL,
	[strControlName] [varchar](30) NOT NULL,
	[strModBy] [char](30) NOT NULL,
	[dtmMod] [datetime] NOT NULL,
	[dtmCreated] [datetime] NOT NULL,
	[strCreatedBy] [varchar](30) NOT NULL,
	[intTemplateType] [tinyint] NULL,
 CONSTRAINT [PK_tblButtonGroups] PRIMARY KEY CLUSTERED 
(
	[uidButtonGroup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
 CONSTRAINT [IX_tblButtonGroups] UNIQUE NONCLUSTERED 
(
	[strControlName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblClinic2OHP]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblClinic2OHP](
	[fkClinic] [uniqueidentifier] NOT NULL,
	[fkNetworkOHP] [uniqueidentifier] NOT NULL,
	[strCreatedBy] [varchar](30) NULL,
	[dtmCreated] [datetime] NOT NULL,
	[isDeleted] [bit] NULL,
	[dtmMod] [datetime] NOT NULL,
	[fkAdminCentre] [uniqueidentifier] NULL,
	[strModBy] [varchar](30) NOT NULL,
	[ccyFee] [money] NULL,
	[ccyFeeDNA] [money] NULL,
	[isVAT] [bit] NULL,
	[strComment] [varchar](512) NULL,
	[ccyFeeCanx] [money] NULL,
 CONSTRAINT [PK_clinic2OHP] PRIMARY KEY NONCLUSTERED 
(
	[fkClinic] ASC,
	[fkNetworkOHP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblClinic2Specialisation]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblClinic2Specialisation](
	[fkClinic] [uniqueidentifier] NOT NULL,
	[fkSpecialisation] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tblClinic2Specialisation] PRIMARY KEY CLUSTERED 
(
	[fkClinic] ASC,
	[fkSpecialisation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblClinician2Specialisation]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblClinician2Specialisation](
	[fkNetworkOHP] [uniqueidentifier] NOT NULL,
	[fkSpecialisation] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tblClinician2Specialisation] PRIMARY KEY CLUSTERED 
(
	[fkNetworkOHP] ASC,
	[fkSpecialisation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblCountries]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCountries](
	[PKCountryCode] [char](2) NOT NULL,
	[strLongName] [char](30) NULL,
	[isEnabled] [bit] NOT NULL,
	[dtmMod] [datetime] NOT NULL,
	[dtmCreated] [datetime] NOT NULL,
	[strCreatedBy] [varchar](30) NOT NULL,
	[strModBy] [varchar](30) NOT NULL,
 CONSTRAINT [PK__tblCountries__1367E606] PRIMARY KEY CLUSTERED 
(
	[PKCountryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDocumentCategories]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblDocumentCategories](
	[ID] [uniqueidentifier] NOT NULL,
	[CategoryName] [varchar](100) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[dtmCreated] [datetime] NOT NULL,
	[dtmMod] [datetime] NOT NULL,
	[strCreatedBy] [varchar](100) NOT NULL,
	[strModBy] [varchar](100) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDr2Specialisation]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDr2Specialisation](
	[fkSpecialisation] [uniqueidentifier] NOT NULL,
	[fkOHP] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tblDr2Specialisation] PRIMARY KEY CLUSTERED 
(
	[fkSpecialisation] ASC,
	[fkOHP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblGlobalVars]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblGlobalVars](
	[uidGlobalVars] [uniqueidentifier] NOT NULL,
	[flVAT] [float] NULL,
	[dtmCreated] [datetime] NULL,
	[strCreatedBy] [varchar](30) NULL,
	[isCurrent] [bit] NULL,
	[dtmMod] [datetime] NOT NULL,
	[strModBy] [varchar](30) NOT NULL,
	[intFMEInformClientChase] [int] NOT NULL,
	[strOutPutFolder] [varchar](255) NULL,
	[intMonthsConsentFormActive] [int] NULL,
	[strOverridePwd] [char](32) NOT NULL,
	[intCheckContractDays] [bit] NOT NULL,
	[strAccountsEmail] [varchar](100) NULL,
	[strWipitEmail] [varchar](100) NULL,
	[HMLOnlineEmailTemplates] [varchar](max) NULL,
	[HMLOnlineScannedDocsFolder] [varchar](max) NULL,
	[OnlineUserEmailAddress] [varchar](50) NULL,
	[OnlineUserPassword] [varchar](50) NULL,
	[OnlineUserNTUsername] [varchar](50) NULL,
	[DefaultQuestionnaireClinicianTriageTeamId] [uniqueidentifier] NULL,
	[DefaultReferralClinicianTriageTeamId] [uniqueidentifier] NULL,
	[DefaultClipStartDate] [datetime] NULL,
	[CertificateStoreFolder] [varchar](100) NULL,
	[RootHMLOnlineFolder] [varchar](max) NULL,
	[CurrentVersion] [varchar](max) NULL,
	[HMLOnlineOverridePwd] [varchar](max) NULL,
	[SMSAlertPriorToAppointmentHours] [int] NULL,
	[ITInformedOfError] [bit] NULL,
	[ScannedPaperFormRoot] [varchar](255) NULL,
	[DefaultAutoScreenSignatory] [varchar](255) NULL,
	[DefaultHRAdviceViewableDays] [tinyint] NULL,
	[DocumentTemplateRoot] [varchar](255) NULL,
	[LastFinanceAuditEmailSent] [datetime] NULL,
 CONSTRAINT [PK__tblGlobalVars__060DEAE8] PRIMARY KEY CLUSTERED 
(
	[uidGlobalVars] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblInvuDocuments]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblInvuDocuments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[invuDocument] [varchar](max) NOT NULL,
	[createdBy] [varchar](30) NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[processed] [bit] NOT NULL,
	[invuId] [int] NULL,
	[docAssembly] [nvarchar](255) NOT NULL,
	[docBaseTypeFullName] [nvarchar](255) NOT NULL,
	[docTypeFullName] [nvarchar](255) NOT NULL,
	[failed] [bit] NOT NULL,
	[docPath] [nvarchar](510) NULL,
	[caseId] [int] NOT NULL,
	[caseNoteId] [int] NOT NULL,
 CONSTRAINT [PK_tblInvuDocuments] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblInvuDocumentTypes]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblInvuDocumentTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FullyQualifiedTypeName] [nvarchar](256) NOT NULL,
	[DisplayName] [nvarchar](256) NOT NULL,
	[IsClinical] [bit] NOT NULL,
 CONSTRAINT [PK_tblInvuDocumentTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblInvuIndexExceptions]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblInvuIndexExceptions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[invuDocumentId] [int] NOT NULL,
	[exception] [nvarchar](max) NOT NULL,
	[caseId] [int] NOT NULL,
	[caseNoteId] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tblInvuIndexExceptions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblNetworkOHPs]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblNetworkOHPs](
	[uidNetworkOHP] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[strTitle] [varchar](10) NULL,
	[strFirstName] [nvarchar](50) NULL,
	[strLastName] [nvarchar](50) NOT NULL,
	[strMobile] [varchar](20) NULL,
	[strTelWork] [varchar](20) NULL,
	[strTelHome] [varchar](20) NULL,
	[strEmail] [varchar](80) NULL,
	[isEnabled] [bit] NULL,
	[strModBy] [varchar](30) NOT NULL,
	[dtmMod] [datetime] NOT NULL,
	[strCreatedBy] [varchar](30) NOT NULL,
	[dtmCreated] [datetime] NOT NULL,
	[ccyDefaultFee] [money] NULL,
	[isActive] [bit] NOT NULL,
	[strComments] [varchar](1024) NULL,
	[strNetOHPType] [varchar](20) NULL,
	[strClass] [varchar](10) NULL,
	[ccyDefaultFeeDNA] [money] NULL,
	[isSpecialist] [bit] NOT NULL,
	[isOHP] [bit] NOT NULL,
	[ccyDefaultFeeCanx] [money] NULL,
	[fkOHQualification] [uniqueidentifier] NULL,
	[strTelWork2] [varchar](20) NULL,
	[isPreferred] [bit] NOT NULL,
	[isChase] [bit] NOT NULL,
	[isBookNow] [bit] NOT NULL,
	[dtmPIRenewal] [datetime] NULL,
	[dtmGMCRenewal] [datetime] NULL,
	[isOHA] [bit] NULL,
	[isHML] [bit] NULL,
	[ResourceId] [int] NULL,
	[NetworkDoctorId] [int] NULL,
 CONSTRAINT [PK_NetworkOHPs] PRIMARY KEY NONCLUSTERED 
(
	[uidNetworkOHP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblOHPClinics]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblOHPClinics](
	[uidClinic] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[strPostCode] [varchar](10) NULL,
	[strAddress] [nvarchar](255) NULL,
	[strContact1] [nvarchar](70) NULL,
	[strContact1Email] [varchar](70) NULL,
	[strContact1Tel] [varchar](50) NULL,
	[strContact2] [nvarchar](70) NULL,
	[strContact2Email] [varchar](60) NULL,
	[strContact2Tel] [varchar](50) NULL,
	[strEmail] [nvarchar](60) NULL,
	[strSwitchboard] [varchar](20) NULL,
	[strCountry] [char](2) NULL,
	[strModBy] [varchar](30) NULL,
	[dtmMod] [datetime] NOT NULL,
	[strCreatedBy] [varchar](30) NULL,
	[dtmCreated] [datetime] NOT NULL,
	[strName] [varchar](60) NOT NULL,
	[isActive] [bit] NOT NULL,
	[strComments] [varchar](512) NULL,
	[fkAdminCentre] [uniqueidentifier] NULL,
	[flClinicLat] [float] NULL,
	[flClinicLong] [float] NULL,
	[isUseForPaperWork] [bit] NULL,
	[strContact1Mobile] [varchar](50) NULL,
	[strContact2Mobile] [varchar](50) NULL,
	[ccyFee] [money] NULL,
	[ccyFeeDNA] [money] NULL,
	[isVAT] [bit] NULL,
	[strFax] [varchar](50) NULL,
	[strURLDirections] [varchar](500) NULL,
	[strURLWebSite] [varchar](500) NULL,
	[isAdminOnly] [bit] NOT NULL,
	[isSpecialist] [bit] NOT NULL,
	[isOH] [bit] NOT NULL,
	[ccyFeeCanx] [money] NULL,
	[isPreferred] [bit] NOT NULL,
	[isChase] [bit] NOT NULL,
	[isBookNow] [bit] NOT NULL,
	[isHML] [bit] NOT NULL,
	[isOnsite] [bit] NOT NULL,
 CONSTRAINT [PK_OHPClinics] PRIMARY KEY NONCLUSTERED 
(
	[uidClinic] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblOHQualifications]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblOHQualifications](
	[uidOHQualification] [uniqueidentifier] NOT NULL,
	[strName] [varchar](20) NOT NULL,
	[strModBy] [varchar](30) NOT NULL,
	[dtmMod] [datetime] NOT NULL,
	[strCreatedBy] [varchar](30) NOT NULL,
	[dtmCreated] [datetime] NOT NULL,
	[intDisplayOrder] [int] NULL,
 CONSTRAINT [PK_tblOHQualifications] PRIMARY KEY CLUSTERED 
(
	[uidOHQualification] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblScannedDocumentTypes]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblScannedDocumentTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[IsClinical] [bit] NOT NULL,
	[FkInvuDocType] [int] NOT NULL,
 CONSTRAINT [PK_tblScannedDocumentTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblSpecialisations]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblSpecialisations](
	[uidSpecialisation] [uniqueidentifier] NOT NULL,
	[strName] [varchar](50) NOT NULL,
	[strModBy] [varchar](30) NOT NULL,
	[dtmMod] [datetime] NOT NULL,
	[strCreatedBy] [varchar](30) NOT NULL,
	[dtmCreated] [datetime] NOT NULL,
	[strShortDesc] [varchar](10) NOT NULL,
	[intOrder] [int] NOT NULL,
	[isActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblSpecialisations] PRIMARY KEY CLUSTERED 
(
	[uidSpecialisation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
 CONSTRAINT [IX_tblSpecialisations_UniqueName] UNIQUE NONCLUSTERED 
(
	[strName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTemplateButtons]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTemplateButtons](
	[uidTemplateButton] [uniqueidentifier] NOT NULL,
	[fkButtonGroup] [uniqueidentifier] NOT NULL,
	[strName] [varchar](50) NOT NULL,
	[fkTemplate] [uniqueidentifier] NOT NULL,
	[strModBy] [char](30) NOT NULL,
	[dtmMod] [datetime] NOT NULL,
	[dtmCreated] [datetime] NOT NULL,
	[strCreatedBy] [varchar](30) NOT NULL,
	[isDateCert] [bit] NOT NULL,
	[EmailSubject] [nvarchar](255) NULL,
 CONSTRAINT [PK_tblTemplateButtons] PRIMARY KEY CLUSTERED 
(
	[uidTemplateButton] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTemplates]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTemplates](
	[uidTemplate] [uniqueidentifier] NOT NULL,
	[strName] [varchar](255) NOT NULL,
	[strURL] [varchar](500) NULL,
	[strModBy] [char](30) NOT NULL,
	[dtmMod] [datetime] NOT NULL,
	[dtmCreated] [datetime] NOT NULL,
	[strCreatedBy] [varchar](30) NOT NULL,
	[isEmail] [bit] NULL,
	[fkInvuDocType] [int] NULL,
	[CategoryID] [uniqueidentifier] NULL,
	[NotForHR] [bit] NULL,
	[IntendedAudience] [tinyint] NULL,
 CONSTRAINT [PK_tblReportTemplates] PRIMARY KEY CLUSTERED 
(
	[uidTemplate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [INVU].[DocumentType]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [INVU].[DocumentType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FullyQualifiedTypeName] [varchar](256) NOT NULL,
	[DisplayName] [varchar](256) NOT NULL,
	[IsClinical] [bit] NOT NULL,
 CONSTRAINT [PK_tblInvuDocumentTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Logging].[ErrorLog]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Logging].[ErrorLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MachineName] [varchar](50) NULL,
	[Application] [varchar](50) NULL,
	[Source] [varchar](50) NULL,
	[UserName] [varchar](50) NULL,
	[Message] [varchar](500) NULL,
	[StackTrace] [varchar](max) NULL,
	[UTCTimestamp] [datetime2](7) NOT NULL,
	[SessionId] [varchar](50) NULL,
	[IPAddress] [varchar](45) NULL,
 CONSTRAINT [PK_ErrorLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Lookup].[DiagnosticCode]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Lookup].[DiagnosticCode](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CodeNumber] [varchar](5) NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[IsEnabled] [bit] NOT NULL,
 CONSTRAINT [PK_DiagnosticCode] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Lookup].[DischargeReason]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Lookup].[DischargeReason](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](100) NOT NULL,
 CONSTRAINT [PK_DischargeReason] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Lookup].[HardOfHearingPreferrences]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Lookup].[HardOfHearingPreferrences](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](50) NOT NULL,
 CONSTRAINT [PK_HardOfHearingPreferrences] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Lookup].[Lookup]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Lookup].[Lookup](
	[Id] [int] NOT NULL,
	[LookupName] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Lookup.Lookup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Lookup].[LookupItem]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Lookup].[LookupItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LookupId] [int] NOT NULL,
	[Value] [varchar](500) NOT NULL,
	[ParentId] [int] NULL,
	[OrderId] [int] NOT NULL,
	[Enabled] [bit] NULL,
 CONSTRAINT [PK_Lookup.LookupItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Referral].[Employee]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Referral].[Employee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](20) NOT NULL,
	[FirstName] [varchar](35) NOT NULL,
	[LastName] [varchar](35) NOT NULL,
	[Gender] [char](1) NULL,
	[DateOfBirth] [date] NULL,
	[JobTitle] [varchar](100) NULL,
	[JobActivities] [varchar](100) NULL,
	[WorkingPatterns] [varchar](100) NULL,
	[TelephoneNumber] [varchar](20) NULL,
	[MobileNumber] [varchar](20) NULL,
	[EmailAddress] [varchar](100) NULL,
	[HardOfHearingPreference] [varchar](50) NULL,
	[LanguagePreference] [char](2) NULL,
	[TranslationRequired] [nvarchar](50) NULL,
	[AddressData] [varchar](200) NULL,
	[Postcode] [varchar](10) NULL,
	[CommsPref] [varchar](50) NULL,
	[ReceiveSMS] [bit] NOT NULL,
	[ReceiveEmail] [bit] NOT NULL,
	[Latitude] [float] NULL,
	[Longitude] [float] NULL,
	[EthnicityId] [int] NULL,
	[EthnicityDescription] [varchar](50) NULL,
	[WorkHoursId] [int] NULL,
	[NumberOfHoursId] [int] NULL,
	[HasDisability] [bit] NULL,
	[DisabilityDetail] [varchar](200) NULL,
	[AdditionalSupport] [varchar](200) NULL,
	[HasDisabilityId] [int] NULL,
	[Transport] [varchar](100) NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Referral].[EmployeeDisability]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Referral].[EmployeeDisability](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[DisabilityId] [int] NOT NULL,
 CONSTRAINT [PK_EmployeeDisability] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Referral].[Employer]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Referral].[Employer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](20) NULL,
	[FirstName] [varchar](40) NULL,
	[LastName] [varchar](50) NULL,
	[TelephoneNumber] [varchar](20) NULL,
	[MobileNumber] [varchar](20) NULL,
	[EmailAddress] [varchar](100) NULL,
	[EmployerIdentifier] [varchar](35) NULL,
	[EmployerName] [varchar](100) NULL,
	[JobTitle] [varchar](100) NULL,
	[AddressData] [varchar](200) NULL,
	[Postcode] [varchar](10) NULL,
	[HardOfHearingPreference] [varchar](50) NULL,
	[LanguagePreference] [varchar](10) NULL,
	[CommsPref] [varchar](50) NULL,
	[OHQuestions] [nvarchar](512) NULL,
	[Latitude] [float] NULL,
	[Longitude] [float] NULL,
	[IndustrySectorId] [int] NULL,
	[EmployerSizeId] [int] NULL,
	[Passcode] [varchar](6) NULL,
	[EmployerTypeId] [int] NULL,
	[HasOccupationalHealth] [bit] NULL,
	[UseOccupationalHealth] [bit] NULL,
	[ServicesSupport] [varchar](200) NULL,
 CONSTRAINT [PK_Employer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Referral].[EmployerService]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Referral].[EmployerService](
	[EmployerId] [int] NOT NULL,
	[ServiceId] [int] NOT NULL,
 CONSTRAINT [PK_EmployerService] PRIMARY KEY CLUSTERED 
(
	[EmployerId] ASC,
	[ServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Referral].[GeneralPractitioner]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Referral].[GeneralPractitioner](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](20) NULL,
	[FirstName] [varchar](40) NULL,
	[LastName] [varchar](50) NULL,
	[TelephoneNumber] [varchar](20) NULL,
	[MobileNumber] [varchar](20) NULL,
	[EmailAddress] [varchar](100) NULL,
	[GPPracticeIdentifier] [varchar](20) NULL,
	[PracticeName] [varchar](100) NULL,
	[AddressData] [varchar](200) NULL,
	[Postcode] [varchar](10) NULL,
	[HardOfHearingPreference] [varchar](50) NULL,
	[LanguagePreference] [varchar](10) NULL,
	[CommsPref] [varchar](50) NULL,
	[Latitude] [float] NULL,
	[Longitude] [float] NULL,
	[DateOfBirth] [date] NULL,
	[GMCNumber] [varchar](20) NULL,
	[Passcode] [varchar](6) NULL,
 CONSTRAINT [PK_GeneralPractitioner] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Referral].[Referral]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Referral].[Referral](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[GeneralPracticionerId] [int] NOT NULL,
	[EmployerId] [int] NOT NULL,
	[IsConsentGivenByEmployeeToRefer] [bit] NOT NULL,
	[ReceivedTimestamp] [datetime] NULL,
	[DiagnosisFromFitNote] [varchar](500) NULL,
	[FitNoteEndDate] [date] NULL,
	[ReferralId] [varchar](20) NULL,
	[ReferralSourceId] [int] NULL,
	[ReferralEligibilityId] [int] NOT NULL,
	[CreatedByUser] [varchar](50) NULL,
	[ReasonForReferral] [varchar](512) NULL,
	[AbsenceStartDate] [date] NULL,
	[MainHealthCondition] [varchar](20) NULL,
	[FurtherInfo] [varchar](500) NULL,
	[ReferrerType] [nvarchar](2) NOT NULL,
	[ReturnToWorkDate] [datetime] NULL,
	[IsReceivingFitNote] [bit] NULL,
	[NoFitNoteReason] [varchar](200) NULL,
 CONSTRAINT [PK_Referral] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Referral].[ReferralEligibility]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Referral].[ReferralEligibility](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SessionId] [varchar](50) NOT NULL,
	[IpAddress] [varchar](16) NOT NULL,
	[IsGeographicallyEligible] [bit] NULL,
	[IsInPaidEmployment] [bit] NULL,
	[IsAbsentFromWork] [bit] NULL,
	[IsReferredInLast12Months] [bit] NULL,
	[HasEmployeeConsentedToReferral] [bit] NULL,
	[IsValid] [bit] NULL,
 CONSTRAINT [PK_ReferralEligibility] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Resources].[Client]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Resources].[Client](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[ShortCode] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Resources].[CTATeam]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Resources].[CTATeam](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[IsDefaultTeam] [bit] NULL,
	[IsHP] [bit] NULL,
	[ShortName] [varchar](3) NULL,
 CONSTRAINT [PK_CTATeam] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Resources].[Resource]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Resources].[Resource](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountName] [varchar](100) NOT NULL,
	[AgentId] [varchar](30) NOT NULL,
	[IsHP] [bit] NOT NULL,
	[CTATeamId] [int] NULL,
	[QASampleRate] [decimal](3, 2) NULL,
 CONSTRAINT [PK_CTAResource] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Resources].[ResourceSkill]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Resources].[ResourceSkill](
	[ResourceId] [int] NOT NULL,
	[SkillId] [int] NOT NULL,
 CONSTRAINT [PK_ResourceSkill] PRIMARY KEY CLUSTERED 
(
	[ResourceId] ASC,
	[SkillId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Resources].[Skill]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Resources].[Skill](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NOT NULL,
	[IsClinical] [bit] NOT NULL,
 CONSTRAINT [PK_Skill] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Template].[GenericTemplate]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Template].[GenericTemplate](
	[Id] [int] NOT NULL,
	[Description] [nvarchar](800) NULL,
 CONSTRAINT [PK_GenericTemplate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Template].[GenericTemplateText]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Template].[GenericTemplateText](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GenericTemplateId] [int] NOT NULL,
	[LanguageCultureCode] [nvarchar](10) NOT NULL,
	[TitleText] [nvarchar](800) NULL,
	[Content] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_GenericTemplateText] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [Template].[SMSTemplate]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Template].[SMSTemplate](
	[TemplateId] [int] IDENTITY(1,1) NOT NULL,
	[TemplateType] [nvarchar](50) NOT NULL,
	[Language] [nvarchar](20) NOT NULL,
	[Content] [ntext] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateModififed] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TemplateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  View [dbo].[vwClinic2OHPDetail]    Script Date: 12/01/2015 09:16:47 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE VIEW [dbo].[vwClinic2OHPDetail]
AS
SELECT     dbo.tblClinic2OHP.strComment AS ClinicComment, RTRIM(dbo.tblNetworkOHPs.strTitle) + ' ' + RTRIM(dbo.tblNetworkOHPs.strFirstName) 
                      + ' ' + RTRIM(dbo.tblNetworkOHPs.strLastName) AS Clinician, dbo.tblNetworkOHPs.strMobile AS drMobile, dbo.tblNetworkOHPs.strTelWork AS drTelWork, 
                      dbo.tblNetworkOHPs.strTelHome AS drTelHome, dbo.tblNetworkOHPs.strEmail AS drEmail, dbo.tblNetworkOHPs.ccyDefaultFee AS drDefaultFee, 
                      dbo.tblNetworkOHPs.ccyDefaultFeeDNA AS drDefaultFeeDNA, dbo.tblOHQualifications.strName AS drQualifications, dbo.tblNetworkOHPs.strComments AS drComments,
                       dbo.tblNetworkOHPs.strNetOHPType AS drNetOHPType, dbo.tblNetworkOHPs.strClass AS drClass, dbo.tblNetworkOHPs.ResourceId as HMLResourceId, dbo.tblOHPClinics.strName AS Clinic, 
                      dbo.tblOHPClinics.strPostCode AS ClinicPostCode, dbo.tblOHPClinics.strAddress AS ClinicAddress, dbo.tblOHPClinics.strCountry AS ClinicCountry, 
                      dbo.tblOHPClinics.strContact1, dbo.tblOHPClinics.strContact1Email, dbo.tblOHPClinics.strContact1Tel, dbo.tblOHPClinics.strContact2, 
                      dbo.tblOHPClinics.strContact2Email, dbo.tblOHPClinics.strContact2Tel, dbo.tblOHPClinics.strEmail AS ClinicEmail, 
                      dbo.tblOHPClinics.strSwitchboard AS ClinicSwitchboard, dbo.tblOHPClinics.strComments AS ClinicComments, dbo.tblOHPClinics.strFax AS ClinicFax, 
                      dbo.tblOHPClinics.strURLDirections, dbo.tblOHPClinics.flClinicLat, dbo.tblOHPClinics.flClinicLong, dbo.tblOHPClinics.strContact1Mobile, 
                      dbo.tblOHPClinics.strContact2Mobile, dbo.tblClinic2OHP.ccyFee, dbo.tblClinic2OHP.ccyFeeDNA, dbo.tblClinic2OHP.isVAT, 
                      CASE WHEN dbo.tblClinic2OHP.fkAdminCentre IS NOT NULL THEN tblOHPAdminCentre.strName WHEN dbo.tblOHPClinics.fkAdminCentre IS NOT NULL 
                      THEN tblAdminCentres.strName ELSE tblOHPClinics.strName END AS AdminCentre, CASE WHEN dbo.tblClinic2OHP.fkAdminCentre IS NOT NULL 
                      THEN tblOHPAdminCentre.strAddress WHEN dbo.tblOHPClinics.fkAdminCentre IS NOT NULL 
                      THEN tblAdminCentres.strAddress ELSE tblOHPClinics.strAddress END AS AdminAddress, CASE WHEN dbo.tblClinic2OHP.fkAdminCentre IS NOT NULL 
                      THEN tblOHPAdminCentre.strPostCode WHEN dbo.tblOHPClinics.fkAdminCentre IS NOT NULL 
                      THEN tblAdminCentres.strPostCode ELSE tblOHPClinics.strPostCode END AS AdminPostCode, CASE WHEN dbo.tblClinic2OHP.fkAdminCentre IS NOT NULL 
                      THEN tblOHPAdminCentre.strCountry WHEN dbo.tblOHPClinics.fkAdminCentre IS NOT NULL 
                      THEN tblAdminCentres.strCountry ELSE tblOHPClinics.strCountry END AS AdminCountry, CASE WHEN dbo.tblClinic2OHP.fkAdminCentre IS NOT NULL 
                      THEN tblOHPAdminCentre.strContact1 WHEN dbo.tblOHPClinics.fkAdminCentre IS NOT NULL 
                      THEN tblAdminCentres.strContact1 ELSE tblOHPClinics.strContact1 END AS AdminContact1, CASE WHEN dbo.tblClinic2OHP.fkAdminCentre IS NOT NULL 
                      THEN tblOHPAdminCentre.strContact1Email WHEN dbo.tblOHPClinics.fkAdminCentre IS NOT NULL 
                      THEN tblAdminCentres.strContact1Email ELSE tblOHPClinics.strContact1Email END AS AdminContact1Email, 
                      CASE WHEN dbo.tblClinic2OHP.fkAdminCentre IS NOT NULL THEN tblOHPAdminCentre.strContact1Tel WHEN dbo.tblOHPClinics.fkAdminCentre IS NOT NULL 
                      THEN tblAdminCentres.strContact1Tel ELSE tblOHPClinics.strContact1Tel END AS AdminContact1Tel, CASE WHEN dbo.tblClinic2OHP.fkAdminCentre IS NOT NULL 
                      THEN tblOHPAdminCentre.strContact1Mobile WHEN dbo.tblOHPClinics.fkAdminCentre IS NOT NULL 
                      THEN tblAdminCentres.strContact1Mobile ELSE tblOHPClinics.strContact1Mobile END AS AdminContact1Mobile, 
                      CASE WHEN dbo.tblClinic2OHP.fkAdminCentre IS NOT NULL THEN tblOHPAdminCentre.strContact2 WHEN dbo.tblOHPClinics.fkAdminCentre IS NOT NULL 
                      THEN tblAdminCentres.strContact2 ELSE tblOHPClinics.strContact2 END AS AdminContact2, CASE WHEN dbo.tblClinic2OHP.fkAdminCentre IS NOT NULL 
                      THEN tblOHPAdminCentre.strContact2Email WHEN dbo.tblOHPClinics.fkAdminCentre IS NOT NULL 
                      THEN tblAdminCentres.strContact2Email ELSE tblOHPClinics.strContact2Email END AS AdminContact2Email, 
                      CASE WHEN dbo.tblClinic2OHP.fkAdminCentre IS NOT NULL THEN tblOHPAdminCentre.strContact2Tel WHEN dbo.tblOHPClinics.fkAdminCentre IS NOT NULL 
                      THEN tblAdminCentres.strContact2Tel ELSE tblOHPClinics.strContact2Tel END AS AdminContact2Tel, CASE WHEN dbo.tblClinic2OHP.fkAdminCentre IS NOT NULL 
                      THEN tblOHPAdminCentre.strContact2Mobile WHEN dbo.tblOHPClinics.fkAdminCentre IS NOT NULL 
                      THEN tblAdminCentres.strContact2Mobile ELSE tblOHPClinics.strContact2Mobile END AS AdminContact2Mobile, 
                      CASE WHEN dbo.tblClinic2OHP.fkAdminCentre IS NOT NULL THEN tblOHPAdminCentre.strFax WHEN dbo.tblOHPClinics.fkAdminCentre IS NOT NULL 
                      THEN tblAdminCentres.strFax ELSE tblOHPClinics.strFax END AS AdminFax, CASE WHEN dbo.tblClinic2OHP.fkAdminCentre IS NOT NULL 
                      THEN tblOHPAdminCentre.strSwitchboard WHEN dbo.tblOHPClinics.fkAdminCentre IS NOT NULL 
                      THEN tblAdminCentres.strSwitchboard ELSE tblOHPClinics.strSwitchboard END AS AdminSwitchboard, CASE WHEN dbo.tblClinic2OHP.fkAdminCentre IS NOT NULL 
                      THEN tblOHPAdminCentre.strComments WHEN dbo.tblOHPClinics.fkAdminCentre IS NOT NULL 
                      THEN tblAdminCentres.strComments ELSE tblOHPClinics.strComments END AS AdminComments, dbo.tblOHPClinics.uidClinic, dbo.tblClinic2OHP.fkNetworkOHP, 
                      CASE WHEN dbo.tblClinic2OHP.fkAdminCentre IS NOT NULL THEN tblOHPAdminCentre.uidClinic WHEN dbo.tblOHPClinics.fkAdminCentre IS NOT NULL 
                      THEN tblAdminCentres.uidClinic ELSE tblOHPClinics.uidClinic END AS uidAdminClinic, COALESCE (dbo.tblNetworkOHPs.isOHP, dbo.tblOHPClinics.isOH, 1) AS isOHP, 
                      COALESCE(dbo.tblNetworkOHPs.isOHA, 0) AS 'isOHA',
                      COALESCE(dbo.tblOHPClinics.isSpecialist, 0) AS 'isSpecialist',
                      dbo.udfPreferredClinicDoctor(dbo.tblOHPClinics.isPreferred, dbo.tblNetworkOHPs.isPreferred) AS Preferred, 
                      dbo.udfPreferredClinicDoctor(dbo.tblOHPClinics.isBookNow, dbo.tblNetworkOHPs.isBookNow) AS BookNow, dbo.tblOHPClinics.isHML, 
                      dbo.tblOHPClinics.isOnsite
FROM         dbo.tblOHPClinics LEFT OUTER JOIN
                      dbo.tblClinic2OHP ON dbo.tblOHPClinics.uidClinic = dbo.tblClinic2OHP.fkClinic LEFT OUTER JOIN
                      dbo.tblNetworkOHPs ON dbo.tblClinic2OHP.fkNetworkOHP = dbo.tblNetworkOHPs.uidNetworkOHP LEFT OUTER JOIN
                      dbo.tblOHPClinics AS tblAdminCentres ON dbo.tblOHPClinics.fkAdminCentre = tblAdminCentres.uidClinic LEFT OUTER JOIN
                      dbo.tblOHPClinics AS tblOHPAdminCentre ON dbo.tblClinic2OHP.fkAdminCentre = tblOHPAdminCentre.uidClinic LEFT OUTER JOIN
                      dbo.tblOHQualifications ON dbo.tblNetworkOHPs.fkOHQualification = dbo.tblOHQualifications.uidOHQualification
WHERE     (dbo.tblNetworkOHPs.isActive = 1 OR
                      dbo.tblNetworkOHPs.isActive IS NULL) AND (dbo.tblOHPClinics.isActive = 1) AND (dbo.tblOHPClinics.isAdminOnly <> 1)
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ViewCounter_Token]    Script Date: 12/01/2015 09:16:47 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ViewCounter_Token] ON [Assessment].[ViewCounter]
(
	[Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CaseFamily]    Script Date: 12/01/2015 09:16:47 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_CaseFamily] ON [Case].[CaseFamily]
(
	[CaseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_tblNetworkOHPs_strEmail]    Script Date: 12/01/2015 09:16:47 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblNetworkOHPs_strEmail] ON [dbo].[tblNetworkOHPs]
(
	[strEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [Assessment].[Assessment] ADD  CONSTRAINT [DF_Assessment_AssessmentConsent]  DEFAULT ((0)) FOR [EmployeeConsent]
GO
ALTER TABLE [Assessment].[Assessment] ADD  CONSTRAINT [DF_Assessment_IsPublished]  DEFAULT ((0)) FOR [IsPublished]
GO
ALTER TABLE [Assessment].[Assessment] ADD  CONSTRAINT [DF_Assessment_PreAssessmentComplete]  DEFAULT ((0)) FOR [PreAssessmentComplete]
GO
ALTER TABLE [Assessment].[Assessment] ADD  CONSTRAINT [DF_Assessment_HealthAssessmentComplete]  DEFAULT ((0)) FOR [HealthAssessmentComplete]
GO
ALTER TABLE [Assessment].[Assessment] ADD  CONSTRAINT [DF_Assessment_PsychAssessmentComplete]  DEFAULT ((0)) FOR [PsychAssessmentComplete]
GO
ALTER TABLE [Assessment].[Assessment] ADD  CONSTRAINT [DF_Assessment_HomeAssessmentComplete]  DEFAULT ((0)) FOR [HomeAssessmentComplete]
GO
ALTER TABLE [Assessment].[Assessment] ADD  CONSTRAINT [DF_Assessment_WorkAssessmentComplete]  DEFAULT ((0)) FOR [WorkAssessmentComplete]
GO
ALTER TABLE [Assessment].[Assessment] ADD  CONSTRAINT [DF_Assessment_HealthQuestionnairesComplete]  DEFAULT ((0)) FOR [HealthQuestionnairesComplete]
GO
ALTER TABLE [Assessment].[Assessment] ADD  CONSTRAINT [DF_Assessment_SuicideQuestionnaireComplete]  DEFAULT ((0)) FOR [SuicideQuestionnaireComplete]
GO
ALTER TABLE [Assessment].[Assessment] ADD  CONSTRAINT [DF_Assessment_IsClone]  DEFAULT ((0)) FOR [IsClone]
GO
ALTER TABLE [Assessment].[ViewCounter] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [Authentication].[webpages_Membership] ADD  DEFAULT ((0)) FOR [IsConfirmed]
GO
ALTER TABLE [Authentication].[webpages_Membership] ADD  DEFAULT ((0)) FOR [PasswordFailuresSinceLastSuccess]
GO
ALTER TABLE [Case].[Case] ADD  CONSTRAINT [DF_Case_CreatedTimestamp]  DEFAULT (getdate()) FOR [CreatedTimestamp]
GO
ALTER TABLE [Case].[Case] ADD  CONSTRAINT [DF_Case_CaseFamilyId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [CaseFamilyId]
GO
ALTER TABLE [Case].[Case] ADD  CONSTRAINT [DF_Case_IsMarkedForDeletion]  DEFAULT ((0)) FOR [IsMarkedForDeletion]
GO
ALTER TABLE [Case].[CaseNote] ADD  CONSTRAINT [DF_CaseNote_IsClinical]  DEFAULT ((0)) FOR [IsClinical]
GO
ALTER TABLE [Case].[CaseNote] ADD  CONSTRAINT [DF_CaseNote_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [Case].[CaseNote] ADD  CONSTRAINT [DF_CaseNote_IsPinned]  DEFAULT ((0)) FOR [IsPinned]
GO
ALTER TABLE [Clinic].[Specialisation] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[AuditLog] ADD  CONSTRAINT [DF__AuditLog__AuditL__5FBE24CE]  DEFAULT (newid()) FOR [AuditLogId]
GO
ALTER TABLE [dbo].[tblButtonGroups] ADD  CONSTRAINT [DF_tblButtonGroups_uidButtonGroup]  DEFAULT (newid()) FOR [uidButtonGroup]
GO
ALTER TABLE [dbo].[tblButtonGroups] ADD  CONSTRAINT [DF_tblButtonGroups_strModBy]  DEFAULT (suser_sname()) FOR [strModBy]
GO
ALTER TABLE [dbo].[tblButtonGroups] ADD  CONSTRAINT [DF_tblButtonGroups_dtmMod]  DEFAULT (getdate()) FOR [dtmMod]
GO
ALTER TABLE [dbo].[tblButtonGroups] ADD  CONSTRAINT [DF_tblButtonGroups_dtmCreated]  DEFAULT (getdate()) FOR [dtmCreated]
GO
ALTER TABLE [dbo].[tblButtonGroups] ADD  CONSTRAINT [DF_tblButtonGroups_strCreatedBy]  DEFAULT (suser_sname()) FOR [strCreatedBy]
GO
ALTER TABLE [dbo].[tblClinic2OHP] ADD  CONSTRAINT [DF__DbaMgr_Tm__dtmCr__11207638]  DEFAULT (getdate()) FOR [dtmCreated]
GO
ALTER TABLE [dbo].[tblClinic2OHP] ADD  CONSTRAINT [DF__DbaMgr_Tm__isDel__12149A71]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[tblClinic2OHP] ADD  CONSTRAINT [DF__tblClinic__dtmMo__619C4B9F]  DEFAULT (getdate()) FOR [dtmMod]
GO
ALTER TABLE [dbo].[tblClinic2OHP] ADD  CONSTRAINT [DF__tblClinic__strMo__62906FD8]  DEFAULT ('System') FOR [strModBy]
GO
ALTER TABLE [dbo].[tblCountries] ADD  DEFAULT ((1)) FOR [isEnabled]
GO
ALTER TABLE [dbo].[tblCountries] ADD  DEFAULT (getdate()) FOR [dtmMod]
GO
ALTER TABLE [dbo].[tblCountries] ADD  DEFAULT (getdate()) FOR [dtmCreated]
GO
ALTER TABLE [dbo].[tblCountries] ADD  DEFAULT ('System') FOR [strCreatedBy]
GO
ALTER TABLE [dbo].[tblCountries] ADD  DEFAULT ('System') FOR [strModBy]
GO
ALTER TABLE [dbo].[tblDocumentCategories] ADD  CONSTRAINT [DF_tblDocumentCategories_ID]  DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[tblDocumentCategories] ADD  CONSTRAINT [DF_tblDocumentCategories_dtmMod]  DEFAULT (getdate()) FOR [dtmMod]
GO
ALTER TABLE [dbo].[tblGlobalVars] ADD  CONSTRAINT [DF__DbaMgr_Tm__uidGl__3B80C458]  DEFAULT (newid()) FOR [uidGlobalVars]
GO
ALTER TABLE [dbo].[tblGlobalVars] ADD  CONSTRAINT [DF__DbaMgr_Tm__dtmCr__3C74E891]  DEFAULT (getdate()) FOR [dtmCreated]
GO
ALTER TABLE [dbo].[tblGlobalVars] ADD  CONSTRAINT [DF__DbaMgr_Tm__isCur__3D690CCA]  DEFAULT ((1)) FOR [isCurrent]
GO
ALTER TABLE [dbo].[tblGlobalVars] ADD  CONSTRAINT [DF__tblGlobal__dtmMo__72C6D7A1]  DEFAULT (getdate()) FOR [dtmMod]
GO
ALTER TABLE [dbo].[tblGlobalVars] ADD  CONSTRAINT [DF__tblGlobal__strMo__73BAFBDA]  DEFAULT ('System') FOR [strModBy]
GO
ALTER TABLE [dbo].[tblGlobalVars] ADD  CONSTRAINT [DF_tblGlobalVars_intFMEInformClientChase]  DEFAULT ((2)) FOR [intFMEInformClientChase]
GO
ALTER TABLE [dbo].[tblGlobalVars] ADD  CONSTRAINT [DF_tblGlobalVars_strOverridePwd]  DEFAULT ('test') FOR [strOverridePwd]
GO
ALTER TABLE [dbo].[tblGlobalVars] ADD  CONSTRAINT [DF__tblGlobal__intCh__12DF6CCF]  DEFAULT ((90)) FOR [intCheckContractDays]
GO
ALTER TABLE [dbo].[tblInvuDocuments] ADD  CONSTRAINT [DF_tblInvuDocuments_createdDate]  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[tblInvuDocuments] ADD  CONSTRAINT [DF_tblInvuDocuments_processed]  DEFAULT ((0)) FOR [processed]
GO
ALTER TABLE [dbo].[tblInvuDocuments] ADD  CONSTRAINT [DF_tblInvuDocuments_indexFailed]  DEFAULT ((0)) FOR [failed]
GO
ALTER TABLE [dbo].[tblInvuDocumentTypes] ADD  CONSTRAINT [DF_tblInvuDocumentTypes_DisplayName]  DEFAULT (N'To be defined.') FOR [DisplayName]
GO
ALTER TABLE [dbo].[tblInvuDocumentTypes] ADD  CONSTRAINT [DF_tblInvuDocumentTypes_IsClinical]  DEFAULT ((0)) FOR [IsClinical]
GO
ALTER TABLE [dbo].[tblInvuIndexExceptions] ADD  CONSTRAINT [DF_tblInvuIndexExceptions_createdDate]  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[tblNetworkOHPs] ADD  CONSTRAINT [DF__DbaMgr_Tm__uidNe__1B33F057]  DEFAULT (newid()) FOR [uidNetworkOHP]
GO
ALTER TABLE [dbo].[tblNetworkOHPs] ADD  CONSTRAINT [DF__DbaMgr_Tm__isEna__1C281490]  DEFAULT ((1)) FOR [isEnabled]
GO
ALTER TABLE [dbo].[tblNetworkOHPs] ADD  CONSTRAINT [DF_tblNetworkOHPs_strModBy]  DEFAULT (suser_sname()) FOR [strModBy]
GO
ALTER TABLE [dbo].[tblNetworkOHPs] ADD  CONSTRAINT [DF__DbaMgr_Tm__dtmMo__1D1C38C9]  DEFAULT (getdate()) FOR [dtmMod]
GO
ALTER TABLE [dbo].[tblNetworkOHPs] ADD  CONSTRAINT [DF_tblNetworkOHPs_strCreatedBy]  DEFAULT (suser_sname()) FOR [strCreatedBy]
GO
ALTER TABLE [dbo].[tblNetworkOHPs] ADD  CONSTRAINT [DF__DbaMgr_Tm__dtmCr__1E105D02]  DEFAULT (getdate()) FOR [dtmCreated]
GO
ALTER TABLE [dbo].[tblNetworkOHPs] ADD  CONSTRAINT [DF__DbaMgr_Tm__isDel__1F04813B]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[tblNetworkOHPs] ADD  CONSTRAINT [DF_tblNetworkOHPs_isSpecialist]  DEFAULT ((0)) FOR [isSpecialist]
GO
ALTER TABLE [dbo].[tblNetworkOHPs] ADD  CONSTRAINT [DF_tblNetworkOHPs_isDoesOH]  DEFAULT ((1)) FOR [isOHP]
GO
ALTER TABLE [dbo].[tblNetworkOHPs] ADD  CONSTRAINT [DF__tblNetwor__isPre__7F7792A0]  DEFAULT ((0)) FOR [isPreferred]
GO
ALTER TABLE [dbo].[tblNetworkOHPs] ADD  CONSTRAINT [DF__tblNetwor__isCha__015FDB12]  DEFAULT ((1)) FOR [isChase]
GO
ALTER TABLE [dbo].[tblNetworkOHPs] ADD  CONSTRAINT [DF__tblNetwor__isBoo__043C47BD]  DEFAULT ((1)) FOR [isBookNow]
GO
ALTER TABLE [dbo].[tblNetworkOHPs] ADD  DEFAULT ((0)) FOR [isOHA]
GO
ALTER TABLE [dbo].[tblNetworkOHPs] ADD  CONSTRAINT [DF_tblNetworkOHPs_isHML]  DEFAULT ((0)) FOR [isHML]
GO
ALTER TABLE [dbo].[tblOHPClinics] ADD  CONSTRAINT [DF__DbaMgr_Tm__uidCl__11AA861D]  DEFAULT (newid()) FOR [uidClinic]
GO
ALTER TABLE [dbo].[tblOHPClinics] ADD  CONSTRAINT [DF_tblOHPClinics_strCountry]  DEFAULT ('UK') FOR [strCountry]
GO
ALTER TABLE [dbo].[tblOHPClinics] ADD  CONSTRAINT [DF__DbaMgr_Tm__dtmMo__129EAA56]  DEFAULT (getdate()) FOR [dtmMod]
GO
ALTER TABLE [dbo].[tblOHPClinics] ADD  CONSTRAINT [DF__DbaMgr_Tm__dtmCr__1392CE8F]  DEFAULT (getdate()) FOR [dtmCreated]
GO
ALTER TABLE [dbo].[tblOHPClinics] ADD  CONSTRAINT [DF__DbaMgr_Tm__isDel__1486F2C8]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[tblOHPClinics] ADD  CONSTRAINT [DF_tblOHPClinics_isUseForPaperWork]  DEFAULT ((1)) FOR [isUseForPaperWork]
GO
ALTER TABLE [dbo].[tblOHPClinics] ADD  CONSTRAINT [DF_tblOHPClinics_isAdminOnly]  DEFAULT ((0)) FOR [isAdminOnly]
GO
ALTER TABLE [dbo].[tblOHPClinics] ADD  CONSTRAINT [DF_tblOHPClinics_isSpecialist]  DEFAULT ((0)) FOR [isSpecialist]
GO
ALTER TABLE [dbo].[tblOHPClinics] ADD  CONSTRAINT [DF_tblOHPClinics_isOH]  DEFAULT ((1)) FOR [isOH]
GO
ALTER TABLE [dbo].[tblOHPClinics] ADD  CONSTRAINT [DF__tblOHPCli__isPre__006BB6D9]  DEFAULT ((0)) FOR [isPreferred]
GO
ALTER TABLE [dbo].[tblOHPClinics] ADD  CONSTRAINT [DF__tblOHPCli__isCha__0253FF4B]  DEFAULT ((1)) FOR [isChase]
GO
ALTER TABLE [dbo].[tblOHPClinics] ADD  CONSTRAINT [DF__tblOHPCli__isBoo__05306BF6]  DEFAULT ((1)) FOR [isBookNow]
GO
ALTER TABLE [dbo].[tblOHPClinics] ADD  CONSTRAINT [DF_tblOHPClinics_isHML]  DEFAULT ((0)) FOR [isHML]
GO
ALTER TABLE [dbo].[tblOHPClinics] ADD  CONSTRAINT [DF_tblOHPClinics_isOnsite]  DEFAULT ((0)) FOR [isOnsite]
GO
ALTER TABLE [dbo].[tblOHQualifications] ADD  CONSTRAINT [DF_tblOHQualifications_uidOHQualification]  DEFAULT (newid()) FOR [uidOHQualification]
GO
ALTER TABLE [dbo].[tblOHQualifications] ADD  CONSTRAINT [DF_tblOHQualifications_strModBy]  DEFAULT (suser_sname()) FOR [strModBy]
GO
ALTER TABLE [dbo].[tblOHQualifications] ADD  CONSTRAINT [DF_tblOHQualifications_dtmMod]  DEFAULT (getdate()) FOR [dtmMod]
GO
ALTER TABLE [dbo].[tblOHQualifications] ADD  CONSTRAINT [DF_tblOHQualifications_strCreatedBy]  DEFAULT (suser_sname()) FOR [strCreatedBy]
GO
ALTER TABLE [dbo].[tblOHQualifications] ADD  CONSTRAINT [DF_tblOHQualifications_dtmCreated]  DEFAULT (getdate()) FOR [dtmCreated]
GO
ALTER TABLE [dbo].[tblSpecialisations] ADD  CONSTRAINT [DF_tblSpecialisations_uidSpecialisation]  DEFAULT (newid()) FOR [uidSpecialisation]
GO
ALTER TABLE [dbo].[tblSpecialisations] ADD  CONSTRAINT [DF_tblSpecialisations_strModBy]  DEFAULT (suser_sname()) FOR [strModBy]
GO
ALTER TABLE [dbo].[tblSpecialisations] ADD  CONSTRAINT [DF_tblSpecialisations_dtmMod]  DEFAULT (getdate()) FOR [dtmMod]
GO
ALTER TABLE [dbo].[tblSpecialisations] ADD  CONSTRAINT [DF_tblSpecialisations_strCreatedBy]  DEFAULT (suser_sname()) FOR [strCreatedBy]
GO
ALTER TABLE [dbo].[tblSpecialisations] ADD  CONSTRAINT [DF_tblSpecialisations_dtmCreated]  DEFAULT (getdate()) FOR [dtmCreated]
GO
ALTER TABLE [dbo].[tblSpecialisations] ADD  CONSTRAINT [DF_tblSpecialisations_intOrder]  DEFAULT ((0)) FOR [intOrder]
GO
ALTER TABLE [dbo].[tblSpecialisations] ADD  CONSTRAINT [DF_tblSpecialisations_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[tblTemplateButtons] ADD  CONSTRAINT [DF_tblTemplateButtons_uidTemplateButton]  DEFAULT (newid()) FOR [uidTemplateButton]
GO
ALTER TABLE [dbo].[tblTemplateButtons] ADD  CONSTRAINT [DF_tblTemplateButtons_strModBy]  DEFAULT (suser_sname()) FOR [strModBy]
GO
ALTER TABLE [dbo].[tblTemplateButtons] ADD  CONSTRAINT [DF_tblTemplateButtons_dtmMod]  DEFAULT (getdate()) FOR [dtmMod]
GO
ALTER TABLE [dbo].[tblTemplateButtons] ADD  CONSTRAINT [DF_tblTemplateButtons_dtmCreated]  DEFAULT (getdate()) FOR [dtmCreated]
GO
ALTER TABLE [dbo].[tblTemplateButtons] ADD  CONSTRAINT [DF_tblTemplateButtons_strCreatedBy]  DEFAULT (suser_sname()) FOR [strCreatedBy]
GO
ALTER TABLE [dbo].[tblTemplateButtons] ADD  CONSTRAINT [DF_tblTemplateButtons_isDateCert]  DEFAULT ((0)) FOR [isDateCert]
GO
ALTER TABLE [dbo].[tblTemplates] ADD  CONSTRAINT [DF_tblReportTemplates_uidReportTemplate]  DEFAULT (newid()) FOR [uidTemplate]
GO
ALTER TABLE [dbo].[tblTemplates] ADD  CONSTRAINT [DF_tblTemplates_strModBy]  DEFAULT (suser_sname()) FOR [strModBy]
GO
ALTER TABLE [dbo].[tblTemplates] ADD  CONSTRAINT [DF_tblReportTemplates_dtmMod]  DEFAULT (getdate()) FOR [dtmMod]
GO
ALTER TABLE [dbo].[tblTemplates] ADD  CONSTRAINT [DF_tblReportTemplates_dtmCreated]  DEFAULT (getdate()) FOR [dtmCreated]
GO
ALTER TABLE [dbo].[tblTemplates] ADD  CONSTRAINT [DF_tblTemplates_strCreatedBy]  DEFAULT (suser_sname()) FOR [strCreatedBy]
GO
ALTER TABLE [dbo].[tblTemplates] ADD  CONSTRAINT [DF_tblTemplates_isEmail]  DEFAULT ((0)) FOR [isEmail]
GO
ALTER TABLE [INVU].[DocumentType] ADD  CONSTRAINT [DF_INVU_DocumentTypes_DisplayName]  DEFAULT (N'To be defined.') FOR [DisplayName]
GO
ALTER TABLE [INVU].[DocumentType] ADD  CONSTRAINT [DF_INVU_DocumentTypes_IsClinical]  DEFAULT ((0)) FOR [IsClinical]
GO
ALTER TABLE [Logging].[ErrorLog] ADD  CONSTRAINT [DF_ErrorLog_UTCTimestamp]  DEFAULT (getutcdate()) FOR [UTCTimestamp]
GO
ALTER TABLE [Referral].[Employee] ADD  CONSTRAINT [DF_Employee_ReceiveSMS]  DEFAULT ((0)) FOR [ReceiveSMS]
GO
ALTER TABLE [Referral].[Employee] ADD  CONSTRAINT [DF_Employee_ReceiveEmail]  DEFAULT ((0)) FOR [ReceiveEmail]
GO
ALTER TABLE [Template].[SMSTemplate] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [Appointment].[Appointment]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_AppointmentStatus] FOREIGN KEY([AppointmentStatusId])
REFERENCES [Appointment].[AppointmentStatus] ([Id])
GO
ALTER TABLE [Appointment].[Appointment] CHECK CONSTRAINT [FK_Appointment_AppointmentStatus]
GO
ALTER TABLE [Appointment].[Appointment]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_AppointmentType] FOREIGN KEY([AssessmentTypeId])
REFERENCES [Appointment].[AppointmentType] ([Id])
GO
ALTER TABLE [Appointment].[Appointment] CHECK CONSTRAINT [FK_Appointment_AppointmentType]
GO
ALTER TABLE [Appointment].[Appointment]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_Case] FOREIGN KEY([CaseId])
REFERENCES [Case].[Case] ([Id])
GO
ALTER TABLE [Appointment].[Appointment] CHECK CONSTRAINT [FK_Appointment_Case]
GO
ALTER TABLE [Appointment].[Appointment]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_Clinic] FOREIGN KEY([ClinicId])
REFERENCES [dbo].[tblOHPClinics] ([uidClinic])
GO
ALTER TABLE [Appointment].[Appointment] CHECK CONSTRAINT [FK_Appointment_Clinic]
GO
ALTER TABLE [Appointment].[Appointment]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_Clinician] FOREIGN KEY([ClinicianId])
REFERENCES [dbo].[tblNetworkOHPs] ([uidNetworkOHP])
GO
ALTER TABLE [Appointment].[Appointment] CHECK CONSTRAINT [FK_Appointment_Clinician]
GO
ALTER TABLE [Appointment].[Appointment]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_Resource] FOREIGN KEY([ResourceId])
REFERENCES [Resources].[Resource] ([Id])
GO
ALTER TABLE [Appointment].[Appointment] CHECK CONSTRAINT [FK_Appointment_Resource]
GO
ALTER TABLE [Appointment].[AppointmentDocument]  WITH CHECK ADD  CONSTRAINT [FK_AppointmentDocument_Appointment] FOREIGN KEY([AppointmentId])
REFERENCES [Appointment].[Appointment] ([Id])
GO
ALTER TABLE [Appointment].[AppointmentDocument] CHECK CONSTRAINT [FK_AppointmentDocument_Appointment]
GO
ALTER TABLE [Assessment].[Answer]  WITH CHECK ADD  CONSTRAINT [FK_AssessmentAnswer_Obstacle] FOREIGN KEY([AssessmentObstacleId])
REFERENCES [Assessment].[AssessmentObstacle] ([Id])
GO
ALTER TABLE [Assessment].[Answer] CHECK CONSTRAINT [FK_AssessmentAnswer_Obstacle]
GO
ALTER TABLE [Assessment].[Answer]  WITH CHECK ADD  CONSTRAINT [FK_AssessmentAnswer_QuestionTemplate] FOREIGN KEY([QuestionTemplateId])
REFERENCES [Assessment].[QuestionTemplate] ([Id])
GO
ALTER TABLE [Assessment].[Answer] CHECK CONSTRAINT [FK_AssessmentAnswer_QuestionTemplate]
GO
ALTER TABLE [Assessment].[AnswerLookup]  WITH CHECK ADD  CONSTRAINT [FK_AnswerLookup_Answer] FOREIGN KEY([AnswerId])
REFERENCES [Assessment].[Answer] ([Id])
GO
ALTER TABLE [Assessment].[AnswerLookup] CHECK CONSTRAINT [FK_AnswerLookup_Answer]
GO
ALTER TABLE [Assessment].[AnswerLookup]  WITH CHECK ADD  CONSTRAINT [FK_AnswerLookup_LookupItem] FOREIGN KEY([LookupItemId])
REFERENCES [Lookup].[LookupItem] ([Id])
GO
ALTER TABLE [Assessment].[AnswerLookup] CHECK CONSTRAINT [FK_AnswerLookup_LookupItem]
GO
ALTER TABLE [Assessment].[Assessment]  WITH CHECK ADD  CONSTRAINT [FK_Assessment_AssessmentStatus] FOREIGN KEY([AssessmentStatusId])
REFERENCES [Assessment].[AssessmentStatus] ([Id])
GO
ALTER TABLE [Assessment].[Assessment] CHECK CONSTRAINT [FK_Assessment_AssessmentStatus]
GO
ALTER TABLE [Assessment].[Assessment]  WITH CHECK ADD  CONSTRAINT [FK_Assessment_AssessmentTypeLookupItem] FOREIGN KEY([AssessmentTypeId])
REFERENCES [Lookup].[LookupItem] ([Id])
GO
ALTER TABLE [Assessment].[Assessment] CHECK CONSTRAINT [FK_Assessment_AssessmentTypeLookupItem]
GO
ALTER TABLE [Assessment].[Assessment]  WITH CHECK ADD  CONSTRAINT [FK_Assessment_Resource] FOREIGN KEY([CaseManagerResourceId])
REFERENCES [Resources].[Resource] ([Id])
GO
ALTER TABLE [Assessment].[Assessment] CHECK CONSTRAINT [FK_Assessment_Resource]
GO
ALTER TABLE [Assessment].[AssessmentObstacle]  WITH CHECK ADD  CONSTRAINT [FK_AssessmentObstacle_Assessment] FOREIGN KEY([AssessmentId])
REFERENCES [Assessment].[Assessment] ([Id])
GO
ALTER TABLE [Assessment].[AssessmentObstacle] CHECK CONSTRAINT [FK_AssessmentObstacle_Assessment]
GO
ALTER TABLE [Assessment].[AssessmentObstacle]  WITH CHECK ADD  CONSTRAINT [FK_AssessmentObstacle_Obstacle] FOREIGN KEY([ObstacleId])
REFERENCES [Assessment].[Obstacle] ([Id])
GO
ALTER TABLE [Assessment].[AssessmentObstacle] CHECK CONSTRAINT [FK_AssessmentObstacle_Obstacle]
GO
ALTER TABLE [Assessment].[AssessmentObstacleRecomendation]  WITH CHECK ADD  CONSTRAINT [FK_AssessmentObstacleRecomendation_AssessmentObstacle] FOREIGN KEY([AssessmentObstacleId])
REFERENCES [Assessment].[AssessmentObstacle] ([Id])
GO
ALTER TABLE [Assessment].[AssessmentObstacleRecomendation] CHECK CONSTRAINT [FK_AssessmentObstacleRecomendation_AssessmentObstacle]
GO
ALTER TABLE [Assessment].[AssessmentObstacleRecomendation]  WITH CHECK ADD  CONSTRAINT [FK_AssessmentObstacleRecomendation_Recommendation] FOREIGN KEY([RecomendationId])
REFERENCES [Assessment].[Recommendation] ([Id])
GO
ALTER TABLE [Assessment].[AssessmentObstacleRecomendation] CHECK CONSTRAINT [FK_AssessmentObstacleRecomendation_Recommendation]
GO
ALTER TABLE [Assessment].[AssessmentObstacleSignpost]  WITH CHECK ADD  CONSTRAINT [FK_AssessmentObstacleSignpost_AssessmentObstacle] FOREIGN KEY([AssessmentObstacleId])
REFERENCES [Assessment].[AssessmentObstacle] ([Id])
GO
ALTER TABLE [Assessment].[AssessmentObstacleSignpost] CHECK CONSTRAINT [FK_AssessmentObstacleSignpost_AssessmentObstacle]
GO
ALTER TABLE [Assessment].[AssessmentObstacleSignpost]  WITH CHECK ADD  CONSTRAINT [FK_AssessmentObstacleSignpost_Signpost] FOREIGN KEY([SignpostId])
REFERENCES [Assessment].[Signpost] ([Id])
GO
ALTER TABLE [Assessment].[AssessmentObstacleSignpost] CHECK CONSTRAINT [FK_AssessmentObstacleSignpost_Signpost]
GO
ALTER TABLE [Assessment].[AssessmentQuestionnaire]  WITH CHECK ADD  CONSTRAINT [FK_AssessmentQuestionnaire_Assessment] FOREIGN KEY([AssessmentId])
REFERENCES [Assessment].[Assessment] ([Id])
GO
ALTER TABLE [Assessment].[AssessmentQuestionnaire] CHECK CONSTRAINT [FK_AssessmentQuestionnaire_Assessment]
GO
ALTER TABLE [Assessment].[AssessmentQuestionnaire]  WITH CHECK ADD  CONSTRAINT [FK_AssessmentQuestionnaire_Questionnaire] FOREIGN KEY([QuestionnaireId])
REFERENCES [Assessment].[Questionnaire] ([Id])
GO
ALTER TABLE [Assessment].[AssessmentQuestionnaire] CHECK CONSTRAINT [FK_AssessmentQuestionnaire_Questionnaire]
GO
ALTER TABLE [Assessment].[AssessmentQuestionnaireAnswer]  WITH CHECK ADD  CONSTRAINT [FK_AssessmentQuestionnaireAnswer_AssessmentQuestionnaire] FOREIGN KEY([AssessmentQuestionnaireId])
REFERENCES [Assessment].[AssessmentQuestionnaire] ([Id])
GO
ALTER TABLE [Assessment].[AssessmentQuestionnaireAnswer] CHECK CONSTRAINT [FK_AssessmentQuestionnaireAnswer_AssessmentQuestionnaire]
GO
ALTER TABLE [Assessment].[AssessmentQuestionnaireAnswer]  WITH CHECK ADD  CONSTRAINT [FK_AssessmentQuestionnaireAnswer_QuestionnaireQuestion] FOREIGN KEY([QuestionnaireQuestionId])
REFERENCES [Assessment].[QuestionnaireQuestion] ([Id])
GO
ALTER TABLE [Assessment].[AssessmentQuestionnaireAnswer] CHECK CONSTRAINT [FK_AssessmentQuestionnaireAnswer_QuestionnaireQuestion]
GO
ALTER TABLE [Assessment].[Obstacle]  WITH CHECK ADD  CONSTRAINT [FK_Obstacle_ObstacleType] FOREIGN KEY([ObstacleTypeId])
REFERENCES [Assessment].[ObstacleType] ([Id])
GO
ALTER TABLE [Assessment].[Obstacle] CHECK CONSTRAINT [FK_Obstacle_ObstacleType]
GO
ALTER TABLE [Assessment].[Obstacle]  WITH CHECK ADD  CONSTRAINT [FK_Obstacle_Section] FOREIGN KEY([SectionId])
REFERENCES [Assessment].[Section] ([Id])
GO
ALTER TABLE [Assessment].[Obstacle] CHECK CONSTRAINT [FK_Obstacle_Section]
GO
ALTER TABLE [Assessment].[QuestionnaireQuestion]  WITH CHECK ADD  CONSTRAINT [FK_QuestionnaireQuestion_Questionnaire] FOREIGN KEY([QuestionnaireId])
REFERENCES [Assessment].[Questionnaire] ([Id])
GO
ALTER TABLE [Assessment].[QuestionnaireQuestion] CHECK CONSTRAINT [FK_QuestionnaireQuestion_Questionnaire]
GO
ALTER TABLE [Assessment].[QuestionnaireQuestionAnswer]  WITH CHECK ADD  CONSTRAINT [FK_QuestionnaireQuestionAnswer_QuestionnaireAnswer] FOREIGN KEY([QuestionnaireAnswerId])
REFERENCES [Assessment].[QuestionnaireAnswer] ([Id])
GO
ALTER TABLE [Assessment].[QuestionnaireQuestionAnswer] CHECK CONSTRAINT [FK_QuestionnaireQuestionAnswer_QuestionnaireAnswer]
GO
ALTER TABLE [Assessment].[QuestionnaireQuestionAnswer]  WITH CHECK ADD  CONSTRAINT [FK_QuestionnaireQuestionAnswer_QuestionnaireQuestion] FOREIGN KEY([QuestionnaireQuestionId])
REFERENCES [Assessment].[QuestionnaireQuestion] ([Id])
GO
ALTER TABLE [Assessment].[QuestionnaireQuestionAnswer] CHECK CONSTRAINT [FK_QuestionnaireQuestionAnswer_QuestionnaireQuestion]
GO
ALTER TABLE [Assessment].[QuestionnaireTotalBand]  WITH CHECK ADD  CONSTRAINT [FK_QuestionnaireTotalBand_Questionnaire] FOREIGN KEY([QuestionnaireId])
REFERENCES [Assessment].[Questionnaire] ([Id])
GO
ALTER TABLE [Assessment].[QuestionnaireTotalBand] CHECK CONSTRAINT [FK_QuestionnaireTotalBand_Questionnaire]
GO
ALTER TABLE [Assessment].[QuestionTemplate]  WITH CHECK ADD  CONSTRAINT [FK_QuestionTemplate_Lookup] FOREIGN KEY([LookupId])
REFERENCES [Lookup].[Lookup] ([Id])
GO
ALTER TABLE [Assessment].[QuestionTemplate] CHECK CONSTRAINT [FK_QuestionTemplate_Lookup]
GO
ALTER TABLE [Assessment].[Recommendation]  WITH CHECK ADD  CONSTRAINT [FK_Recommendation_Obstacle] FOREIGN KEY([ObstacleId])
REFERENCES [Assessment].[Obstacle] ([Id])
GO
ALTER TABLE [Assessment].[Recommendation] CHECK CONSTRAINT [FK_Recommendation_Obstacle]
GO
ALTER TABLE [Assessment].[ReturnToWorkObstacle]  WITH CHECK ADD  CONSTRAINT [FK_ReturnToWorkObstacle_Obstacle] FOREIGN KEY([ObstacleId])
REFERENCES [Assessment].[Obstacle] ([Id])
GO
ALTER TABLE [Assessment].[ReturnToWorkObstacle] CHECK CONSTRAINT [FK_ReturnToWorkObstacle_Obstacle]
GO
ALTER TABLE [Assessment].[ReturnToWorkObstacle]  WITH CHECK ADD  CONSTRAINT [FK_ReturnToWorkObstacle_ReturnToWorkPlan] FOREIGN KEY([ReturnToWorkPlanId])
REFERENCES [Assessment].[ReturnToWorkPlan] ([Id])
GO
ALTER TABLE [Assessment].[ReturnToWorkObstacle] CHECK CONSTRAINT [FK_ReturnToWorkObstacle_ReturnToWorkPlan]
GO
ALTER TABLE [Assessment].[ReturnToWorkPlan]  WITH CHECK ADD  CONSTRAINT [FK_ReturnToWorkPlan_Assessment] FOREIGN KEY([AssessmentId])
REFERENCES [Assessment].[Assessment] ([Id])
GO
ALTER TABLE [Assessment].[ReturnToWorkPlan] CHECK CONSTRAINT [FK_ReturnToWorkPlan_Assessment]
GO
ALTER TABLE [Assessment].[ReturnToWorkPlan]  WITH CHECK ADD  CONSTRAINT [FK_ReturnToWorkPlan_FitStatus] FOREIGN KEY([FitStatusId])
REFERENCES [Assessment].[FitStatus] ([Id])
GO
ALTER TABLE [Assessment].[ReturnToWorkPlan] CHECK CONSTRAINT [FK_ReturnToWorkPlan_FitStatus]
GO
ALTER TABLE [Assessment].[ReturnToWorkPlan]  WITH CHECK ADD  CONSTRAINT [FK_ReturnToWorkPlan_ReturnToWorkOption] FOREIGN KEY([ReturnToWorkOptionId])
REFERENCES [Assessment].[ReturnToWorkOption] ([Id])
GO
ALTER TABLE [Assessment].[ReturnToWorkPlan] CHECK CONSTRAINT [FK_ReturnToWorkPlan_ReturnToWorkOption]
GO
ALTER TABLE [Assessment].[ReturnToWorkPlan]  WITH CHECK ADD  CONSTRAINT [FK_ReturnToWorkPlan_TouchPoint] FOREIGN KEY([TouchPointId])
REFERENCES [Lookup].[LookupItem] ([Id])
GO
ALTER TABLE [Assessment].[ReturnToWorkPlan] CHECK CONSTRAINT [FK_ReturnToWorkPlan_TouchPoint]
GO
ALTER TABLE [Assessment].[ReturnToWorkPlanIntervention]  WITH CHECK ADD  CONSTRAINT [FK_ReturnToWorkPlanIntervention_LookupItem] FOREIGN KEY([InterventionId])
REFERENCES [Lookup].[LookupItem] ([Id])
GO
ALTER TABLE [Assessment].[ReturnToWorkPlanIntervention] CHECK CONSTRAINT [FK_ReturnToWorkPlanIntervention_LookupItem]
GO
ALTER TABLE [Assessment].[ReturnToWorkPlanIntervention]  WITH CHECK ADD  CONSTRAINT [FK_ReturnToWorkPlanIntervention_ReturnToWorkPlan] FOREIGN KEY([ReturnToWorkPlanId])
REFERENCES [Assessment].[ReturnToWorkPlan] ([Id])
GO
ALTER TABLE [Assessment].[ReturnToWorkPlanIntervention] CHECK CONSTRAINT [FK_ReturnToWorkPlanIntervention_ReturnToWorkPlan]
GO
ALTER TABLE [Assessment].[ReturnToWorkPlanSignposting]  WITH CHECK ADD  CONSTRAINT [FK_ReturnToWorkPlanSignposting_LookupItem] FOREIGN KEY([SignpostingId])
REFERENCES [Lookup].[LookupItem] ([Id])
GO
ALTER TABLE [Assessment].[ReturnToWorkPlanSignposting] CHECK CONSTRAINT [FK_ReturnToWorkPlanSignposting_LookupItem]
GO
ALTER TABLE [Assessment].[ReturnToWorkPlanSignposting]  WITH CHECK ADD  CONSTRAINT [FK_ReturnToWorkPlanSignposting_ReturnToWorkPlan] FOREIGN KEY([ReturnToWorkPlanId])
REFERENCES [Assessment].[ReturnToWorkPlan] ([Id])
GO
ALTER TABLE [Assessment].[ReturnToWorkPlanSignposting] CHECK CONSTRAINT [FK_ReturnToWorkPlanSignposting_ReturnToWorkPlan]
GO
ALTER TABLE [Assessment].[SectionQuestion]  WITH CHECK ADD  CONSTRAINT [FK_AssessmentSectionQuestion_AssessmentSection] FOREIGN KEY([AssessmentSectionId])
REFERENCES [Assessment].[Section] ([Id])
GO
ALTER TABLE [Assessment].[SectionQuestion] CHECK CONSTRAINT [FK_AssessmentSectionQuestion_AssessmentSection]
GO
ALTER TABLE [Assessment].[SectionQuestion]  WITH CHECK ADD  CONSTRAINT [FK_AssessmentSectionQuestion_QuestionTemplate] FOREIGN KEY([QuestionTemplateId])
REFERENCES [Assessment].[QuestionTemplate] ([Id])
GO
ALTER TABLE [Assessment].[SectionQuestion] CHECK CONSTRAINT [FK_AssessmentSectionQuestion_QuestionTemplate]
GO
ALTER TABLE [Assessment].[Signpost]  WITH CHECK ADD  CONSTRAINT [FK_Signpost_Obstacle] FOREIGN KEY([ObstacleId])
REFERENCES [Assessment].[Obstacle] ([Id])
GO
ALTER TABLE [Assessment].[Signpost] CHECK CONSTRAINT [FK_Signpost_Obstacle]
GO
ALTER TABLE [Assessment].[ViewCounter]  WITH CHECK ADD  CONSTRAINT [FK_ViewCounter_CaseNote] FOREIGN KEY([CaseNoteId])
REFERENCES [Case].[CaseNote] ([Id])
GO
ALTER TABLE [Assessment].[ViewCounter] CHECK CONSTRAINT [FK_ViewCounter_CaseNote]
GO
ALTER TABLE [Assessment].[ViewCounter]  WITH CHECK ADD  CONSTRAINT [FK_ViewCounter_ReturnToWorkPlan] FOREIGN KEY([ReturnToWorkPlanId])
REFERENCES [Assessment].[ReturnToWorkPlan] ([Id])
GO
ALTER TABLE [Assessment].[ViewCounter] CHECK CONSTRAINT [FK_ViewCounter_ReturnToWorkPlan]
GO
ALTER TABLE [Assessment].[WorkplaceAdjustment]  WITH CHECK ADD  CONSTRAINT [FK_WorkplaceAdjustment_Obstacle] FOREIGN KEY([ObstacleId])
REFERENCES [Assessment].[Obstacle] ([Id])
GO
ALTER TABLE [Assessment].[WorkplaceAdjustment] CHECK CONSTRAINT [FK_WorkplaceAdjustment_Obstacle]
GO
ALTER TABLE [Audit].[AuditLog]  WITH CHECK ADD  CONSTRAINT [FK_AuditLog_AuditAction] FOREIGN KEY([ActionId])
REFERENCES [Audit].[AuditAction] ([ActionId])
GO
ALTER TABLE [Audit].[AuditLog] CHECK CONSTRAINT [FK_AuditLog_AuditAction]
GO
ALTER TABLE [Audit].[AuditProperty]  WITH CHECK ADD  CONSTRAINT [FK_AuditProperty_AuditLog] FOREIGN KEY([AuditId])
REFERENCES [Audit].[AuditLog] ([AuditId])
GO
ALTER TABLE [Audit].[AuditProperty] CHECK CONSTRAINT [FK_AuditProperty_AuditLog]
GO
ALTER TABLE [Authentication].[webpages_Membership]  WITH CHECK ADD  CONSTRAINT [FK_webpges_Membership_NetworkDoctor] FOREIGN KEY([UserId])
REFERENCES [Authentication].[NetworkDoctor] ([UserId])
GO
ALTER TABLE [Authentication].[webpages_Membership] CHECK CONSTRAINT [FK_webpges_Membership_NetworkDoctor]
GO
ALTER TABLE [Authentication].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_RoleId] FOREIGN KEY([RoleId])
REFERENCES [Authentication].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [Authentication].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_RoleId]
GO
ALTER TABLE [Authentication].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_UserId] FOREIGN KEY([UserId])
REFERENCES [Authentication].[NetworkDoctor] ([UserId])
GO
ALTER TABLE [Authentication].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_UserId]
GO
ALTER TABLE [Case].[Case]  WITH CHECK ADD  CONSTRAINT [FK_Case_Case] FOREIGN KEY([Id])
REFERENCES [Case].[Case] ([Id])
GO
ALTER TABLE [Case].[Case] CHECK CONSTRAINT [FK_Case_Case]
GO
ALTER TABLE [Case].[Case]  WITH CHECK ADD  CONSTRAINT [FK_Case_CaseStatus] FOREIGN KEY([CaseStatusId])
REFERENCES [Case].[CaseStatus] ([Id])
GO
ALTER TABLE [Case].[Case] CHECK CONSTRAINT [FK_Case_CaseStatus]
GO
ALTER TABLE [Case].[Case]  WITH CHECK ADD  CONSTRAINT [FK_Case_Client] FOREIGN KEY([ClientId])
REFERENCES [Resources].[Client] ([Id])
GO
ALTER TABLE [Case].[Case] CHECK CONSTRAINT [FK_Case_Client]
GO
ALTER TABLE [Case].[Case]  WITH CHECK ADD  CONSTRAINT [FK_Case_DischargeReason] FOREIGN KEY([DischargeReasonId])
REFERENCES [Lookup].[DischargeReason] ([Id])
GO
ALTER TABLE [Case].[Case] CHECK CONSTRAINT [FK_Case_DischargeReason]
GO
ALTER TABLE [Case].[Case]  WITH CHECK ADD  CONSTRAINT [FK_Case_Referral] FOREIGN KEY([ReferralId])
REFERENCES [Referral].[Referral] ([Id])
GO
ALTER TABLE [Case].[Case] CHECK CONSTRAINT [FK_Case_Referral]
GO
ALTER TABLE [Case].[Case]  WITH CHECK ADD  CONSTRAINT [FK_Case_Resource] FOREIGN KEY([CaseManagerId])
REFERENCES [Resources].[Resource] ([Id])
GO
ALTER TABLE [Case].[Case] CHECK CONSTRAINT [FK_Case_Resource]
GO
ALTER TABLE [Case].[CaseCTATeam]  WITH CHECK ADD  CONSTRAINT [FK_CaseCTATeam_Case] FOREIGN KEY([CaseId])
REFERENCES [Case].[Case] ([Id])
GO
ALTER TABLE [Case].[CaseCTATeam] CHECK CONSTRAINT [FK_CaseCTATeam_Case]
GO
ALTER TABLE [Case].[CaseCTATeam]  WITH CHECK ADD  CONSTRAINT [FK_CaseCTATeam_CTATeam] FOREIGN KEY([CTATeamId])
REFERENCES [Resources].[CTATeam] ([Id])
GO
ALTER TABLE [Case].[CaseCTATeam] CHECK CONSTRAINT [FK_CaseCTATeam_CTATeam]
GO
ALTER TABLE [Case].[CaseFamily]  WITH CHECK ADD  CONSTRAINT [FK_CaseFamily_Case] FOREIGN KEY([CaseId])
REFERENCES [Case].[Case] ([Id])
GO
ALTER TABLE [Case].[CaseFamily] CHECK CONSTRAINT [FK_CaseFamily_Case]
GO
ALTER TABLE [Case].[CaseHPTeam]  WITH CHECK ADD  CONSTRAINT [FK_CaseHPTeam_Case] FOREIGN KEY([CaseId])
REFERENCES [Case].[Case] ([Id])
GO
ALTER TABLE [Case].[CaseHPTeam] CHECK CONSTRAINT [FK_CaseHPTeam_Case]
GO
ALTER TABLE [Case].[CaseHPTeam]  WITH CHECK ADD  CONSTRAINT [FK_CaseHPTeam_CTATeam] FOREIGN KEY([HPTeamId])
REFERENCES [Resources].[CTATeam] ([Id])
GO
ALTER TABLE [Case].[CaseHPTeam] CHECK CONSTRAINT [FK_CaseHPTeam_CTATeam]
GO
ALTER TABLE [Case].[CaseNote]  WITH CHECK ADD  CONSTRAINT [FK_CaseNote_Case] FOREIGN KEY([CaseId])
REFERENCES [Case].[Case] ([Id])
GO
ALTER TABLE [Case].[CaseNote] CHECK CONSTRAINT [FK_CaseNote_Case]
GO
ALTER TABLE [Case].[CaseNote]  WITH CHECK ADD  CONSTRAINT [FK_CaseNote_CaseNoteType] FOREIGN KEY([CaseNoteTypeId])
REFERENCES [Case].[CaseNoteType] ([Id])
GO
ALTER TABLE [Case].[CaseNote] CHECK CONSTRAINT [FK_CaseNote_CaseNoteType]
GO
ALTER TABLE [Case].[CaseNote]  WITH CHECK ADD  CONSTRAINT [FK_CaseNote_DocumentType] FOREIGN KEY([DocumentTypeId])
REFERENCES [INVU].[DocumentType] ([Id])
GO
ALTER TABLE [Case].[CaseNote] CHECK CONSTRAINT [FK_CaseNote_DocumentType]
GO
ALTER TABLE [Case].[CaseStatusHistory]  WITH CHECK ADD  CONSTRAINT [FK_CaseStatusHistory_Case] FOREIGN KEY([CaseId])
REFERENCES [Case].[Case] ([Id])
GO
ALTER TABLE [Case].[CaseStatusHistory] CHECK CONSTRAINT [FK_CaseStatusHistory_Case]
GO
ALTER TABLE [Case].[CaseStatusHistory]  WITH CHECK ADD  CONSTRAINT [FK_CaseStatusHistory_CaseStatus] FOREIGN KEY([CaseStatusId])
REFERENCES [Case].[CaseStatus] ([Id])
GO
ALTER TABLE [Case].[CaseStatusHistory] CHECK CONSTRAINT [FK_CaseStatusHistory_CaseStatus]
GO
ALTER TABLE [Clinic].[Clinic_Clinician]  WITH CHECK ADD FOREIGN KEY([ClinicianId])
REFERENCES [Clinic].[Clinician] ([ClinicianId])
GO
ALTER TABLE [Clinic].[Clinic_Clinician]  WITH CHECK ADD FOREIGN KEY([ClinicId])
REFERENCES [Clinic].[Clinic] ([ClinicId])
GO
ALTER TABLE [Clinic].[Clinic_Specialisation]  WITH CHECK ADD FOREIGN KEY([ClinicId])
REFERENCES [Clinic].[Clinic] ([ClinicId])
GO
ALTER TABLE [Clinic].[Clinic_Specialisation]  WITH CHECK ADD FOREIGN KEY([SpecialisationId])
REFERENCES [Clinic].[Specialisation] ([SpecialisationId])
GO
ALTER TABLE [Clinic].[Clinician_Specialisation]  WITH CHECK ADD FOREIGN KEY([ClinicianId])
REFERENCES [Clinic].[Clinician] ([ClinicianId])
GO
ALTER TABLE [Clinic].[Clinician_Specialisation]  WITH CHECK ADD FOREIGN KEY([SpecialisationId])
REFERENCES [Clinic].[Specialisation] ([SpecialisationId])
GO
ALTER TABLE [Complaint].[ComplaintAction]  WITH CHECK ADD  CONSTRAINT [FK_ComplaintAction_Complaint] FOREIGN KEY([ComplaintId])
REFERENCES [Complaint].[Complaint] ([Id])
GO
ALTER TABLE [Complaint].[ComplaintAction] CHECK CONSTRAINT [FK_ComplaintAction_Complaint]
GO
ALTER TABLE [Complaint].[ComplaintCase]  WITH CHECK ADD  CONSTRAINT [FK_ComplaintCase_Case] FOREIGN KEY([CaseId])
REFERENCES [Case].[Case] ([Id])
GO
ALTER TABLE [Complaint].[ComplaintCase] CHECK CONSTRAINT [FK_ComplaintCase_Case]
GO
ALTER TABLE [Complaint].[ComplaintCase]  WITH CHECK ADD  CONSTRAINT [FK_ComplaintCase_Complaint] FOREIGN KEY([ComplaintId])
REFERENCES [Complaint].[Complaint] ([Id])
GO
ALTER TABLE [Complaint].[ComplaintCase] CHECK CONSTRAINT [FK_ComplaintCase_Complaint]
GO
ALTER TABLE [Complaint].[ComplaintDocument]  WITH CHECK ADD  CONSTRAINT [FK_ComplaintDocument_Complaint] FOREIGN KEY([ComplaintId])
REFERENCES [Complaint].[Complaint] ([Id])
GO
ALTER TABLE [Complaint].[ComplaintDocument] CHECK CONSTRAINT [FK_ComplaintDocument_Complaint]
GO
ALTER TABLE [Complaint].[ComplaintNote]  WITH CHECK ADD  CONSTRAINT [FK_ComplaintNote_Complaint] FOREIGN KEY([ComplaintId])
REFERENCES [Complaint].[Complaint] ([Id])
GO
ALTER TABLE [Complaint].[ComplaintNote] CHECK CONSTRAINT [FK_ComplaintNote_Complaint]
GO
ALTER TABLE [dbo].[tblClinic2OHP]  WITH NOCHECK ADD  CONSTRAINT [FK_Clinic2OHP_Clinic] FOREIGN KEY([fkClinic])
REFERENCES [dbo].[tblOHPClinics] ([uidClinic])
ON UPDATE CASCADE
ON DELETE CASCADE
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[tblClinic2OHP] CHECK CONSTRAINT [FK_Clinic2OHP_Clinic]
GO
ALTER TABLE [dbo].[tblClinic2OHP]  WITH NOCHECK ADD  CONSTRAINT [FK_Clinic2OHP_OHP] FOREIGN KEY([fkNetworkOHP])
REFERENCES [dbo].[tblNetworkOHPs] ([uidNetworkOHP])
ON UPDATE CASCADE
ON DELETE CASCADE
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[tblClinic2OHP] CHECK CONSTRAINT [FK_Clinic2OHP_OHP]
GO
ALTER TABLE [dbo].[tblClinic2OHP]  WITH CHECK ADD  CONSTRAINT [FK_tblClinic2OHP_tblOHPClinics] FOREIGN KEY([fkAdminCentre])
REFERENCES [dbo].[tblOHPClinics] ([uidClinic])
GO
ALTER TABLE [dbo].[tblClinic2OHP] CHECK CONSTRAINT [FK_tblClinic2OHP_tblOHPClinics]
GO
ALTER TABLE [dbo].[tblClinic2Specialisation]  WITH CHECK ADD  CONSTRAINT [FK_tblClinic2Specialisation_tblOHPClinics] FOREIGN KEY([fkClinic])
REFERENCES [dbo].[tblOHPClinics] ([uidClinic])
GO
ALTER TABLE [dbo].[tblClinic2Specialisation] CHECK CONSTRAINT [FK_tblClinic2Specialisation_tblOHPClinics]
GO
ALTER TABLE [dbo].[tblClinic2Specialisation]  WITH CHECK ADD  CONSTRAINT [FK_tblClinic2Specialisation_tblSpecialisations] FOREIGN KEY([fkSpecialisation])
REFERENCES [dbo].[tblSpecialisations] ([uidSpecialisation])
GO
ALTER TABLE [dbo].[tblClinic2Specialisation] CHECK CONSTRAINT [FK_tblClinic2Specialisation_tblSpecialisations]
GO
ALTER TABLE [dbo].[tblClinician2Specialisation]  WITH CHECK ADD  CONSTRAINT [FK_tblClinician2Specialisation_tblNetworkOHPs] FOREIGN KEY([fkNetworkOHP])
REFERENCES [dbo].[tblNetworkOHPs] ([uidNetworkOHP])
GO
ALTER TABLE [dbo].[tblClinician2Specialisation] CHECK CONSTRAINT [FK_tblClinician2Specialisation_tblNetworkOHPs]
GO
ALTER TABLE [dbo].[tblClinician2Specialisation]  WITH CHECK ADD  CONSTRAINT [FK_tblClinician2Specialisation_tblSpecialisations] FOREIGN KEY([fkSpecialisation])
REFERENCES [dbo].[tblSpecialisations] ([uidSpecialisation])
GO
ALTER TABLE [dbo].[tblClinician2Specialisation] CHECK CONSTRAINT [FK_tblClinician2Specialisation_tblSpecialisations]
GO
ALTER TABLE [dbo].[tblDr2Specialisation]  WITH CHECK ADD  CONSTRAINT [FK_tblDr2Specialisation_tblNetworkOHPs] FOREIGN KEY([fkOHP])
REFERENCES [dbo].[tblNetworkOHPs] ([uidNetworkOHP])
GO
ALTER TABLE [dbo].[tblDr2Specialisation] CHECK CONSTRAINT [FK_tblDr2Specialisation_tblNetworkOHPs]
GO
ALTER TABLE [dbo].[tblDr2Specialisation]  WITH CHECK ADD  CONSTRAINT [FK_tblDr2Specialisation_tblSpecialisations] FOREIGN KEY([fkSpecialisation])
REFERENCES [dbo].[tblSpecialisations] ([uidSpecialisation])
GO
ALTER TABLE [dbo].[tblDr2Specialisation] CHECK CONSTRAINT [FK_tblDr2Specialisation_tblSpecialisations]
GO
ALTER TABLE [dbo].[tblNetworkOHPs]  WITH CHECK ADD  CONSTRAINT [FK_tblNetworkOHPs_NetworkDoctor] FOREIGN KEY([NetworkDoctorId])
REFERENCES [Authentication].[NetworkDoctor] ([UserId])
GO
ALTER TABLE [dbo].[tblNetworkOHPs] CHECK CONSTRAINT [FK_tblNetworkOHPs_NetworkDoctor]
GO
ALTER TABLE [dbo].[tblNetworkOHPs]  WITH CHECK ADD  CONSTRAINT [FK_tblNetworkOHPs_tblOHQualifications] FOREIGN KEY([fkOHQualification])
REFERENCES [dbo].[tblOHQualifications] ([uidOHQualification])
GO
ALTER TABLE [dbo].[tblNetworkOHPs] CHECK CONSTRAINT [FK_tblNetworkOHPs_tblOHQualifications]
GO
ALTER TABLE [dbo].[tblOHPClinics]  WITH CHECK ADD  CONSTRAINT [FK_tblOHPClinics_tblCountries] FOREIGN KEY([strCountry])
REFERENCES [dbo].[tblCountries] ([PKCountryCode])
GO
ALTER TABLE [dbo].[tblOHPClinics] CHECK CONSTRAINT [FK_tblOHPClinics_tblCountries]
GO
ALTER TABLE [dbo].[tblOHPClinics]  WITH CHECK ADD  CONSTRAINT [FK_tblOHPClinics_tblOHPClinics] FOREIGN KEY([fkAdminCentre])
REFERENCES [dbo].[tblOHPClinics] ([uidClinic])
GO
ALTER TABLE [dbo].[tblOHPClinics] CHECK CONSTRAINT [FK_tblOHPClinics_tblOHPClinics]
GO
ALTER TABLE [dbo].[tblScannedDocumentTypes]  WITH CHECK ADD  CONSTRAINT [FK_tblScannedDocumentTypes_tblInvuDocumentTypes] FOREIGN KEY([FkInvuDocType])
REFERENCES [dbo].[tblInvuDocumentTypes] ([ID])
GO
ALTER TABLE [dbo].[tblScannedDocumentTypes] CHECK CONSTRAINT [FK_tblScannedDocumentTypes_tblInvuDocumentTypes]
GO
ALTER TABLE [dbo].[tblTemplateButtons]  WITH CHECK ADD  CONSTRAINT [FK_tblTemplateButtons_tblButtonGroups] FOREIGN KEY([fkButtonGroup])
REFERENCES [dbo].[tblButtonGroups] ([uidButtonGroup])
GO
ALTER TABLE [dbo].[tblTemplateButtons] CHECK CONSTRAINT [FK_tblTemplateButtons_tblButtonGroups]
GO
ALTER TABLE [dbo].[tblTemplateButtons]  WITH CHECK ADD  CONSTRAINT [FK_tblTemplateButtons_tblTemplates] FOREIGN KEY([fkTemplate])
REFERENCES [dbo].[tblTemplates] ([uidTemplate])
GO
ALTER TABLE [dbo].[tblTemplateButtons] CHECK CONSTRAINT [FK_tblTemplateButtons_tblTemplates]
GO
ALTER TABLE [dbo].[tblTemplates]  WITH CHECK ADD  CONSTRAINT [FK_tblTemplates_tblInvuDocumentTypes] FOREIGN KEY([fkInvuDocType])
REFERENCES [dbo].[tblInvuDocumentTypes] ([ID])
GO
ALTER TABLE [dbo].[tblTemplates] CHECK CONSTRAINT [FK_tblTemplates_tblInvuDocumentTypes]
GO
ALTER TABLE [Lookup].[LookupItem]  WITH CHECK ADD  CONSTRAINT [FK_LookupItem_Lookup] FOREIGN KEY([LookupId])
REFERENCES [Lookup].[Lookup] ([Id])
GO
ALTER TABLE [Lookup].[LookupItem] CHECK CONSTRAINT [FK_LookupItem_Lookup]
GO
ALTER TABLE [Lookup].[LookupItem]  WITH CHECK ADD  CONSTRAINT [FK_LookupItemParent_LookupItem] FOREIGN KEY([ParentId])
REFERENCES [Lookup].[LookupItem] ([Id])
GO
ALTER TABLE [Lookup].[LookupItem] CHECK CONSTRAINT [FK_LookupItemParent_LookupItem]
GO
ALTER TABLE [Referral].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Ethnicity] FOREIGN KEY([EthnicityId])
REFERENCES [Lookup].[LookupItem] ([Id])
GO
ALTER TABLE [Referral].[Employee] CHECK CONSTRAINT [FK_Employee_Ethnicity]
GO
ALTER TABLE [Referral].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_NumberHours] FOREIGN KEY([NumberOfHoursId])
REFERENCES [Lookup].[LookupItem] ([Id])
GO
ALTER TABLE [Referral].[Employee] CHECK CONSTRAINT [FK_Employee_NumberHours]
GO
ALTER TABLE [Referral].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_WorkHours] FOREIGN KEY([WorkHoursId])
REFERENCES [Lookup].[LookupItem] ([Id])
GO
ALTER TABLE [Referral].[Employee] CHECK CONSTRAINT [FK_Employee_WorkHours]
GO
ALTER TABLE [Referral].[EmployeeDisability]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeDisability_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [Referral].[Employee] ([Id])
GO
ALTER TABLE [Referral].[EmployeeDisability] CHECK CONSTRAINT [FK_EmployeeDisability_Employee]
GO
ALTER TABLE [Referral].[EmployeeDisability]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeDisability_LookupItem] FOREIGN KEY([DisabilityId])
REFERENCES [Lookup].[LookupItem] ([Id])
GO
ALTER TABLE [Referral].[EmployeeDisability] CHECK CONSTRAINT [FK_EmployeeDisability_LookupItem]
GO
ALTER TABLE [Referral].[Employer]  WITH CHECK ADD  CONSTRAINT [FK_Employer_EmployerSize] FOREIGN KEY([EmployerSizeId])
REFERENCES [Lookup].[LookupItem] ([Id])
GO
ALTER TABLE [Referral].[Employer] CHECK CONSTRAINT [FK_Employer_EmployerSize]
GO
ALTER TABLE [Referral].[Employer]  WITH CHECK ADD  CONSTRAINT [FK_Employer_IndustrySector] FOREIGN KEY([IndustrySectorId])
REFERENCES [Lookup].[LookupItem] ([Id])
GO
ALTER TABLE [Referral].[Employer] CHECK CONSTRAINT [FK_Employer_IndustrySector]
GO
ALTER TABLE [Referral].[EmployerService]  WITH CHECK ADD  CONSTRAINT [FK_EmployerService_Employer] FOREIGN KEY([EmployerId])
REFERENCES [Referral].[Employer] ([Id])
GO
ALTER TABLE [Referral].[EmployerService] CHECK CONSTRAINT [FK_EmployerService_Employer]
GO
ALTER TABLE [Referral].[EmployerService]  WITH CHECK ADD  CONSTRAINT [FK_EmployerService_ServiceLookupItem] FOREIGN KEY([ServiceId])
REFERENCES [Lookup].[LookupItem] ([Id])
GO
ALTER TABLE [Referral].[EmployerService] CHECK CONSTRAINT [FK_EmployerService_ServiceLookupItem]
GO
ALTER TABLE [Referral].[Referral]  WITH CHECK ADD  CONSTRAINT [FK_Referral_Employer] FOREIGN KEY([EmployerId])
REFERENCES [Referral].[Employer] ([Id])
GO
ALTER TABLE [Referral].[Referral] CHECK CONSTRAINT [FK_Referral_Employer]
GO
ALTER TABLE [Referral].[Referral]  WITH CHECK ADD  CONSTRAINT [FK_Referral_GeneralPractitioner] FOREIGN KEY([GeneralPracticionerId])
REFERENCES [Referral].[GeneralPractitioner] ([Id])
GO
ALTER TABLE [Referral].[Referral] CHECK CONSTRAINT [FK_Referral_GeneralPractitioner]
GO
ALTER TABLE [Referral].[Referral]  WITH CHECK ADD  CONSTRAINT [FK_Referral_ReferralEligibility] FOREIGN KEY([ReferralEligibilityId])
REFERENCES [Referral].[ReferralEligibility] ([Id])
GO
ALTER TABLE [Referral].[Referral] CHECK CONSTRAINT [FK_Referral_ReferralEligibility]
GO
ALTER TABLE [Resources].[CTATeam]  WITH CHECK ADD  CONSTRAINT [FK_CTATeam_Client] FOREIGN KEY([ClientId])
REFERENCES [Resources].[Client] ([Id])
GO
ALTER TABLE [Resources].[CTATeam] CHECK CONSTRAINT [FK_CTATeam_Client]
GO
ALTER TABLE [Resources].[Resource]  WITH CHECK ADD  CONSTRAINT [FK_Resource_CTATeam] FOREIGN KEY([CTATeamId])
REFERENCES [Resources].[CTATeam] ([Id])
GO
ALTER TABLE [Resources].[Resource] CHECK CONSTRAINT [FK_Resource_CTATeam]
GO
ALTER TABLE [Resources].[ResourceSkill]  WITH CHECK ADD  CONSTRAINT [FK_ResourceSkill_Resource] FOREIGN KEY([ResourceId])
REFERENCES [Resources].[Resource] ([Id])
GO
ALTER TABLE [Resources].[ResourceSkill] CHECK CONSTRAINT [FK_ResourceSkill_Resource]
GO
ALTER TABLE [Resources].[ResourceSkill]  WITH CHECK ADD  CONSTRAINT [FK_ResourceSkill_Skill] FOREIGN KEY([SkillId])
REFERENCES [Resources].[Skill] ([Id])
GO
ALTER TABLE [Resources].[ResourceSkill] CHECK CONSTRAINT [FK_ResourceSkill_Skill]
GO
ALTER TABLE [Template].[GenericTemplateText]  WITH CHECK ADD  CONSTRAINT [FK_GenericTemplateText_GenericTemaplte] FOREIGN KEY([GenericTemplateId])
REFERENCES [Template].[GenericTemplate] ([Id])
GO
ALTER TABLE [Template].[GenericTemplateText] CHECK CONSTRAINT [FK_GenericTemplateText_GenericTemaplte]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sort of joins to Case.CaseFamily but isn''t strictly a foreign key.' , @level0type=N'SCHEMA',@level0name=N'Case', @level1type=N'TABLE',@level1name=N'Case', @level2type=N'COLUMN',@level2name=N'CaseFamilyId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Task occurs how many days after fme when client still not informed' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGlobalVars', @level2type=N'COLUMN',@level2name=N'intFMEInformClientChase'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'order for display and in grids' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSpecialisations', @level2type=N'COLUMN',@level2name=N'intOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'is this a current specialisation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSpecialisations', @level2type=N'COLUMN',@level2name=N'isActive'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Until full logging is there for button events, use for checking about HM050 certificate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblTemplateButtons', @level2type=N'COLUMN',@level2name=N'isDateCert'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblOHPClinics"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 36
         End
         Begin Table = "tblClinic2OHP"
            Begin Extent = 
               Top = 6
               Left = 259
               Bottom = 125
               Right = 419
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblNetworkOHPs"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblAdminCentres"
            Begin Extent = 
               Top = 126
               Left = 259
               Bottom = 245
               Right = 442
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblOHPAdminCentre"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 365
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblOHQualifications"
            Begin Extent = 
               Top = 246
               Left = 259
               Bottom = 365
               Right = 436
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWi' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwClinic2OHPDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'dths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwClinic2OHPDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwClinic2OHPDetail'
GO
USE [master]
GO
ALTER DATABASE [HWSInternal] SET  READ_WRITE 
GO
