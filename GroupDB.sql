USE [master]
GO
/****** Object:  Database [GroupDB]    Script Date: 10/16/2023 6:14:41 PM ******/
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
/****** Object:  User [GroupTestAdmin]    Script Date: 10/16/2023 6:14:41 PM ******/
CREATE USER [GroupTestAdmin] FOR LOGIN [GroupDBAdmin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [GroupTestAdmin]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 10/16/2023 6:14:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[CommentID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[Tags] [nvarchar](max) NULL,
	[PostContent] [nvarchar](max) NULL,
	[Timestamp] [smalldatetime] NOT NULL,
	[Images] [nvarchar](max) NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comments_Users_Assoc]    Script Date: 10/16/2023 6:14:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments_Users_Assoc](
	[CommentID] [int] NOT NULL,
	[UserID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 10/16/2023 6:14:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
ALTER TABLE [dbo].[Comments_Users_Assoc]  WITH CHECK ADD  CONSTRAINT [FK__Comments___Comme__2A164134] FOREIGN KEY([CommentID])
REFERENCES [dbo].[Comments] ([CommentID])
GO
ALTER TABLE [dbo].[Comments_Users_Assoc] CHECK CONSTRAINT [FK__Comments___Comme__2A164134]
GO
ALTER TABLE [dbo].[Comments_Users_Assoc]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
/****** Object:  StoredProcedure [dbo].[AddTopic]    Script Date: 10/16/2023 6:14:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Siuki Chow	
-- Create date: Oct 14, 2023
-- Description:	Add Topic and returns the new Topic
-- =============================================
CREATE PROCEDURE [dbo].[AddTopic] 
	-- Add the parameters for the stored procedure here
	@userid VARCHAR(50),
	@title VARCHAR(MAX),
	@content VARCHAR(MAX),
	@timestamp DateTime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @comment TABLE (commentid INT)
	INSERT INTO Comments (Title, PostContent, Timestamp) OUTPUT INSERTED.CommentID INTO @comment VALUES (@title, @content, CONVERT(DATETIME, @timestamp, 102))
	INSERT INTO Comments_Users_Assoc VALUES ((SELECT commentid FROM @comment), @userid)
	SELECT * FROM Comments WHERE CommentID = (SELECT commentid FROM @comment)
END
GO
/****** Object:  StoredProcedure [dbo].[FindAllTopics]    Script Date: 10/16/2023 6:14:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FindAllTopics]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT C.*, U.UserID, U.UserName FROM Comments AS C, Users AS U, Comments_Users_Assoc AS CU WHERE C.CommentID = CU.CommentID AND U.UserID = CU.UserID ORDER BY Timestamp DESC
END
GO
/****** Object:  StoredProcedure [dbo].[FindRecentTopics]    Script Date: 10/16/2023 6:14:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FindRecentTopics]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP (5) C.*, U.UserID, U.UserName FROM Comments AS C, Users AS U, Comments_Users_Assoc AS CU WHERE C.CommentID = CU.CommentID AND U.UserID = CU.UserID ORDER BY Timestamp DESC
END
GO
/****** Object:  StoredProcedure [dbo].[QueryUser]    Script Date: 10/16/2023 6:14:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Siuki Chow
-- Create date: Oct 14, 2023
-- Description:	Query User by Username
-- =============================================
CREATE PROCEDURE [dbo].[QueryUser] 
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
/****** Object:  StoredProcedure [dbo].[SignUp]    Script Date: 10/16/2023 6:14:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Siuki Chow
-- Create date: Oct 14, 2023
-- Description:	Creates Account and returns UserID
-- =============================================
CREATE PROCEDURE [dbo].[SignUp] 
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
