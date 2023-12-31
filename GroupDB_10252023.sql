USE [master]
GO
/****** Object:  Database [GroupDB]    Script Date: 10/19/2023 5:26:21 PM ******/
CREATE DATABASE [GroupDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GroupDB', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\GroupDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'GroupDB_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\GroupDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [GroupDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GroupDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GroupDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GroupDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GroupDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GroupDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GroupDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [GroupDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GroupDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GroupDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GroupDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GroupDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GroupDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GroupDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GroupDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GroupDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GroupDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GroupDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GroupDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GroupDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GroupDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GroupDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GroupDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GroupDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GroupDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [GroupDB] SET  MULTI_USER 
GO
ALTER DATABASE [GroupDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GroupDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GroupDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GroupDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GroupDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GroupDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [GroupDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [GroupDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [GroupDB]
GO
/****** Object:  User [GroupTestAdmin]    Script Date: 10/19/2023 5:26:21 PM ******/
CREATE USER [GroupTestAdmin] FOR LOGIN [GroupDBAdmin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [GroupTestAdmin]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 10/19/2023 5:26:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[dbo].[Comments]', N'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Comments](
	[CommentID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NULL,
	[Tags] [nvarchar](max) NULL,
	[PostContent] [nvarchar](max) NULL,
	[Timestamp] [smalldatetime] NOT NULL,
	[Images] [nvarchar](max) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
ELSE
BEGIN
ALTER TABLE [dbo].[Comments]
ADD [Active] [bit] NOT NULL
END
GO
/****** Object:  Table [dbo].[Comments_Users_Assoc]    Script Date: 10/19/2023 5:26:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Comments_Users_Assoc]', N'U') IS NULL
CREATE TABLE [dbo].[Comments_Users_Assoc](
	[CommentID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[ParentID] [int] NULL
) ON [PRIMARY]
ELSE
BEGIN
ALTER TABLE [dbo].[Comments]
ADD [ParentID] [int] NULL,
	[RootID] [int] NULL
END
GO
/****** Object:  Table [dbo].[Users]    Script Date: 10/19/2023 5:26:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Users]', N'U') IS NULL
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](max) NOT NULL,
	[Email] [varchar](50) NULL,
 CONSTRAINT [PK_Users_1] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Comments] ADD  CONSTRAINT [DF_Comments_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Comments_Users_Assoc]  WITH CHECK ADD  CONSTRAINT [FK__Comments___Comme__2A164134] FOREIGN KEY([CommentID])
REFERENCES [dbo].[Comments] ([CommentID])
GO
ALTER TABLE [dbo].[Comments_Users_Assoc] CHECK CONSTRAINT [FK__Comments___Comme__2A164134]
GO
ALTER TABLE [dbo].[Comments_Users_Assoc]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
/****** Object:  StoredProcedure [dbo].[AddComment]    Script Date: 10/19/2023 5:26:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Siuki Chow	
-- Create date: Oct 14, 2023
-- Description:	Add Topic and returns the new Topic
-- =============================================

CREATE OR ALTER PROCEDURE [dbo].[AddComment] 
	-- Add the parameters for the stored procedure here
	@userid INT,
	@title VARCHAR(MAX),
	@content VARCHAR(MAX),
	@timestamp DateTime,
	@images VARCHAR(MAX),
	@parentid INT,
	@rootid INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @comment TABLE (commentid INT)
	DECLARE @id INT

	IF (@parentid != NULL)
		IF (@images != NULL)
			INSERT INTO Comments (PostContent, Timestamp, Images) OUTPUT INSERTED.CommentID INTO @comment VALUES (@content, CONVERT(DATETIME, @timestamp, 102), @images)
		ELSE
			INSERT INTO Comments (PostContent, Timestamp) OUTPUT INSERTED.CommentID INTO @comment VALUES (@content, CONVERT(DATETIME, @timestamp, 102))
	ELSE
		INSERT INTO Comments (Title, PostContent, Timestamp) OUTPUT INSERTED.CommentID INTO @comment VALUES (@title, @content, CONVERT(DATETIME, @timestamp, 102))

	SET @id = (SELECT commentid FROM @comment)
	IF (@rootid IS NULL)
		INSERT INTO Comments_Users_Assoc VALUES (@id, @userid, @parentid, @id)
	ELSE
		INSERT INTO Comments_Users_Assoc VALUES (@id, @userid, @parentid, @rootid)

	SELECT * FROM Comments WHERE CommentID = @id
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteComment]    Script Date: 10/19/2023 5:26:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Siuki Chow
-- Create date: Oct 16, 2023
-- Description:	Deletes comment by changing it from being active
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[DeleteComment] 
	-- Add the parameters for the stored procedure here
	@commentid int, 
	@userid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Comments
	SET Active = 0
		WHERE CommentID = (SELECT C.CommentID
								FROM Comments AS C, Comments_Users_Assoc AS CU
								WHERE CU.UserID = @userid AND CU.CommentID = C.CommentID AND C.CommentID = @commentid)

	SELECT * FROM Comments WHERE CommentID = @commentid
END
GO
/****** Object:  StoredProcedure [dbo].[EditComment]    Script Date: 10/19/2023 5:26:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Siuki Chow
-- Create date: Oct 16, 2023
-- Description:	Edit specific comment
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[EditComment]
	-- Add the parameters for the stored procedure here
	@commentid INT,
	@userid INT,
	@content VARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Comments
	SET PostContent = @content
	WHERE CommentID = (SELECT C.CommentID
							FROM Comments AS C, Comments_Users_Assoc AS CU
							WHERE CU.UserID = @userid AND CU.CommentID = C.CommentID AND C.CommentID = @commentid)

	SELECT * FROM Comments WHERE CommentID = @commentid
END
GO
/****** Object:  StoredProcedure [dbo].[FindAllComments]    Script Date: 10/19/2023 5:26:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Siuki Chow
-- Create date: Oct 16, 2023
-- Description:	Retrieves all comments
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[FindAllComments]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT C.*, U.UserID, U.UserName, CU.RootID
		FROM Comments AS C, Users AS U, Comments_Users_Assoc AS CU
		WHERE C.Active = 1 AND C.CommentID = CU.CommentID AND U.UserID = CU.UserID
		ORDER BY C.Timestamp DESC
END
GO
/****** Object:  StoredProcedure [dbo].[FindAllTopics]    Script Date: 10/19/2023 5:26:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Siuki Chow
-- Create date: Oct 18, 2023
-- Description:	Retrieves all parent topics
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[FindAllTopics] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT C.*, U.UserID, U.UserName, CU.RootID
		FROM Comments AS C, Users AS U, Comments_Users_Assoc AS CU
		WHERE C.Active = 1 AND C.CommentID = CU.CommentID AND U.UserID = CU.UserID AND CU.ParentID IS NULL
		ORDER BY C.Timestamp DESC
END
GO
/****** Object:  StoredProcedure [dbo].[FindChildComments]    Script Date: 10/19/2023 5:26:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Siuki Chow
-- Create date: Oct 18, 2023
-- Description:	Retrieves all child comments from parent comment
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[FindChildComments]
	-- Add the parameters for the stored procedure here
	@parentid INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT C.*, U.UserID, U.UserName, CU.RootID
		FROM Comments AS C, Users AS U, Comments_Users_Assoc AS CU
		WHERE CU.ParentID = @parentid AND C.CommentID = CU.CommentID AND U.UserID = CU.UserID AND C.Active = 1
		ORDER BY C.Timestamp ASC
END
GO
/****** Object:  StoredProcedure [dbo].[FindComment]    Script Date: 10/19/2023 5:26:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Siuki Chow
-- Create date: Oct 18, 2023
-- Description:	Retrieves a specific comment by CommentID
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[FindComment] 
	-- Add the parameters for the stored procedure here
	@commentid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT C.*, U.UserID, U.UserName, CU.RootID
		FROM Comments AS C, Users AS U, Comments_Users_Assoc AS CU
		WHERE C.CommentID = @commentid AND C.Active = 1 AND C.CommentID = CU.CommentID AND U.UserID = CU.UserID
END
GO
/****** Object:  StoredProcedure [dbo].[FindComments]    Script Date: 10/23/2023 5:49:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Siuki Chow
-- Create date: Oct 22, 2023
-- Description:	Retrieves list of comments matching query
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[FindComments]
	-- Add the parameters for the stored procedure here
	@queryParam VARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @queryParam = '%' + @queryParam +'%'

    -- Insert statements for procedure here
	SELECT C.*, U.UserID, U.UserName, CU.RootID
		FROM Comments AS C, Users AS U, Comments_Users_Assoc AS CU
		WHERE C.CommentID = CU.CommentID AND U.UserID = CU.UserID AND C.Active = 1 AND
			PostContent LIKE @queryParam
		ORDER BY C.Timestamp DESC
END
/****** Object:  StoredProcedure [dbo].[FindRecentComments]    Script Date: 10/19/2023 5:26:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Siuki Chow
-- Create date: Oct 16, 2023
-- Description: Retrieves the 3 most recent comments
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[FindRecentComments]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP (3) C.*, U.UserID, U.UserName, CU.RootID
		FROM Comments AS C, Users AS U, Comments_Users_Assoc AS CU
		WHERE C.Active = 1 AND C.CommentID = CU.CommentID AND U.UserID = CU.UserID
		ORDER BY C.Timestamp DESC
END
GO
/****** Object:  StoredProcedure [dbo].[FindRecentTopics]    Script Date: 10/19/2023 5:26:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Siuki Chow
-- Create date: Oct 18, 2023
-- Description:	Retrieves the 3 most recent topics
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[FindRecentTopics]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP (3) C.*, U.UserID, U.UserName, CU.RootID
		FROM Comments AS C, Users AS U, Comments_Users_Assoc AS CU
		WHERE C.Active = 1 AND C.CommentID = CU.CommentID AND U.UserID = CU.UserID AND CU.ParentID IS NULL
		ORDER BY C.Timestamp DESC
END
GO
/****** Object:  StoredProcedure [dbo].[FindUser]    Script Date: 10/19/2023 5:26:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Siuki Chow
-- Create date: Oct 18, 2023
-- Description:	Retrieves user by UserID
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[FindUser]
	-- Add the parameters for the stored procedure here
	@userid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT UserID, UserName FROM Users WHERE UserID = @userid
END
GO
/****** Object:  StoredProcedure [dbo].[FindUserComments]    Script Date: 10/22/2023 6:14:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Siuki Chow
-- Create date: Oct 21, 2023
-- Description:	Retrieve user's comments
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[FindUserComments] 
	-- Add the parameters for the stored procedure here
	@userid INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT C.*, U.UserID, U.UserName, CU.RootID
		FROM Comments AS C, Users AS U, Comments_Users_Assoc AS CU
		WHERE U.UserID = @userid AND C.Active = 1 AND C.CommentID = CU.CommentID AND U.UserID = CU.UserID
		ORDER BY C.Timestamp ASC
END
/****** Object:  StoredProcedure [dbo].[QueryUser]    Script Date: 10/19/2023 5:26:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Siuki Chow
-- Create date: Oct 14, 2023
-- Description:	Query User by Username
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[QueryUser] 
	-- Add the parameters for the stored procedure here
	@username VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Users WHERE UserName = @username
END
GO
/****** Object:  StoredProcedure [dbo].[SignUp]    Script Date: 10/19/2023 5:26:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Siuki Chow
-- Create date: Oct 14, 2023
-- Description:	Creates Account and returns UserID
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[SignUp] 
	-- Add the parameters for the stored procedure here
	@username VARCHAR(50), 
	@password VARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @user VARCHAR(50) = (SELECT UserName FROM Users WHERE UserName = @username)
    -- Insert statements for procedure here
	IF @user IS NULL
		INSERT INTO Users (UserName, Password) VALUES (@username, @password)

	SELECT UserID FROM Users WHERE UserName = @username
END
GO
USE [master]
GO
ALTER DATABASE [GroupDB] SET  READ_WRITE 
GO
