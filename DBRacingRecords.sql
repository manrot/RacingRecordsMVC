USE [master]
GO
/****** Object:  Database [RacingRecords]    Script Date: 28/11/2022 14:44:51 ******/
CREATE DATABASE [RacingRecords]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RacingRecords', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\RacingRecords.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'RacingRecords_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\RacingRecords_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [RacingRecords] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RacingRecords].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RacingRecords] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RacingRecords] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RacingRecords] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RacingRecords] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RacingRecords] SET ARITHABORT OFF 
GO
ALTER DATABASE [RacingRecords] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RacingRecords] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RacingRecords] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RacingRecords] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RacingRecords] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RacingRecords] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RacingRecords] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RacingRecords] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RacingRecords] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RacingRecords] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RacingRecords] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RacingRecords] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RacingRecords] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RacingRecords] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RacingRecords] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RacingRecords] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RacingRecords] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RacingRecords] SET RECOVERY FULL 
GO
ALTER DATABASE [RacingRecords] SET  MULTI_USER 
GO
ALTER DATABASE [RacingRecords] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RacingRecords] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RacingRecords] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RacingRecords] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [RacingRecords] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [RacingRecords] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'RacingRecords', N'ON'
GO
ALTER DATABASE [RacingRecords] SET QUERY_STORE = OFF
GO
USE [RacingRecords]
GO
/****** Object:  Table [dbo].[Competidor]    Script Date: 28/11/2022 14:44:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Competidor](
	[IdCompetidor] [bigint] IDENTITY(1,1) NOT NULL,
	[Identificacion] [varchar](50) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellido1] [varchar](50) NOT NULL,
	[Apellido2] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Competidor] PRIMARY KEY CLUSTERED 
(
	[IdCompetidor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EjecucionCarrera]    Script Date: 28/11/2022 14:44:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EjecucionCarrera](
	[IdCompetencia] [bigint] IDENTITY(1,1) NOT NULL,
	[IdCompetidor] [bigint] NOT NULL,
	[Minutos] [int] NOT NULL,
	[Segundos] [int] NOT NULL,
	[NumeroCompetidor] [int] NOT NULL,
 CONSTRAINT [PK_EjecucionCarrera] PRIMARY KEY CLUSTERED 
(
	[IdCompetencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VelocidadCompetidor]    Script Date: 28/11/2022 14:44:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VelocidadCompetidor]
AS
SELECT dbo.Competidor.IdCompetidor, SUM(dbo.EjecucionCarrera.Minutos * 60 + dbo.EjecucionCarrera.Segundos) AS SegundosTotales, CAST(2000 / CAST(SUM(dbo.EjecucionCarrera.Minutos * 60 + dbo.EjecucionCarrera.Segundos) AS float) 
                  AS float) AS Velocidad, dbo.EjecucionCarrera.NumeroCompetidor, dbo.Competidor.Nombre, dbo.Competidor.Apellido1, dbo.Competidor.Apellido2
FROM     dbo.EjecucionCarrera INNER JOIN
                  dbo.Competidor ON dbo.EjecucionCarrera.IdCompetidor = dbo.Competidor.IdCompetidor
WHERE  (10 =
                      (SELECT COUNT(IdCompetidor) AS Expr1
                       FROM      dbo.EjecucionCarrera AS EjecucionCarrera_1))
GROUP BY dbo.Competidor.IdCompetidor, dbo.EjecucionCarrera.NumeroCompetidor, dbo.Competidor.Nombre, dbo.Competidor.Apellido1, dbo.Competidor.Apellido2
GO
/****** Object:  View [dbo].[MasVeloz]    Script Date: 28/11/2022 14:44:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MasVeloz]
AS
SELECT TOP (1) PERCENT dbo.Competidor.IdCompetidor, SUM(dbo.EjecucionCarrera.Minutos * 60 + dbo.EjecucionCarrera.Segundos) AS SegundosTotales, 
                  CAST(2000 / CAST(SUM(dbo.EjecucionCarrera.Minutos * 60 + dbo.EjecucionCarrera.Segundos) AS float) AS float) AS Velocidad, dbo.EjecucionCarrera.NumeroCompetidor, dbo.Competidor.Nombre, dbo.Competidor.Apellido1, 
                  dbo.Competidor.Apellido2, dbo.EjecucionCarrera.Minutos, dbo.EjecucionCarrera.Segundos
FROM     dbo.EjecucionCarrera INNER JOIN
                  dbo.Competidor ON dbo.EjecucionCarrera.IdCompetidor = dbo.Competidor.IdCompetidor
WHERE  (10 =
                      (SELECT COUNT(IdCompetidor) AS Expr1
                       FROM      dbo.EjecucionCarrera AS EjecucionCarrera_1))
GROUP BY dbo.Competidor.IdCompetidor, dbo.EjecucionCarrera.NumeroCompetidor, dbo.Competidor.Nombre, dbo.Competidor.Apellido1, dbo.Competidor.Apellido2, dbo.EjecucionCarrera.Minutos, dbo.EjecucionCarrera.Segundos
ORDER BY Velocidad DESC
GO
/****** Object:  View [dbo].[MasLento]    Script Date: 28/11/2022 14:44:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MasLento]
AS
SELECT TOP (1) PERCENT dbo.Competidor.IdCompetidor, SUM(dbo.EjecucionCarrera.Minutos * 60 + dbo.EjecucionCarrera.Segundos) AS SegundosTotales, 
                  CAST(2000 / CAST(SUM(dbo.EjecucionCarrera.Minutos * 60 + dbo.EjecucionCarrera.Segundos) AS float) AS float) AS Velocidad, dbo.EjecucionCarrera.NumeroCompetidor, dbo.Competidor.Nombre, dbo.Competidor.Apellido1, 
                  dbo.Competidor.Apellido2, dbo.EjecucionCarrera.Minutos, dbo.EjecucionCarrera.Segundos
FROM     dbo.EjecucionCarrera INNER JOIN
                  dbo.Competidor ON dbo.EjecucionCarrera.IdCompetidor = dbo.Competidor.IdCompetidor
WHERE  (10 =
                      (SELECT COUNT(IdCompetidor) AS Expr1
                       FROM      dbo.EjecucionCarrera AS EjecucionCarrera_1))
GROUP BY dbo.Competidor.IdCompetidor, dbo.EjecucionCarrera.NumeroCompetidor, dbo.Competidor.Nombre, dbo.Competidor.Apellido1, dbo.Competidor.Apellido2, dbo.EjecucionCarrera.Minutos, dbo.EjecucionCarrera.Segundos
ORDER BY Velocidad
GO
/****** Object:  View [dbo].[PromedioVelocidad]    Script Date: 28/11/2022 14:44:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PromedioVelocidad]
AS
SELECT SUM(Velocidad) AS SumatoriaVelocidades, COUNT(IdCompetidor) AS TotalCompetidores, SUM(Velocidad) / COUNT(IdCompetidor) AS promedio
FROM     (SELECT IdCompetidor, CAST(2000 / CAST(SUM(Minutos * 60 + Segundos) AS float) AS float) AS Velocidad
                  FROM      dbo.EjecucionCarrera
                  GROUP BY IdCompetidor) AS o
GO
ALTER TABLE [dbo].[EjecucionCarrera]  WITH CHECK ADD  CONSTRAINT [FK_EjecucionCarrera_Competidor] FOREIGN KEY([IdCompetidor])
REFERENCES [dbo].[Competidor] ([IdCompetidor])
GO
ALTER TABLE [dbo].[EjecucionCarrera] CHECK CONSTRAINT [FK_EjecucionCarrera_Competidor]
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
         Begin Table = "EjecucionCarrera"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 293
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Competidor"
            Begin Extent = 
               Top = 7
               Left = 341
               Bottom = 170
               Right = 551
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
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'MasLento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'MasLento'
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
         Begin Table = "EjecucionCarrera"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 293
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Competidor"
            Begin Extent = 
               Top = 7
               Left = 341
               Bottom = 170
               Right = 551
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
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'MasVeloz'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'MasVeloz'
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
         Begin Table = "o"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 150
               Right = 312
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
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PromedioVelocidad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PromedioVelocidad'
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
         Begin Table = "EjecucionCarrera"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 293
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Competidor"
            Begin Extent = 
               Top = 7
               Left = 341
               Bottom = 170
               Right = 551
            End
            DisplayFlags = 280
            TopColumn = 1
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
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VelocidadCompetidor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VelocidadCompetidor'
GO
USE [master]
GO
ALTER DATABASE [RacingRecords] SET  READ_WRITE 
GO
