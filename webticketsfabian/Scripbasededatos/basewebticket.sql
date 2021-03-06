USE [master]
GO
/****** Object:  Database [dbticket]    Script Date: 23/10/2020 09:35:40 p.m. ******/
CREATE DATABASE [dbticket]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbticket', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\dbticket.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dbticket_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\dbticket_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbticket].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbticket] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbticket] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbticket] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbticket] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbticket] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbticket] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dbticket] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbticket] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbticket] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbticket] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbticket] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbticket] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbticket] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbticket] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbticket] SET  DISABLE_BROKER 
GO
ALTER DATABASE [dbticket] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbticket] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbticket] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbticket] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbticket] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbticket] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbticket] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbticket] SET RECOVERY FULL 
GO
ALTER DATABASE [dbticket] SET  MULTI_USER 
GO
ALTER DATABASE [dbticket] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbticket] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbticket] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbticket] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [dbticket] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'dbticket', N'ON'
GO
ALTER DATABASE [dbticket] SET QUERY_STORE = OFF
GO
USE [dbticket]
GO
ALTER DATABASE SCOPED CONFIGURATION SET ACCELERATED_PLAN_FORCING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ADAPTIVE_JOINS = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_MEMORY_GRANT_FEEDBACK = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ON_ROWSTORE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET DEFERRED_COMPILATION_TV = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ELEVATE_ONLINE = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ELEVATE_RESUMABLE = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET GLOBAL_TEMPORARY_TABLE_AUTO_DROP = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET INTERLEAVED_EXECUTION_TVF = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ISOLATE_SECURITY_POLICY_CARDINALITY = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LAST_QUERY_PLAN_STATS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LIGHTWEIGHT_QUERY_PROFILING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET OPTIMIZE_FOR_AD_HOC_WORKLOADS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ROW_MODE_MEMORY_GRANT_FEEDBACK = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET TSQL_SCALAR_UDF_INLINING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET VERBOSE_TRUNCATION_WARNINGS = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_PROCEDURE_EXECUTION_STATISTICS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_QUERY_EXECUTION_STATISTICS = OFF;
GO
USE [dbticket]
GO
/****** Object:  User [fabian]    Script Date: 23/10/2020 09:35:40 p.m. ******/
CREATE USER [fabian] FOR LOGIN [fabian] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Persona]    Script Date: 23/10/2020 09:35:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Persona](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idpersona] [varchar](50) NULL,
	[nombre] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tickets]    Script Date: 23/10/2020 09:35:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tickets](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[tipocola] [int] NULL,
	[estado] [nchar](1) NULL,
	[orden] [int] NULL,
	[idpersona] [int] NULL,
	[fechainicio] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Persona] ON 

INSERT [dbo].[Persona] ([Id], [idpersona], [nombre]) VALUES (61, N'1', N'juan')
INSERT [dbo].[Persona] ([Id], [idpersona], [nombre]) VALUES (62, N'19', N'carlos')
INSERT [dbo].[Persona] ([Id], [idpersona], [nombre]) VALUES (63, N'19', N'isabel')
INSERT [dbo].[Persona] ([Id], [idpersona], [nombre]) VALUES (64, N'96', N'fabian')
INSERT [dbo].[Persona] ([Id], [idpersona], [nombre]) VALUES (65, N'36', N'samia')
INSERT [dbo].[Persona] ([Id], [idpersona], [nombre]) VALUES (66, N'90', N'LOPEZ')
INSERT [dbo].[Persona] ([Id], [idpersona], [nombre]) VALUES (67, N'1716218597', N'ALEX')
INSERT [dbo].[Persona] ([Id], [idpersona], [nombre]) VALUES (68, N's', N'w2')
INSERT [dbo].[Persona] ([Id], [idpersona], [nombre]) VALUES (69, N'1716218597', N'erere')
INSERT [dbo].[Persona] ([Id], [idpersona], [nombre]) VALUES (70, N'222', N'dddd')
INSERT [dbo].[Persona] ([Id], [idpersona], [nombre]) VALUES (71, N'7777', N'ddd')
INSERT [dbo].[Persona] ([Id], [idpersona], [nombre]) VALUES (72, N'482', N'ewewe')
INSERT [dbo].[Persona] ([Id], [idpersona], [nombre]) VALUES (73, N'1716218597', N'fabian')
INSERT [dbo].[Persona] ([Id], [idpersona], [nombre]) VALUES (74, N'1996', N'samia')
INSERT [dbo].[Persona] ([Id], [idpersona], [nombre]) VALUES (75, N'988', N'amira')
SET IDENTITY_INSERT [dbo].[Persona] OFF
SET IDENTITY_INSERT [dbo].[Tickets] ON 

INSERT [dbo].[Tickets] ([Id], [tipocola], [estado], [orden], [idpersona], [fechainicio]) VALUES (43, 3, N'A', 1, 61, CAST(N'2020-10-23T20:57:36.060' AS DateTime))
INSERT [dbo].[Tickets] ([Id], [tipocola], [estado], [orden], [idpersona], [fechainicio]) VALUES (44, 2, N'A', 1, 62, CAST(N'2020-10-23T20:58:34.567' AS DateTime))
INSERT [dbo].[Tickets] ([Id], [tipocola], [estado], [orden], [idpersona], [fechainicio]) VALUES (45, 3, N'A', 1, 63, CAST(N'2020-10-23T21:15:14.813' AS DateTime))
INSERT [dbo].[Tickets] ([Id], [tipocola], [estado], [orden], [idpersona], [fechainicio]) VALUES (46, 2, N'A', 1, 64, CAST(N'2020-10-23T21:15:25.717' AS DateTime))
INSERT [dbo].[Tickets] ([Id], [tipocola], [estado], [orden], [idpersona], [fechainicio]) VALUES (47, 2, N'A', 2, 65, CAST(N'2020-10-23T21:15:38.903' AS DateTime))
INSERT [dbo].[Tickets] ([Id], [tipocola], [estado], [orden], [idpersona], [fechainicio]) VALUES (48, 3, N'A', 2, 66, CAST(N'2020-10-23T21:17:09.537' AS DateTime))
INSERT [dbo].[Tickets] ([Id], [tipocola], [estado], [orden], [idpersona], [fechainicio]) VALUES (49, 2, N'A', 3, 67, CAST(N'2020-10-23T21:17:29.173' AS DateTime))
INSERT [dbo].[Tickets] ([Id], [tipocola], [estado], [orden], [idpersona], [fechainicio]) VALUES (50, 3, N'A', 1, 68, CAST(N'2020-10-23T21:27:20.497' AS DateTime))
INSERT [dbo].[Tickets] ([Id], [tipocola], [estado], [orden], [idpersona], [fechainicio]) VALUES (51, 2, N'A', 1, 69, CAST(N'2020-10-23T21:27:38.683' AS DateTime))
INSERT [dbo].[Tickets] ([Id], [tipocola], [estado], [orden], [idpersona], [fechainicio]) VALUES (52, 2, N'A', 2, 70, CAST(N'2020-10-23T21:27:50.137' AS DateTime))
INSERT [dbo].[Tickets] ([Id], [tipocola], [estado], [orden], [idpersona], [fechainicio]) VALUES (53, 3, N'A', 2, 71, CAST(N'2020-10-23T21:27:55.427' AS DateTime))
INSERT [dbo].[Tickets] ([Id], [tipocola], [estado], [orden], [idpersona], [fechainicio]) VALUES (54, 2, N'A', 3, 72, CAST(N'2020-10-23T21:28:38.637' AS DateTime))
INSERT [dbo].[Tickets] ([Id], [tipocola], [estado], [orden], [idpersona], [fechainicio]) VALUES (55, 2, N'P', 4, 73, CAST(N'2020-10-23T21:31:53.110' AS DateTime))
INSERT [dbo].[Tickets] ([Id], [tipocola], [estado], [orden], [idpersona], [fechainicio]) VALUES (56, 2, N'P', 5, 74, CAST(N'2020-10-23T21:32:05.813' AS DateTime))
INSERT [dbo].[Tickets] ([Id], [tipocola], [estado], [orden], [idpersona], [fechainicio]) VALUES (57, 3, N'P', 1, 75, CAST(N'2020-10-23T21:32:21.083' AS DateTime))
SET IDENTITY_INSERT [dbo].[Tickets] OFF
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [fk_persona] FOREIGN KEY([idpersona])
REFERENCES [dbo].[Persona] ([Id])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [fk_persona]
GO
USE [master]
GO
ALTER DATABASE [dbticket] SET  READ_WRITE 
GO
