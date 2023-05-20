DROP DATABASE Kickstarter
GO
CREATE DATABASE Kickstarter
GO
ALTER DATABASE Kickstarter
SET RECOVERY SIMPLE
GO

USE Kickstarter
;

-- Create a schema to hold user views (set schema name on home page of workbook).
-- It would be good to do this only if the schema doesn't exist already.
GO
CREATE SCHEMA Kickstarter
GO


/* Drop table Kickstarter.DimCreator */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Kickstarter.DimCreator') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE Kickstarter.DimCreator
;

/* Create table Kickstarter.DimCreator */
CREATE TABLE Kickstarter.DimCreator(
   [CreatorId]               int          NOT NULL
,  [CreatorName]             char(250)    NOT NULL
, CONSTRAINT [PK_Kickstarter.DimCreator] PRIMARY KEY CLUSTERED 
( [CreatorId] )
) ON [PRIMARY]
;

INSERT INTO Kickstarter.DimCreator (CreatorId, CreatorName)
VALUES (001, 'The ETL')
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[Kickstarter].[Creator]'))
DROP VIEW [Kickstarter].[Creator]
GO
CREATE VIEW [Kickstarter].[Creator] AS 
SELECT [creatorId] AS [creatorId]
, [creatorName] AS [creatorName]
FROM Kickstarter.DimCreator
GO


/* Create table Kickstarter.DimProject */
CREATE TABLE Kickstarter.DimProject(
   [ProjectId]             int          NOT NULL
,  [ProjectName]           char(250)    NOT NULL
, CONSTRAINT [PK_Kickstarter.DimProject] PRIMARY KEY CLUSTERED 
( [projectId] )
) ON [PRIMARY]
;

INSERT INTO Kickstarter.DimProject (ProjectId, ProjectName )
VALUES (7217, 'ETL')
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[Kickstarter].[Project]'))
DROP VIEW [Kickstarter].[Project]
GO
CREATE VIEW [Kickstarter].[Project] AS 
SELECT [ProjectId] AS [ProjectId]
, [ProjectName] AS [ProjectName]
FROM Kickstarter.DimProject
GO

/* Drop table Kickstarter.DimDate */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Kickstarter.DimDate') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE Kickstarter.DimDate 
;

/* Create table Kickstarter.DimDate */
CREATE TABLE Kickstarter.DimDate (
   [CreatedAt]   date NOT NULL
,  [Deadline]   date NOT NULL
, CONSTRAINT [PK_Kickstarter.DimDate] PRIMARY KEY CLUSTERED 
( [CreatedAt] )
) ON [PRIMARY]
;

SET IDENTITY_INSERT Kickstarter.DimDate ON
;
INSERT INTO Kickstarter.DimDate (CreatedAt, Deadline)
VALUES ('29 Mei 2023', '29 Mei 2023')
;
SET IDENTITY_INSERT Kickstarter.DimDate OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[Kickstarter].[Date]'))
DROP VIEW [ Kickstarter].[Date]
GO
CREATE VIEW [Kickstarter].[Date] AS 
SELECT [CreatedAt] AS [CreatedAt]
,  [Deadline] AS [Deadline]
FROM Kickstarter.DimDate
GO


/* Drop table Kickstarter.DimLocation */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Kickstarter.DimLocation') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE Kickstarter.DimLocation
;

/* Create table Kickstarter.DimLocation */
CREATE TABLE Kickstarter.DimLocation (
   [CountryId]    int        NOT NULL
,  [CountryName]  char(250)  NOT NULL
, CONSTRAINT [PK_Kickstarter.DimLocation] PRIMARY KEY CLUSTERED 
( [CountryId] )
) ON [PRIMARY]
;

SET IDENTITY_INSERT Kickstarter.DimLocation ON
;
INSERT INTO Kickstarter.DimLocation (CountryId, CountryName)
VALUES (29, 'Nepal')
;
SET IDENTITY_INSERT Kickstarter.DimLocation OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[ Kickstarter].[Location]'))
DROP VIEW [ Kickstarter].[Location]
GO
CREATE VIEW [Kickstarter].[Location] AS 
SELECT [CountryId] AS [CountryId]
,  [CountryName] AS [CountryName]
FROM Kickstarter.DimLocation
GO


/* Drop table Kickstarter.FactCampaign */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Kickstarter.FactCampaign') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE Kickstarter.FactCampaign
;

/* Create table Kickstarter.FactCampaign */
CREATE TABLE Kickstarter.FactCampaign(
   [CampaignId]   int    NOT NULL
,  [CreatorId]    int    NOT NULL
,  [CountryId]    int    NOT NULL
,  [CreatedAt]    Date   NOT NULL
,  [ProjectId]    int    NOT NULL
CONSTRAINT CompositeKey PRIMARY KEY ([CampaignId], [CreatorId], [CountryId], [CreatedAt], [ProjectId])
);

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[Kickstarter].[BookCampaign]'))
DROP VIEW [Kickstarter].[Campaign]
GO
CREATE VIEW [Kickstarter].[Campaign] AS 
SELECT [CampaignId] AS [CampaignId]
, [CreatorId] AS [CreatorId]
, [CountryId] AS [CountryId]
, [CreatedAt] AS [CreatedAt]
, [ProjectId] AS [ProjectId]
FROM Kickstarter.FactCampaign
GO

ALTER TABLE Kickstarter.FactCampaign ADD CONSTRAINT
   FK_Kickstarter_FactCampaign_CreatorId FOREIGN KEY
   (
   CreatorId
   ) REFERENCES Kickstarter.DimCreator
   ( CreatorId )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE Kickstarter.FactCampaign ADD CONSTRAINT
   FK_Kickstarter_FactCampaign_ProjectId FOREIGN KEY
   (
   ProjectId
   ) REFERENCES Kickstarter.DimProject
   ( ProjectId )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;

ALTER TABLE Kickstarter.FactCampaign ADD CONSTRAINT
   FK_Kickstarter_FactCampaign_CreatedAt FOREIGN KEY
   (
   CreatedAt
   ) REFERENCES Kickstarter.DimDate
   ( CreatedAt )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
 ALTER TABLE Kickstarter.FactCampaign ADD CONSTRAINT
   FK_Kickstarter_FactCampaign_CountryId FOREIGN KEY
   (
   CountryId
   ) REFERENCES Kickstarter.DimLocation
   ( CountryId )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
