USE [tesisrh]
GO

/****** Object:  Table [dbo].[Encuesta_General]    Script Date: 6/26/2017 2:05:53 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Encuesta_General](
	[Id_candidato] [char](10) NULL,
	[Timestamp] [datetime] NULL,
	[Nombre] [char](50) NULL,
	[Sexo] [char](10) NULL,
	[Edad] [int] NULL,
	[Estado_civil] [char](10) NULL,
	[Preg_estudios_ems] [char](2) NULL,
	[Eb_grado_max] [char](50) NULL,
	[Eb_situacion] [char](50) NULL,
	[Eb_anio_situacion] [int] NULL,
	[Ems_situacion] [char](50) NULL,
	[Ems_anio_situacion] [int] NULL,
	[Ems_institucion] [char](100) NULL,
	[Ems_especialidad] [char](100) NULL,
	[Ems_pertenece_TI] [char](2) NULL,
	[Preg_estudios_es] [char](2) NULL,
	[Es_situacion] [char](50) NULL,
	[Es_anio_situacion] [int] NULL,
	[Es_institucion] [char](100) NULL,
	[Es_carrera] [char](100) NULL,
	[Es_pertenece_TI] [char](2) NULL,
	[Preg_estudios_maestria] [char](2) NULL,
	[Maest_situacion] [char](50) NULL,
	[Maest_anio_situacion] [int] NULL,
	[Maest_institucion] [char](100) NULL,
	[Maest_carrera] [char](100) NULL,
	[Maest_pertenece_TI] [char](2) NULL,
	[Preg_estudios_doctorado] [char](2) NULL,
	[Doc_situacion] [char](50) NULL,
	[Doc_anio_situacion] [int] NULL,
	[Doc_institucion] [char](100) NULL,
	[Doc_carrera] [char](100) NULL,
	[Doc_pertenece_TI] [char](2) NULL,
	[Preg_exp_laboral_TI] [char](2) NULL,
	[Anios_experiencia] [int] NULL,
	[Num_empleos_TI] [int] NULL,
	[Max_antig_empleo_TI] [int] NULL,
	[Min_antig_empleo_TI] [int] NULL,
	[Max_tiempo_inactividad] [char](50) NULL,
	[Preg_empl_relac_TI] [char](2) NULL,
	[Tact_antig] [int] NULL,
	[Tact_sector] [char](10) NULL,
	[Tact_empresa] [char](100) NULL,
	[Tact_puesto] [char](50) NULL,
	[Tact_antig_puesto] [int] NULL,
	[Tact_sueldo] [char](50) NULL,
	[Tult_antig] [int] NULL,
	[Tult_anio_salida] [int] NULL,
	[Tult_sector] [char](10) NULL,
	[Tult_empresa] [char](100) NULL,
	[Tult_puesto] [char](50) NULL,
	[Tult_antig_puesto] [int] NULL,
	[Tult_sueldo] [char](50) NULL,
	[Factores_dl] [char](500) NULL,
	[Factores_at_calidad] [int] NULL,
	[Factores_at_sueldo] [int] NULL,
	[Factores_at_estabilidad] [int] NULL,
	[Factores_at_crecimiento] [int] NULL,
	[Factores_at_reconoc] [int] NULL,
	[Idiomas_ingles] [char](20) NULL,
	[Idiomas_frances] [char](20) NULL,
	[Idiomas_aleman] [char](20) NULL,
	[Idiomas_japones] [char](20) NULL,
	[Idiomas_mandarin] [char](20) NULL,
	[comentarios] [char](500) NULL,
	[email] [char](50) NULL
) ON [PRIMARY]

GO

