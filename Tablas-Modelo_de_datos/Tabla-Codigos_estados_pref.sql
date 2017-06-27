USE [tesisrh]
GO

/****** Object:  Table [dbo].[Codigos_estados_pref]    Script Date: 6/26/2017 1:59:33 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Codigos_estados_pref](
	[Id_preferencia] [int] NOT NULL,
	[Id_estado_pref] [int] NOT NULL,
	[Descrip_estado] [char](100) NOT NULL,
 CONSTRAINT [PK_Codigos_estados_pref] PRIMARY KEY CLUSTERED 
(
	[Id_preferencia] ASC,
	[Id_estado_pref] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Codigos_estados_pref]  WITH CHECK ADD  CONSTRAINT [FK_Codigos_estados_pref_Codigos_preferencia] FOREIGN KEY([Id_preferencia])
REFERENCES [dbo].[Codigos_preferencia] ([Id_preferencia])
GO

ALTER TABLE [dbo].[Codigos_estados_pref] CHECK CONSTRAINT [FK_Codigos_estados_pref_Codigos_preferencia]
GO

