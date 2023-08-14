USE [master]
GO
/****** Object:  Database [Monster]    Script Date: 17/07/2023 16:15:48 ******/
CREATE DATABASE [Monster]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Monster', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Monster.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Monster_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Monster_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Monster] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Monster].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Monster] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Monster] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Monster] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Monster] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Monster] SET ARITHABORT OFF 
GO
ALTER DATABASE [Monster] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Monster] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Monster] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Monster] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Monster] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Monster] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Monster] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Monster] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Monster] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Monster] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Monster] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Monster] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Monster] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Monster] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Monster] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Monster] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Monster] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Monster] SET RECOVERY FULL 
GO
ALTER DATABASE [Monster] SET  MULTI_USER 
GO
ALTER DATABASE [Monster] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Monster] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Monster] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Monster] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Monster] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Monster] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Monster', N'ON'
GO
ALTER DATABASE [Monster] SET QUERY_STORE = OFF
GO
USE [Monster]
GO
/****** Object:  Table [dbo].[beach_items]    Script Date: 17/07/2023 16:15:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[beach_items](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[item] [nvarchar](50) NOT NULL,
	[explanation] [nvarchar](500) NULL,
 CONSTRAINT [PK_beach_items] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_beach_items]    Script Date: 17/07/2023 16:15:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_beach_items]
AS
SELECT id, item, explanation, 'beach' AS origin
FROM   dbo.beach_items
GO
/****** Object:  Table [dbo].[location]    Script Date: 17/07/2023 16:15:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[location](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[location_type] [nvarchar](50) NULL,
	[location_parent_id] [int] NULL,
 CONSTRAINT [PK_location] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[person]    Script Date: 17/07/2023 16:15:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[person](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
	[occupation] [nvarchar](50) NULL,
	[location_id] [int] NULL,
 CONSTRAINT [PK_person] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[personal_items]    Script Date: 17/07/2023 16:15:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[personal_items](
	[id] [int] IDENTITY(100,1) NOT NULL,
	[person_id] [int] NOT NULL,
	[item] [nvarchar](50) NOT NULL,
	[explanation] [nvarchar](500) NULL,
 CONSTRAINT [PK_personal_items] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_all_items]    Script Date: 17/07/2023 16:15:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_all_items]
AS
SELECT id, item, explanation, 'beach' AS origin
FROM   dbo.beach_items
UNION
SELECT pi.id, pi.item, pi.explanation, l.name AS origin
FROM   dbo.personal_items pi INNER JOIN
             dbo.person p ON pi.person_id = p.id
inner join dbo.location l on p.location_id = l.id
GO
/****** Object:  View [dbo].[v_inn]    Script Date: 17/07/2023 16:15:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_inn]
AS
SELECT TOP (100) PERCENT inn.id, inn.name, village.name AS village
FROM   dbo.location AS inn LEFT OUTER JOIN
             dbo.location AS village ON inn.location_parent_id = village.id
WHERE (inn.location_type = 'Inn')
GO
/****** Object:  View [dbo].[v_person]    Script Date: 17/07/2023 16:15:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_person]
AS
SELECT dbo.person.id, dbo.person.name, dbo.person.occupation, dbo.location.name AS location
FROM   dbo.location INNER JOIN
             dbo.person ON dbo.location.id = dbo.person.location_id
GO
/****** Object:  Table [dbo].[bonus_items]    Script Date: 17/07/2023 16:15:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bonus_items](
	[id] [int] IDENTITY(200,1) NOT NULL,
	[item] [nvarchar](50) NOT NULL,
	[explanation] [nvarchar](500) NULL,
 CONSTRAINT [PK_bonus_items] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[inventory]    Script Date: 17/07/2023 16:15:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[inventory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[item] [nvarchar](50) NULL,
	[origin] [nvarchar](50) NULL,
	[username] [nvarchar](50) NULL,
 CONSTRAINT [PK_inventory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[kill_strategy]    Script Date: 17/07/2023 16:15:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kill_strategy](
	[id] [int] NOT NULL,
	[strategy] [nvarchar](250) NULL,
 CONSTRAINT [PK_kill_strategy] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[monster]    Script Date: 17/07/2023 16:15:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[monster](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
	[strength] [nvarchar](50) NULL,
	[weakness] [nvarchar](50) NULL,
 CONSTRAINT [PK_monster] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[quest]    Script Date: 17/07/2023 16:15:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[quest](
	[id] [int] NOT NULL,
	[person_id] [int] NOT NULL,
	[quest] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[solution]    Script Date: 17/07/2023 16:15:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solution](
	[id] [int] NOT NULL,
	[location_id] [int] NOT NULL,
	[monster_id] [int] NOT NULL,
	[kill_strategy_id] [int] NOT NULL,
	[item_id] [int] NULL,
	[message_id] [int] NULL,
 CONSTRAINT [PK_solution] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[solution_messages]    Script Date: 17/07/2023 16:15:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solution_messages](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[message_type] [nvarchar](20) NULL,
	[message] [nvarchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[village_items]    Script Date: 17/07/2023 16:15:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[village_items](
	[id] [int] IDENTITY(100,1) NOT NULL,
	[village_id] [int] NOT NULL,
	[person_id] [int] NOT NULL,
	[item] [nvarchar](50) NOT NULL,
	[explanation] [nvarchar](500) NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[beach_items] ON 

INSERT [dbo].[beach_items] ([id], [item], [explanation]) VALUES (1, N'driftwood', N'Can be used for making a fire or building a shelter.')
INSERT [dbo].[beach_items] ([id], [item], [explanation]) VALUES (2, N'small knife', NULL)
INSERT [dbo].[beach_items] ([id], [item], [explanation]) VALUES (3, N'matches', NULL)
INSERT [dbo].[beach_items] ([id], [item], [explanation]) VALUES (4, N'clothes', NULL)
INSERT [dbo].[beach_items] ([id], [item], [explanation]) VALUES (5, N'rope', NULL)
INSERT [dbo].[beach_items] ([id], [item], [explanation]) VALUES (6, N'paper', NULL)
INSERT [dbo].[beach_items] ([id], [item], [explanation]) VALUES (7, N'candle', N'A little light in the darkness. Can be used to check for monsters under your bed.')
INSERT [dbo].[beach_items] ([id], [item], [explanation]) VALUES (8, N'plate', NULL)
INSERT [dbo].[beach_items] ([id], [item], [explanation]) VALUES (9, N'cup', NULL)
INSERT [dbo].[beach_items] ([id], [item], [explanation]) VALUES (10, N'whisky', N'Aged single malt scottish whisky. Can be used to clean wounds, numb pain and act as liquid courage.')
INSERT [dbo].[beach_items] ([id], [item], [explanation]) VALUES (11, N'rum', NULL)
INSERT [dbo].[beach_items] ([id], [item], [explanation]) VALUES (12, N'bag of coins', NULL)
SET IDENTITY_INSERT [dbo].[beach_items] OFF
GO
SET IDENTITY_INSERT [dbo].[inventory] ON 

INSERT [dbo].[inventory] ([id], [item], [origin], [username]) VALUES (1, N'local lettuce', N'Aintree', N'WORK\igr20127')
INSERT [dbo].[inventory] ([id], [item], [origin], [username]) VALUES (2, N'paper', N'beach', N'WORK\igr20127')
SET IDENTITY_INSERT [dbo].[inventory] OFF
GO
INSERT [dbo].[kill_strategy] ([id], [strategy]) VALUES (1, N'Drop a rock on its head')
INSERT [dbo].[kill_strategy] ([id], [strategy]) VALUES (2, N'Tickle till it giggles helplessly')
INSERT [dbo].[kill_strategy] ([id], [strategy]) VALUES (3, N'Stomp on it')
INSERT [dbo].[kill_strategy] ([id], [strategy]) VALUES (4, N'Bore it to death with tedious jokes')
INSERT [dbo].[kill_strategy] ([id], [strategy]) VALUES (5, N'Kill it with kindness')
INSERT [dbo].[kill_strategy] ([id], [strategy]) VALUES (6, N'Clone yourself and let the clone do the killing')
INSERT [dbo].[kill_strategy] ([id], [strategy]) VALUES (7, N'Use a BFG9000 to blast it to smithereens')
INSERT [dbo].[kill_strategy] ([id], [strategy]) VALUES (8, N'Huff and puff and blow the house down on top of it')
INSERT [dbo].[kill_strategy] ([id], [strategy]) VALUES (9, N'Burn it to a crisp')
INSERT [dbo].[kill_strategy] ([id], [strategy]) VALUES (10, N'Barf on it')
INSERT [dbo].[kill_strategy] ([id], [strategy]) VALUES (11, N'Lock it in a dungeon untill it starves to death')
INSERT [dbo].[kill_strategy] ([id], [strategy]) VALUES (12, N'Wrap in tinfoil and zap it in de microwave')
INSERT [dbo].[kill_strategy] ([id], [strategy]) VALUES (13, N'Stick it with the pointy end')
INSERT [dbo].[kill_strategy] ([id], [strategy]) VALUES (14, N'Sing songs untill its ears blead')
INSERT [dbo].[kill_strategy] ([id], [strategy]) VALUES (15, N'Hire the divorse attorney of your ex')
INSERT [dbo].[kill_strategy] ([id], [strategy]) VALUES (16, N'Poison it')
INSERT [dbo].[kill_strategy] ([id], [strategy]) VALUES (17, N'Lure it to a saltmine with the local lettuce and let it melt into nothing')
GO
SET IDENTITY_INSERT [dbo].[location] ON 

INSERT [dbo].[location] ([id], [name], [location_type], [location_parent_id]) VALUES (1, N'SQL Island', N'Island', NULL)
INSERT [dbo].[location] ([id], [name], [location_type], [location_parent_id]) VALUES (2, N'Quatroformaggio', N'Village', 1)
INSERT [dbo].[location] ([id], [name], [location_type], [location_parent_id]) VALUES (3, N'Bloodwolves', N'Inn', 11)
INSERT [dbo].[location] ([id], [name], [location_type], [location_parent_id]) VALUES (4, N'Horse and Dragon', N'Inn', 6)
INSERT [dbo].[location] ([id], [name], [location_type], [location_parent_id]) VALUES (5, N'Hollow Bears', N'Inn', 13)
INSERT [dbo].[location] ([id], [name], [location_type], [location_parent_id]) VALUES (6, N'Aintree', N'Village', 1)
INSERT [dbo].[location] ([id], [name], [location_type], [location_parent_id]) VALUES (7, N'The Ugly Giraffe Inn', N'Inn', 11)
INSERT [dbo].[location] ([id], [name], [location_type], [location_parent_id]) VALUES (8, N'Sleepy Shark Pub', N'Inn', 17)
INSERT [dbo].[location] ([id], [name], [location_type], [location_parent_id]) VALUES (9, N'The Lions', N'Inn', 2)
INSERT [dbo].[location] ([id], [name], [location_type], [location_parent_id]) VALUES (10, N'Sun and Moon Pub', N'Inn', 16)
INSERT [dbo].[location] ([id], [name], [location_type], [location_parent_id]) VALUES (11, N'Triopolis', N'Village', 1)
INSERT [dbo].[location] ([id], [name], [location_type], [location_parent_id]) VALUES (12, N'Heavenly Dancers', N'Inn', 2)
INSERT [dbo].[location] ([id], [name], [location_type], [location_parent_id]) VALUES (13, N'Two Rivers', N'Village', 1)
INSERT [dbo].[location] ([id], [name], [location_type], [location_parent_id]) VALUES (14, N'Pentagram', N'Village', 1)
INSERT [dbo].[location] ([id], [name], [location_type], [location_parent_id]) VALUES (15, N'The Laughing Cabbage Tavern', N'Inn', 2)
INSERT [dbo].[location] ([id], [name], [location_type], [location_parent_id]) VALUES (16, N'Six Mile Creek', N'Village', 1)
INSERT [dbo].[location] ([id], [name], [location_type], [location_parent_id]) VALUES (17, N'Sevenoaks', N'Village', 1)
INSERT [dbo].[location] ([id], [name], [location_type], [location_parent_id]) VALUES (18, N'Saltmine', N'Mine', 6)
INSERT [dbo].[location] ([id], [name], [location_type], [location_parent_id]) VALUES (19, N'Bloodwolves', N'Inn', 14)
SET IDENTITY_INSERT [dbo].[location] OFF
GO
INSERT [dbo].[monster] ([id], [name], [strength], [weakness]) VALUES (25, N'Snails on speed', N'fast', N'local lettuce')
GO
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (1, N'Nora Steel', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (2, N'Stevie Adams', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (3, N'Vicente Amigo', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (4, N'Lola Flores', N'market vendor', 6)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (5, N'Ash Brown', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (6, N'Harry Palmer', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (7, N'Duncan Stone', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (8, N'Stevie Palmer', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (9, N'Paco de Lucia', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (10, N'Estrella Morente', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (11, N'Finn Marshall', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (12, N'Mary Skinner', N'innkeeper', 4)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (13, N'Luke King', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (14, N'Maria Robles', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (15, N'Carmen Linares', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (16, N'Prescott Knight', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (17, N'Pat Brown', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (18, N'La Perla de Cadiz', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (19, N'Patrick Hastings', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (20, N'Jesse Cook', N'market vendor', 6)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (21, N'Carlos Montoya', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (22, N'Antonio Canales', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (23, N'Miguel Poveda', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (24, N'Tony Campbell', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (25, N'Alex Prescott', NULL, NULL)
INSERT [dbo].[person] ([id], [name], [occupation], [location_id]) VALUES (26, N'Lucy Finn', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[personal_items] ON 

INSERT [dbo].[personal_items] ([id], [person_id], [item], [explanation]) VALUES (100, 4, N'iris', N'Noble flower, symbolises faith, courage, valour, hope and wisdom')
INSERT [dbo].[personal_items] ([id], [person_id], [item], [explanation]) VALUES (101, 4, N'rose', N'Symbolises love, affection and beauty.')
INSERT [dbo].[personal_items] ([id], [person_id], [item], [explanation]) VALUES (102, 4, N'lily', N'Tall, majestic and resilient.')
INSERT [dbo].[personal_items] ([id], [person_id], [item], [explanation]) VALUES (103, 4, N'poppy', N'Powerfull narcotic.')
INSERT [dbo].[personal_items] ([id], [person_id], [item], [explanation]) VALUES (104, 20, N'cucumber', N'Very delicious and nutricious')
INSERT [dbo].[personal_items] ([id], [person_id], [item], [explanation]) VALUES (105, 20, N'local lettuce', N'Local delicacy. Can be used to lure snails.')
INSERT [dbo].[personal_items] ([id], [person_id], [item], [explanation]) VALUES (106, 20, N'gherkin', N'Pickled baby cucumber.')
INSERT [dbo].[personal_items] ([id], [person_id], [item], [explanation]) VALUES (107, 20, N'pickle', N'Pickled cucumber.')
SET IDENTITY_INSERT [dbo].[personal_items] OFF
GO
INSERT [dbo].[quest] ([id], [person_id], [quest]) VALUES (1, 12, N'Lately, I find my Inn covered in slime in the mornings. It is quite a hassle to clean it off every day. The village elders suspect that we have a snail problem. I would like you to get rid of these snails for me. Then I will tell you what you need to know. But be aware that they are super fast. They will only slow down when they can eat some of our local lettuce. The market vendors outside can probably sell you some.')
GO
INSERT [dbo].[solution] ([id], [location_id], [monster_id], [kill_strategy_id], [item_id], [message_id]) VALUES (1, 18, 25, 17, 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[solution_messages] ON 

INSERT [dbo].[solution_messages] ([id], [message_type], [message]) VALUES (1, N'SUCCESS', N'You are awesome, you have succesfully slain the monster. You have earned a good nights rest, without any monsters under your bed.')
INSERT [dbo].[solution_messages] ([id], [message_type], [message]) VALUES (2, N'WRONG_STRATEGY', N'Unfortunately the monster excaped and left you in a right mess. Go back to the inn to take a shower and a nap so you can try again. But beware of monsters under your bed.')
INSERT [dbo].[solution_messages] ([id], [message_type], [message]) VALUES (3, N'WRONG_MONSTER', N'You may not be as smart as you think since this monster doesn''t live here.')
INSERT [dbo].[solution_messages] ([id], [message_type], [message]) VALUES (4, N'MISSING_ITEM', N'It looks like you are missing a crucial item for your quest in you inventory. You have no hope of slaying the monster without it. So back and search for it.')
INSERT [dbo].[solution_messages] ([id], [message_type], [message]) VALUES (5, N'WRONG_LOCATION', N'Well you could have been successfull in slaying the monster. If only you had chosen the correct location. So focus and try to remember where you are.')
INSERT [dbo].[solution_messages] ([id], [message_type], [message]) VALUES (6, N'EPIC_FAIL', N'This was an epic fail. Are you sure you want to continue with this adventure? You better start over from the beginning.')
SET IDENTITY_INSERT [dbo].[solution_messages] OFF
GO
SET IDENTITY_INSERT [dbo].[village_items] ON 

INSERT [dbo].[village_items] ([id], [village_id], [person_id], [item], [explanation]) VALUES (100, 1, 4, N'iris', N'Noble flower, symbolises faith, courage, valour, hope and wisdom')
INSERT [dbo].[village_items] ([id], [village_id], [person_id], [item], [explanation]) VALUES (101, 1, 4, N'rose', N'Symbolises love, affection and beauty.')
INSERT [dbo].[village_items] ([id], [village_id], [person_id], [item], [explanation]) VALUES (102, 1, 4, N'lily', N'Tall, majestic and resilient.')
INSERT [dbo].[village_items] ([id], [village_id], [person_id], [item], [explanation]) VALUES (103, 1, 4, N'poppy', N'Powerfull narcotic.')
INSERT [dbo].[village_items] ([id], [village_id], [person_id], [item], [explanation]) VALUES (104, 1, 20, N'cucumber', N'Very delicious and nutricious')
INSERT [dbo].[village_items] ([id], [village_id], [person_id], [item], [explanation]) VALUES (105, 1, 20, N'local lettuce', N'Local delicacy. Can be used to lure snails.')
INSERT [dbo].[village_items] ([id], [village_id], [person_id], [item], [explanation]) VALUES (106, 1, 20, N'gherkin', N'Local delicacy. Can be used to lure snails.')
INSERT [dbo].[village_items] ([id], [village_id], [person_id], [item], [explanation]) VALUES (107, 1, 20, N'pickle', N'Local delicacy. Can be used to lure snails.')
SET IDENTITY_INSERT [dbo].[village_items] OFF
GO
ALTER TABLE [dbo].[location]  WITH CHECK ADD  CONSTRAINT [FK_location_location] FOREIGN KEY([location_parent_id])
REFERENCES [dbo].[location] ([id])
GO
ALTER TABLE [dbo].[location] CHECK CONSTRAINT [FK_location_location]
GO
ALTER TABLE [dbo].[person]  WITH CHECK ADD  CONSTRAINT [FK_person_location] FOREIGN KEY([location_id])
REFERENCES [dbo].[location] ([id])
GO
ALTER TABLE [dbo].[person] CHECK CONSTRAINT [FK_person_location]
GO
ALTER TABLE [dbo].[personal_items]  WITH CHECK ADD  CONSTRAINT [FK_personal_items_person] FOREIGN KEY([person_id])
REFERENCES [dbo].[person] ([id])
GO
ALTER TABLE [dbo].[personal_items] CHECK CONSTRAINT [FK_personal_items_person]
GO
ALTER TABLE [dbo].[quest]  WITH CHECK ADD  CONSTRAINT [FK_quest_person] FOREIGN KEY([person_id])
REFERENCES [dbo].[person] ([id])
GO
ALTER TABLE [dbo].[quest] CHECK CONSTRAINT [FK_quest_person]
GO
ALTER TABLE [dbo].[solution]  WITH CHECK ADD  CONSTRAINT [FK_solution_kill_strategy] FOREIGN KEY([kill_strategy_id])
REFERENCES [dbo].[kill_strategy] ([id])
GO
ALTER TABLE [dbo].[solution] CHECK CONSTRAINT [FK_solution_kill_strategy]
GO
ALTER TABLE [dbo].[solution]  WITH CHECK ADD  CONSTRAINT [FK_solution_location] FOREIGN KEY([location_id])
REFERENCES [dbo].[location] ([id])
GO
ALTER TABLE [dbo].[solution] CHECK CONSTRAINT [FK_solution_location]
GO
ALTER TABLE [dbo].[solution]  WITH CHECK ADD  CONSTRAINT [FK_solution_monster] FOREIGN KEY([monster_id])
REFERENCES [dbo].[monster] ([id])
GO
ALTER TABLE [dbo].[solution] CHECK CONSTRAINT [FK_solution_monster]
GO
/****** Object:  StoredProcedure [dbo].[sp_Add_Inventory]    Script Date: 17/07/2023 16:15:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Add_Inventory] (@item_id int, @message varchar(500) OUTPUT)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @item varchar(50);

	DECLARE @a_item_id int;
	Select @a_item_id = id 
	from dbo.v_all_items 
	where id = @item_id;

	DECLARE @inventory_id int;
	Select @inventory_id = id 
	from dbo.inventory 
	where username = SYSTEM_USER 
	and item = (select item from dbo.v_all_items where id = @item_id);

-- checking the input value is integer
	IF (TRY_CAST(@item_id as int) is null)
		SET @message = @item_id + ' is not an integer value'
-- when the item doesn't exist, nothing happens
	IF (@a_item_id is null)
		SET @message = 'You must be crosseyed, there is no such thing as that found here' 
-- when you don't have the item in your inventory it is added 
	ELSE IF (@inventory_id is null)
		BEGIN
			insert into dbo.inventory (item, origin, username)
			select item, origin, SYSTEM_USER
			from dbo.v_all_items
			where id = @item_id

			SET @inventory_id = @@IDENTITY
			select @item = item from dbo.inventory where id = @inventory_id

			SET @message = 'Good job, you have succesfully added ' + @item + ' to your inventory'
		END

-- when you allready have the item in your inventory, nothing happens
		ELSE BEGIN
			select @item = item from dbo.inventory where id = @inventory_id
			SET @message = 'Pay attention! You have already added ' + @item + ' to your inventory'	
		END	

	select * from dbo.inventory where username = SYSTEM_USER

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Check_Solution]    Script Date: 17/07/2023 16:15:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Check_Solution] (@location_id int, @monster_id int, @kill_strategy_id int, @message nvarchar(500) OUTPUT)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @item int;
	DECLARE @solution int;
	DECLARE @solution_wm int;
	DECLARE @solution_ws int;
	DECLARE @solution_wl int;
	DECLARE @inventory_item int;

	select @solution = id
	from dbo.solution 
	where location_id = @location_id
	and monster_id = @monster_id
	and kill_strategy_id = @kill_strategy_id;

	select @solution_wm = id
	from dbo.solution 
	where location_id = @location_id
	and monster_id != @monster_id
	and kill_strategy_id = @kill_strategy_id;

	select @solution_ws = id
	from dbo.solution 
	where location_id = @location_id
	and monster_id = @monster_id
	and kill_strategy_id != @kill_strategy_id;

	select @solution_wl = id
	from dbo.solution 
	where location_id != @location_id
	and monster_id = @monster_id
	and kill_strategy_id = @kill_strategy_id;


-- SUCCESS
-- First check if the location, monster and strategy are correct
-- If location, monster and strategy are correct, check if there are necessary items
	if (@solution is not null)
		BEGIN
			select @item = item_id
			from dbo.solution 
			where id = @solution
	
	-- If there are no necessary items -> SUCCESS
			IF (@item is null)
				BEGIN
					SELECT @message = message
					FROM dbo.solution_messages
					WHERE message_type = 'SUCCESS'
				END	
			
	-- If there are necessary items, check if they are in the inventory		
			ELSE IF (@item is not null)
				BEGIN
					select @inventory_item = id
					from dbo.inventory
					where id = @item
	
	-- If the item is in the inventory -> SUCCESS
						IF (@inventory_item is not null)
							BEGIN
								SELECT @message = message
								FROM dbo.solution_messages
								WHERE message_type = 'SUCCESS'
							END	
	-- If not -> MISSING ITEM
						ELSE 	
							BEGIN
								SELECT @message = message
								FROM dbo.solution_messages
								WHERE message_type = 'MISSING_ITEM'
							END	
				END
		END
-- WRONG MONSTER
-- The location and strategy are correct, but the monster isn't
	ELSE if (@solution_wm is not null)
		BEGIN
			SELECT @message = message
			FROM dbo.solution_messages
			WHERE message_type = 'WRONG_MONSTER'
		END	
-- WRONG STRATEGY
-- The location and monster are correct, but the strategy isn't
	ELSE if (@solution_ws is not null)
		BEGIN
			SELECT @message = message
			FROM dbo.solution_messages
			WHERE message_type = 'WRONG_STRATEGY'
		END	
-- WRONG LOCATION
-- The monster and strategy are correct, but the location isn't
	ELSE if (@solution_wl is not null)
		BEGIN
			SELECT @message = message
			FROM dbo.solution_messages
			WHERE message_type = 'WRONG_LOCATION'
		END	
-- EPIC FAILURE
-- Nothing is correct
	ELSE 
		BEGIN
			SELECT @message = message
			FROM dbo.solution_messages
			WHERE message_type = 'EPIC_FAIL'
		END	

END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[24] 4[3] 2[54] 3) )"
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
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_all_items'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_all_items'
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
         Begin Table = "beach_items"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 179
               Right = 279
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
      Begin ColumnWidths = 11
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_beach_items'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_beach_items'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[31] 2[10] 3) )"
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
         Begin Table = "inn"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 206
               Right = 304
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "village"
            Begin Extent = 
               Top = 17
               Left = 377
               Bottom = 214
               Right = 624
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
      Begin ColumnWidths = 11
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_inn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_inn'
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
         Begin Table = "location"
            Begin Extent = 
               Top = 15
               Left = 590
               Bottom = 212
               Right = 837
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "person"
            Begin Extent = 
               Top = 22
               Left = 124
               Bottom = 219
               Right = 346
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
      Begin ColumnWidths = 11
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_person'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_person'
GO
USE [master]
GO
ALTER DATABASE [Monster] SET  READ_WRITE 
GO
