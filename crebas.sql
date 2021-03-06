USE [master]
GO
/****** Object:  Database [Prueba]    Script Date: 7/9/2017 11:41:28 PM ******/
CREATE DATABASE [Prueba]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Prueba', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\Prueba.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Prueba_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\Prueba_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Prueba] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Prueba].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Prueba] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Prueba] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Prueba] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Prueba] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Prueba] SET ARITHABORT OFF 
GO
ALTER DATABASE [Prueba] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Prueba] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Prueba] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Prueba] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Prueba] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Prueba] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Prueba] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Prueba] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Prueba] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Prueba] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Prueba] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Prueba] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Prueba] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Prueba] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Prueba] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Prueba] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Prueba] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Prueba] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Prueba] SET  MULTI_USER 
GO
ALTER DATABASE [Prueba] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Prueba] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Prueba] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Prueba] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Prueba] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Prueba] SET QUERY_STORE = OFF
GO
USE [Prueba]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Prueba]
GO
/****** Object:  UserDefinedFunction [dbo].[f_Obtener_Nombre_Pais]    Script Date: 7/9/2017 11:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[f_Obtener_Nombre_Pais] (@PaisId int)
RETURNS nvarchar(MAX)
AS
BEGIN
	DECLARE @NombrePais NVARCHAR(MAX)
	
	SELECT  @NombrePais = p.Nombre
	FROM Pais p
	WHERE Id = @PaisId

	RETURN @NombrePais
END
GO
/****** Object:  Table [dbo].[Pais]    Script Date: 7/9/2017 11:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pais](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](max) NOT NULL,
	[Activo] [bit] NULL,
 CONSTRAINT [PK_Pais] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ciudad]    Script Date: 7/9/2017 11:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ciudad](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](max) NOT NULL,
	[Activo] [bit] NULL,
	[PaisID] [int] NOT NULL,
 CONSTRAINT [PK_Ciudad] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sector]    Script Date: 7/9/2017 11:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sector](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](max) NOT NULL,
	[Activo] [bit] NULL,
	[CiudadID] [int] NOT NULL,
 CONSTRAINT [PK_Sector] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_Sectores]    Script Date: 7/9/2017 11:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Sectores] AS
SELECT ROW_NUMBER() OVER(ORDER BY s.Id ASC) AS Row, s.Id SectorId, s.Nombre SectorNombre,
	c.Id CiudadId, c.Nombre CiudadNombre,
	p.Id PaisId, p.Nombre PaisNombre
FROM Sector s 
	FULL OUTER JOIN Ciudad c 
		ON (s.CiudadID = c.Id) 
	FULL OUTER JOIN Pais p 
		ON (c.PaisID = p.Id)
GO
ALTER TABLE [dbo].[Ciudad] ADD  CONSTRAINT [DF_Ciudad_Activo]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Pais] ADD  CONSTRAINT [DF_Pais_Activo]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Sector] ADD  CONSTRAINT [DF_Sector_Activo]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Ciudad]  WITH CHECK ADD  CONSTRAINT [FK_Ciudad_Pais] FOREIGN KEY([PaisID])
REFERENCES [dbo].[Pais] ([Id])
GO
ALTER TABLE [dbo].[Ciudad] CHECK CONSTRAINT [FK_Ciudad_Pais]
GO
ALTER TABLE [dbo].[Sector]  WITH CHECK ADD  CONSTRAINT [FK_Sector_Ciudad] FOREIGN KEY([CiudadID])
REFERENCES [dbo].[Ciudad] ([Id])
GO
ALTER TABLE [dbo].[Sector] CHECK CONSTRAINT [FK_Sector_Ciudad]
GO
/****** Object:  StoredProcedure [dbo].[sp_CantidadSectoresPaisesPorPais]    Script Date: 7/9/2017 11:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_CantidadSectoresPaisesPorPais]
    @SectorNombre int
AS 
BEGIN 
	SELECT p.Id PaisId, p.Nombre PaisNombre,
		count(distinct c.Id ) CantidadCiudades,
		count(distinct s.Id) CantidadSectores
	FROM Sector s 
		FULL OUTER JOIN Ciudad c 
			ON (s.CiudadID = c.Id) 
		FULL OUTER JOIN Pais p 
			ON (c.PaisID = p.Id)
	group by p.id, p.Nombre;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CiudadCreate]    Script Date: 7/9/2017 11:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CiudadCreate]
	   @Nombre nvarchar(MAX),
	   @Activo bit,
	   @PaisID int 
AS
BEGIN
	INSERT INTO Ciudad(Nombre,Activo,PaisId)
		VALUES (@Nombre,@Activo,@PaisId)

	SELECT SCOPE_IDENTITY() AS Id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CiudadDelete]    Script Date: 7/9/2017 11:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_CiudadDelete] 
    @Id int
AS 
BEGIN 
	DELETE
	FROM   Ciudad
	WHERE  id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CiudadUpdate]    Script Date: 7/9/2017 11:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_CiudadUpdate]
    @Id int,
    @Nombre nvarchar(max),
    @Activo bit,
	@PaisID int
  
AS 
BEGIN  
	UPDATE Ciudad
	SET  Nombre = @Nombre,
		 Activo = @Activo,
		 PaisId = @PaisId
	WHERE  id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_PaisCreate]    Script Date: 7/9/2017 11:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_PaisCreate]
	   @Nombre nvarchar(MAX),
	   @Activo bit 
AS
BEGIN	
	INSERT INTO Pais(Nombre,Activo)
		VALUES (@Nombre,@Activo)

	SELECT SCOPE_IDENTITY() AS Id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_PaisDelete]    Script Date: 7/9/2017 11:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_PaisDelete] 
    @Id int
AS 
BEGIN 
	DELETE
	FROM   Pais
	WHERE  id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_PaisUpdate]    Script Date: 7/9/2017 11:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_PaisUpdate]
    @Id int,
    @Nombre nvarchar(max),
    @Activo bit
  
AS 
BEGIN  
	UPDATE Pais
	SET  Nombre = @Nombre,
		 Activo = @Activo
	WHERE  id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SectorCreate]    Script Date: 7/9/2017 11:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SectorCreate]
	   @Nombre nvarchar(MAX),
	   @Activo bit,
	   @CiudadID int 
AS
BEGIN
	INSERT INTO Sector(Nombre,Activo,CiudadId)
		VALUES (@Nombre,@Activo,@CiudadId)

	SELECT SCOPE_IDENTITY() AS Id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SectorDelete]    Script Date: 7/9/2017 11:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_SectorDelete] 
    @Id int
AS 
BEGIN 
	DELETE
	FROM   Sector
	WHERE  id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SectorSearch]    Script Date: 7/9/2017 11:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_SectorSearch]
    @SectorNombre NVARCHAR(MAX)
AS 
BEGIN 
    SELECT SectorId ,SectorNombre
      ,CiudadId ,CiudadNombre
      ,PaisId ,PaisNombre
	FROM v_Sectores
	WHERE SectorNombre like  '%'+@SectorNombre+'%'
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SectorUpdate]    Script Date: 7/9/2017 11:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_SectorUpdate]
    @Id int,
    @Nombre nvarchar(max),
    @Activo bit,
	@CiudadID int
  
AS 
BEGIN  
	UPDATE Sector
	SET  Nombre = @Nombre,
		 Activo = @Activo,
		 CiudadId = @CiudadId
	WHERE  id = @Id
END
GO
USE [master]
GO
ALTER DATABASE [Prueba] SET  READ_WRITE 
GO
