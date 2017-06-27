-- ===============================================================================
--
-- Author            : Carlos Daniel Martinez Ortiz
-- Create date       : 2017-04-15
-- Stored Procedure  : 2
-- Description       : Carga de las siguientes tablas de recursos humanos de TI
--                     1) Conocimientos_cand
--
-- ================================================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SE UTILIZARÁ LA BASE DE DATOS tesisrh

USE tesisrh
GO


CREATE PROCEDURE [dbo].[SP_CARGA_TABLAS_2_RH_TI] 

USE tesisrh
GO

-- DECLARACIÓN DE VARIABLES
DECLARE
-- Variables para la tabla: Conocimientos_cand
    @T1_Id_candidato       char(10), 
	@T1_Id_puesto          char(05), 
	@T1_Id_conoc_it        int, 
	@T1_Anios_conoc        int,
	@T1_Ind_certificacion  char(1),

-- Variables para la tabla: Puestos_TI_cand
    @T2_Id_candidato       char(10), 
	@T2_Id_puesto          char(05),
	@T2_Ind_puesto_act     char(1),
	@T2_Sueldo             decimal(15,2),
	 
	 
-- Variables temporales utilizadas para buscar en cadenas de texto separadas por coma
    @posIni              int,
    @posFin              int,
    @longNueva           int,
	@certificX           char(100),
    @P_certificaciones   char(200),
	@P_numPref           int,
    

-- Variables para la tabla: Encuesta_Puestos
	@E_Id_candidato            char(10),
	@E_Vacante                 char(50),
	 
	@E_Cob01_puesto_actual     char(2), 
	@E_Cob01_cit_7             int, 
	@E_Cob01_cit_8             int, 
	@E_Cob01_cit_9             int, 
	@E_Cob01_cit_10            int, 
	@E_Cob01_cit_11            int, 
	@E_Cob01_cit_12            int, 
	@E_Cob01_cit_13            int, 
	@E_Cob01_certificaciones_lng  char(200), 
	@E_Cob01_sueldo_pretendido    char(50), 
	
	@E_Cob02_puesto_actual     char(2), 
	@E_Cob02_cit_7             int,
	@E_Cob02_cit_8             int,
	@E_Cob02_cit_9             int,
	@E_Cob02_cit_10            int,
	@E_Cob02_cit_11            int,
	@E_Cob02_cit_12            int,
	@E_Cob02_cit_13            int,
	@E_Cob02_cit_14            int,
	@E_Cob02_cit_15            int,
	@E_Cob02_certificaciones_lng char(200), 
	@E_Cob02_cit_16            int,
	@E_Cob02_certificaciones_tem char(200), 
	@E_Cob02_cit_1             int, 
	@E_Cob02_cit_2             int, 
	@E_Cob02_cit_3             int, 
	@E_Cob02_cit_4             int, 
	@E_Cob02_cit_5             int, 
	@E_Cob02_cit_6             int, 
	@E_Cob02_sueldo_pretendido char(50), 
	
	@E_Jav01_puesto_actual     char(2), 
	@E_Jav01_cit_17            int, 
	@E_Jav01_cit_18            int, 
	@E_Jav01_cit_19            int, 
	@E_Jav01_cit_20            int, 
	@E_Jav01_cit_21            int, 
    @E_Jav01_cit_22            int,
	@E_Jav01_cit_23            int, 
	@E_Jav01_cit_24            int, 
	@E_Jav01_cit_25            int, 
	@E_Jav01_cit_26            int, 
	@E_Jav01_cit_27            int, 
	@E_Jav01_cit_28            int, 
	@E_Jav01_cit_29            int, 
    @E_Jav01_certificaciones_lng char(200),
	@E_Jav01_sueldo_pretendido   char(50), 
	
	@E_Jav02_puesto_actual     char(2),
	@E_Jav02_cit_17            int,
	@E_Jav02_cit_18            int, 
	@E_Jav02_cit_19            int, 
	@E_Jav02_cit_20            int, 
	@E_Jav02_cit_21            int, 
	@E_Jav02_cit_22            int, 
	@E_Jav02_cit_23            int, 
	@E_Jav02_cit_24            int, 
	@E_Jav02_cit_25            int, 
	@E_Jav02_cit_26            int, 
	@E_Jav02_cit_27            int, 
	@E_Jav02_cit_28            int, 
	@E_Jav02_cit_29            int, 
	@E_Jav02_certificaciones_lng char(200), 
	@E_Jav02_cit_16            int, 
	@E_Jav02_certificaciones_tem char(200), 
	@E_Jav02_cit_1             int,
	@E_Jav02_cit_2             int, 
	@E_Jav02_cit_3             int, 
	@E_Jav02_cit_4             int, 
	@E_Jav02_cit_5             int, 
	@E_Jav02_cit_6             int, 
	@E_Jav02_sueldo_pretendido char(50), 
	
	@E_Cob03_puesto_actual     char(2), 
	@E_Cob03_cit_7             int, 
	@E_Cob03_cit_8             int, 
	@E_Cob03_cit_9             int, 
	@E_Cob03_cit_10            int, 
	@E_Cob03_cit_11            int, 
	@E_Cob03_cit_12            int, 
	@E_Cob03_cit_13            int, 
	@E_Cob03_cit_14            int, 
	@E_Cob03_cit_15            int, 
	@E_Cob03_certificaciones_lng char(200), 
	@E_Cob03_cit_30            int, 
	@E_Cob03_cit_31            int, 
	@E_Cob03_cit_32            int, 
	@E_Cob03_cit_33            int, 
	@E_Cob03_cit_16            int, 
	@E_Cob03_certificaciones_tem char(200), 
	@E_Cob03_cit_1             int, 
	@E_Cob03_cit_2             int, 
	@E_Cob03_cit_3             int, 
	@E_Cob03_cit_4             int, 
	@E_Cob03_cit_5             int, 
	@E_Cob03_cit_6             int, 
	@E_Cob03_sueldo_pretendido char(50), 
	
	@E_Jav03_puesto_actual     char(2),
	@E_Jav03_cit_17            int, 
	@E_Jav03_cit_18            int, 
	@E_Jav03_cit_19            int, 
	@E_Jav03_cit_20            int, 
	@E_Jav03_cit_21            int, 
	@E_Jav03_cit_22            int, 
	@E_Jav03_cit_23            int, 
	@E_Jav03_cit_24            int, 
	@E_Jav03_cit_25            int, 
	@E_Jav03_cit_26            int, 
	@E_Jav03_cit_27            int, 
	@E_Jav03_cit_28            int, 
	@E_Jav03_cit_29            int, 
	@E_Jav03_certificaciones_lng char(200), 
	@E_Jav03_cit_30            int, 
	@E_Jav03_cit_31            int, 
	@E_Jav03_cit_32            int, 
	@E_Jav03_cit_33            int, 
	@E_Jav03_cit_16            int, 
	@E_Jav03_certificaciones_tem char(200), 
	@E_Jav03_cit_1             int, 
	@E_Jav03_cit_2             int, 
	@E_Jav03_cit_3             int, 
	@E_Jav03_cit_4             int, 
	@E_Jav03_cit_5             int, 
	@E_Jav03_cit_6             int, 
	@E_Jav03_sueldo_pretendido char(50),
	
	@E_Cob04_puesto_actual     char(2), 
	@E_Cob04_cit_7             int, 
	@E_Cob04_cit_8             int, 
	@E_Cob04_cit_9             int, 
	@E_Cob04_cit_10            int, 
	@E_Cob04_cit_11            int, 
	@E_Cob04_cit_14            int, 
	@E_Cob04_cit_15            int, 
	@E_Cob04_certificaciones_lng char(200), 
	@E_Cob04_cit_30            int, 
	@E_Cob04_cit_31            int, 
	@E_Cob04_cit_34            int, 
	@E_Cob04_cit_35            int, 
	@E_Cob04_cit_32            int, 
	@E_Cob04_cit_33            int, 
	@E_Cob04_cit_16            int, 
	@E_Cob04_certificaciones_tem char(200), 
	@E_Cob04_cit_1             int, 
	@E_Cob04_cit_2             int, 
	@E_Cob04_cit_3             int, 
	@E_Cob04_cit_4             int, 
	@E_Cob04_cit_5             int, 
	@E_Cob04_cit_6             int, 
	@E_Cob04_sueldo_pretendido char(50), 
	
	@E_Jav04_puesto_actual     char(2), 
	@E_Jav04_cit_17            int, 
	@E_Jav04_cit_18            int, 
	@E_Jav04_cit_19            int, 
	@E_Jav04_cit_20            int, 
	@E_Jav04_cit_21            int, 
	@E_Jav04_cit_22            int, 
	@E_Jav04_cit_23            int, 
	@E_Jav04_cit_24            int, 
	@E_Jav04_cit_25            int, 
	@E_Jav04_cit_26            int, 
	@E_Jav04_cit_27            int, 
	@E_Jav04_cit_28            int, 
	@E_Jav04_cit_29            int, 
	@E_Jav04_certificaciones_lng char(200), 
	@E_Jav04_cit_30            int, 
	@E_Jav04_cit_31            int, 
	@E_Jav04_cit_34            int, 
	@E_Jav04_cit_35            int, 
	@E_Jav04_cit_32            int, 
	@E_Jav04_cit_33            int, 
	@E_Jav04_cit_16            int, 
	@E_Jav04_certificaciones_tem char(200), 
	@E_Jav04_cit_1             int, 
	@E_Jav04_cit_2             int, 
	@E_Jav04_cit_3             int, 
	@E_Jav04_cit_4             int, 
	@E_Jav04_cit_5             int, 
	@E_Jav04_cit_6             int, 
	@E_Jav04_sueldo_pretendido char(50), 
	
	@E_Ora01_puesto_actual     char(2), 
	@E_Ora01_cit_36            int, 
	@E_Ora01_cit_37            int, 
	@E_Ora01_cit_38            int, 
	@E_Ora01_cit_39            int, 
	@E_Ora01_cit_40            int, 
	@E_Ora01_cit_41            int, 
	@E_Ora01_cit_42            int, 
	@E_Ora01_certificaciones_lng char(200),
	@E_Ora01_cit_30            int, 
	@E_Ora01_cit_31            int, 
	@E_Ora01_cit_43            int, 
	@E_Ora01_cit_44            int, 
	@E_Ora01_cit_45            int, 
	@E_Ora01_cit_46            int, 
	@E_Ora01_cit_47            int, 
	@E_Ora01_sueldo_pretendido char(50)



-- DECLARACIÓN del cursor Encuesta_general_cursor para leer la tabla Encuesta_General
DECLARE Encuesta_puestos_cursor CURSOR FOR  
SELECT 
     Id_candidato,
	 Vacante, 
	 
	 Cob01_puesto_actual, 
	 Cob01_cit_7, 
	 Cob01_cit_8, 
	 Cob01_cit_9, 
	 Cob01_cit_10, 
	 Cob01_cit_11, 
	 Cob01_cit_12, 
	 Cob01_cit_13, 
	 Cob01_certificaciones_lng, 
	 Cob01_sueldo_pretendido, 
	
	 Cob02_puesto_actual, 
	 Cob02_cit_7, 
	 Cob02_cit_8, 
	 Cob02_cit_9, 
	 Cob02_cit_10,
	 Cob02_cit_11, 
	 Cob02_cit_12, 
	 Cob02_cit_13, 
	 Cob02_cit_14, 
	 Cob02_cit_15, 
	 Cob02_certificaciones_lng, 
   	 Cob02_cit_16,
	 Cob02_certificaciones_tem, 
	 Cob02_cit_1, 
	 Cob02_cit_2, 
	 Cob02_cit_3, 
	 Cob02_cit_4, 
	 Cob02_cit_5, 
	 Cob02_cit_6, 
	 Cob02_sueldo_pretendido, 
	
	 Jav01_puesto_actual, 
	 Jav01_cit_17, 
	 Jav01_cit_18, 
	 Jav01_cit_19, 
	 Jav01_cit_20, 
	 Jav01_cit_21, 
	 Jav01_cit_22, 
	 Jav01_cit_23, 
	 Jav01_cit_24, 
	 Jav01_cit_25, 
	 Jav01_cit_26, 
	 Jav01_cit_27, 
	 Jav01_cit_28, 
	 Jav01_cit_29, 
     Jav01_certificaciones_lng,
	 Jav01_sueldo_pretendido, 
	
	 Jav02_puesto_actual, 
	 Jav02_cit_17, 
	 Jav02_cit_18, 
	 Jav02_cit_19, 
	 Jav02_cit_20, 
	 Jav02_cit_21, 
	 Jav02_cit_22, 
	 Jav02_cit_23, 
	 Jav02_cit_24, 
	 Jav02_cit_25, 
	 Jav02_cit_26, 
	 Jav02_cit_27, 
	 Jav02_cit_28, 
	 Jav02_cit_29, 
	 Jav02_certificaciones_lng, 
	 Jav02_cit_16, 
	 Jav02_certificaciones_tem, 
	 Jav02_cit_1, 
	 Jav02_cit_2, 
	 Jav02_cit_3, 
	 Jav02_cit_4, 
	 Jav02_cit_5, 
	 Jav02_cit_6, 
	 Jav02_sueldo_pretendido, 
	
	 Cob03_puesto_actual, 
	 Cob03_cit_7, 
	 Cob03_cit_8, 
	 Cob03_cit_9, 
	 Cob03_cit_10, 
	 Cob03_cit_11, 
	 Cob03_cit_12, 
	 Cob03_cit_13, 
	 Cob03_cit_14, 
	 Cob03_cit_15, 
	 Cob03_certificaciones_lng, 
	 Cob03_cit_30, 
	 Cob03_cit_31, 
	 Cob03_cit_32, 
	 Cob03_cit_33, 
	 Cob03_cit_16, 
	 Cob03_certificaciones_tem, 
	 Cob03_cit_1, 
	 Cob03_cit_2, 
	 Cob03_cit_3, 
	 Cob03_cit_4, 
	 Cob03_cit_5, 
	 Cob03_cit_6, 
	 Cob03_sueldo_pretendido, 
	
 	 Jav03_puesto_actual,  
	 Jav03_cit_17, 
	 Jav03_cit_18, 
	 Jav03_cit_19, 
	 Jav03_cit_20, 
	 Jav03_cit_21, 
	 Jav03_cit_22, 
	 Jav03_cit_23, 
	 Jav03_cit_24, 
	 Jav03_cit_25, 
	 Jav03_cit_26, 
	 Jav03_cit_27, 
	 Jav03_cit_28, 
	 Jav03_cit_29, 
	 Jav03_certificaciones_lng, 
	 Jav03_cit_30, 
	 Jav03_cit_31, 
	 Jav03_cit_32, 
	 Jav03_cit_33, 
	 Jav03_cit_16, 
	 Jav03_certificaciones_tem, 
	 Jav03_cit_1, 
	 Jav03_cit_2, 
	 Jav03_cit_3, 
	 Jav03_cit_4, 
	 Jav03_cit_5, 
	 Jav03_cit_6, 
	 Jav03_sueldo_pretendido, 
 	
	 Cob04_puesto_actual, 
	 Cob04_cit_7, 
	 Cob04_cit_8, 
	 Cob04_cit_9, 
	 Cob04_cit_10, 
	 Cob04_cit_11, 
	 Cob04_cit_14, 
	 Cob04_cit_15, 
	 Cob04_certificaciones_lng, 
	 Cob04_cit_30, 
	 Cob04_cit_31, 
	 Cob04_cit_34, 
	 Cob04_cit_35, 
	 Cob04_cit_32, 
	 Cob04_cit_33, 
	 Cob04_cit_16, 
	 Cob04_certificaciones_tem, 
	 Cob04_cit_1, 
	 Cob04_cit_2, 
	 Cob04_cit_3, 
	 Cob04_cit_4, 
	 Cob04_cit_5, 
	 Cob04_cit_6, 
	 Cob04_sueldo_pretendido, 
	
	 Jav04_puesto_actual, 
	 Jav04_cit_17, 
	 Jav04_cit_18, 
	 Jav04_cit_19, 
	 Jav04_cit_20, 
	 Jav04_cit_21, 
	 Jav04_cit_22, 
	 Jav04_cit_23, 
	 Jav04_cit_24, 
	 Jav04_cit_25, 
	 Jav04_cit_26, 
	 Jav04_cit_27, 
	 Jav04_cit_28, 
	 Jav04_cit_29, 
	 Jav04_certificaciones_lng, 
	 Jav04_cit_30, 
	 Jav04_cit_31, 
	 Jav04_cit_34, 
	 Jav04_cit_35, 
	 Jav04_cit_32, 
	 Jav04_cit_33, 
	 Jav04_cit_16, 
	 Jav04_certificaciones_tem, 
	 Jav04_cit_1, 
	 Jav04_cit_2, 
	 Jav04_cit_3, 
	 Jav04_cit_4, 
	 Jav04_cit_5, 
	 Jav04_cit_6, 
	 Jav04_sueldo_pretendido, 
	
	 Ora01_puesto_actual, 
	 Ora01_cit_36, 
	 Ora01_cit_37, 
	 Ora01_cit_38, 
	 Ora01_cit_39, 
	 Ora01_cit_40, 
	 Ora01_cit_41, 
	 Ora01_cit_42, 
	 Ora01_certificaciones_lng, 
	 Ora01_cit_30, 
	 Ora01_cit_31, 
	 Ora01_cit_43, 
	 Ora01_cit_44, 
	 Ora01_cit_45, 
	 Ora01_cit_46, 
	 Ora01_cit_47, 
	 Ora01_sueldo_pretendido

FROM [dbo].[Encuesta_Puestos]
ORDER BY [Id_candidato];

-- APRETURA DEL CURSOR Encuesta_puestos_cursor
OPEN Encuesta_puestos_cursor

-- LECTURA DEL CURSOR Encuesta_puestos_cursor (PRIMER REGISTRO)
FETCH NEXT FROM Encuesta_puestos_cursor
  INTO
	@E_Id_candidato,
	@E_Vacante, 

	@E_Cob01_puesto_actual, 
	@E_Cob01_cit_7, 
	@E_Cob01_cit_8, 
	@E_Cob01_cit_9, 
	@E_Cob01_cit_10, 
	@E_Cob01_cit_11, 
	@E_Cob01_cit_12, 
	@E_Cob01_cit_13, 
	@E_Cob01_certificaciones_lng, 
	@E_Cob01_sueldo_pretendido, 
	
	@E_Cob02_puesto_actual, 
	@E_Cob02_cit_7, 
	@E_Cob02_cit_8, 
	@E_Cob02_cit_9,
    @E_Cob02_cit_10,  
	@E_Cob02_cit_11, 
	@E_Cob02_cit_12, 
	@E_Cob02_cit_13, 
	@E_Cob02_cit_14, 
	@E_Cob02_cit_15, 
	@E_Cob02_certificaciones_lng, 
	@E_Cob02_cit_16,
	@E_Cob02_certificaciones_tem, 
	@E_Cob02_cit_1, 
	@E_Cob02_cit_2, 
	@E_Cob02_cit_3, 
	@E_Cob02_cit_4, 
	@E_Cob02_cit_5, 
	@E_Cob02_cit_6, 
	@E_Cob02_sueldo_pretendido, 
	
	@E_Jav01_puesto_actual, 
	@E_Jav01_cit_17, 
	@E_Jav01_cit_18, 
	@E_Jav01_cit_19, 
	@E_Jav01_cit_20, 
	@E_Jav01_cit_21, 
    @E_Jav01_cit_22,
	@E_Jav01_cit_23, 
	@E_Jav01_cit_24, 
	@E_Jav01_cit_25, 
	@E_Jav01_cit_26, 
	@E_Jav01_cit_27, 
	@E_Jav01_cit_28, 
	@E_Jav01_cit_29, 
    @E_Jav01_certificaciones_lng,
	@E_Jav01_sueldo_pretendido, 
	
	@E_Jav02_puesto_actual, 
	@E_Jav02_cit_17, 
	@E_Jav02_cit_18, 
	@E_Jav02_cit_19, 
	@E_Jav02_cit_20, 
	@E_Jav02_cit_21, 
	@E_Jav02_cit_22, 
	@E_Jav02_cit_23, 
	@E_Jav02_cit_24, 
	@E_Jav02_cit_25, 
	@E_Jav02_cit_26, 
	@E_Jav02_cit_27, 
	@E_Jav02_cit_28, 
	@E_Jav02_cit_29, 
	@E_Jav02_certificaciones_lng, 
	@E_Jav02_cit_16, 
	@E_Jav02_certificaciones_tem, 
	@E_Jav02_cit_1, 
	@E_Jav02_cit_2, 
	@E_Jav02_cit_3, 
	@E_Jav02_cit_4, 
	@E_Jav02_cit_5, 
	@E_Jav02_cit_6, 
	@E_Jav02_sueldo_pretendido, 
	
	@E_Cob03_puesto_actual, 
	@E_Cob03_cit_7, 
	@E_Cob03_cit_8, 
	@E_Cob03_cit_9, 
	@E_Cob03_cit_10, 
	@E_Cob03_cit_11, 
	@E_Cob03_cit_12, 
	@E_Cob03_cit_13, 
	@E_Cob03_cit_14, 
	@E_Cob03_cit_15, 
	@E_Cob03_certificaciones_lng, 
	@E_Cob03_cit_30, 
	@E_Cob03_cit_31, 
	@E_Cob03_cit_32, 
	@E_Cob03_cit_33, 
	@E_Cob03_cit_16, 
	@E_Cob03_certificaciones_tem, 
	@E_Cob03_cit_1, 
	@E_Cob03_cit_2, 
	@E_Cob03_cit_3, 
	@E_Cob03_cit_4, 
	@E_Cob03_cit_5, 
	@E_Cob03_cit_6, 
	@E_Cob03_sueldo_pretendido, 
	
	@E_Jav03_puesto_actual, 
	@E_Jav03_cit_17, 
	@E_Jav03_cit_18, 
	@E_Jav03_cit_19, 
	@E_Jav03_cit_20, 
	@E_Jav03_cit_21, 
	@E_Jav03_cit_22, 
	@E_Jav03_cit_23, 
	@E_Jav03_cit_24, 
	@E_Jav03_cit_25, 
	@E_Jav03_cit_26, 
	@E_Jav03_cit_27, 
	@E_Jav03_cit_28, 
	@E_Jav03_cit_29, 
	@E_Jav03_certificaciones_lng, 
	@E_Jav03_cit_30, 
	@E_Jav03_cit_31, 
	@E_Jav03_cit_32, 
	@E_Jav03_cit_33, 
	@E_Jav03_cit_16, 
	@E_Jav03_certificaciones_tem, 
	@E_Jav03_cit_1, 
	@E_Jav03_cit_2, 
	@E_Jav03_cit_3, 
	@E_Jav03_cit_4, 
	@E_Jav03_cit_5, 
	@E_Jav03_cit_6, 
	@E_Jav03_sueldo_pretendido, 
	
	@E_Cob04_puesto_actual, 
	@E_Cob04_cit_7, 
	@E_Cob04_cit_8, 
	@E_Cob04_cit_9, 
	@E_Cob04_cit_10, 
	@E_Cob04_cit_11, 
	@E_Cob04_cit_14, 
	@E_Cob04_cit_15, 
	@E_Cob04_certificaciones_lng, 
	@E_Cob04_cit_30, 
	@E_Cob04_cit_31, 
	@E_Cob04_cit_34, 
	@E_Cob04_cit_35, 
	@E_Cob04_cit_32, 
	@E_Cob04_cit_33, 
	@E_Cob04_cit_16, 
	@E_Cob04_certificaciones_tem, 
	@E_Cob04_cit_1, 
	@E_Cob04_cit_2, 
	@E_Cob04_cit_3, 
	@E_Cob04_cit_4, 
	@E_Cob04_cit_5, 
	@E_Cob04_cit_6, 
	@E_Cob04_sueldo_pretendido, 
	
	@E_Jav04_puesto_actual, 
	@E_Jav04_cit_17, 
	@E_Jav04_cit_18, 
	@E_Jav04_cit_19, 
	@E_Jav04_cit_20, 
	@E_Jav04_cit_21, 
	@E_Jav04_cit_22, 
	@E_Jav04_cit_23, 
	@E_Jav04_cit_24, 
	@E_Jav04_cit_25, 
	@E_Jav04_cit_26, 
	@E_Jav04_cit_27, 
	@E_Jav04_cit_28, 
	@E_Jav04_cit_29, 
	@E_Jav04_certificaciones_lng, 
	@E_Jav04_cit_30, 
	@E_Jav04_cit_31, 
	@E_Jav04_cit_34, 
	@E_Jav04_cit_35, 
	@E_Jav04_cit_32, 
	@E_Jav04_cit_33, 
	@E_Jav04_cit_16, 
	@E_Jav04_certificaciones_tem, 
	@E_Jav04_cit_1, 
	@E_Jav04_cit_2, 
	@E_Jav04_cit_3, 
	@E_Jav04_cit_4, 
	@E_Jav04_cit_5, 
	@E_Jav04_cit_6, 
	@E_Jav04_sueldo_pretendido, 
	
	@E_Ora01_puesto_actual, 
	@E_Ora01_cit_36, 
	@E_Ora01_cit_37, 
	@E_Ora01_cit_38, 
	@E_Ora01_cit_39, 
	@E_Ora01_cit_40, 
	@E_Ora01_cit_41, 
	@E_Ora01_cit_42, 
	@E_Ora01_certificaciones_lng, 
	@E_Ora01_cit_30, 
	@E_Ora01_cit_31, 
	@E_Ora01_cit_43, 
	@E_Ora01_cit_44, 
	@E_Ora01_cit_45, 
	@E_Ora01_cit_46, 
	@E_Ora01_cit_47, 
	@E_Ora01_sueldo_pretendido
 

-- CICLO PARA LEER LA TABLA: Encuesta_Puestos
WHILE @@FETCH_STATUS = 0  
BEGIN  
   -- Mensaje de salida
    PRINT 'CANDIDATO: ' + @E_Id_candidato

   -- ========>>> LLENADO DE LA TABLA: Conocimientos_cand <<<<   
  
   -- Se pasan valores de la tabla: Encuesta_Puestos a tabla: Conocimientos_cand
    SET @T1_Id_candidato      = @E_Id_candidato 
	SET @T1_Ind_certificacion = 'N'
    SET @T2_Id_candidato      = @E_Id_candidato 

	-- ===== PUESTO: Desarrollador cobol
	IF @E_Vacante = 'Desarrollador Cobol'
	  BEGIN
         SET @T1_Id_puesto      = 'COB01'
         SET @T2_Id_puesto      = 'COB01'
		 SET @T2_Ind_puesto_act = substring(@E_Cob01_puesto_actual,1,1)
		 SET @T2_Sueldo         =
	      (CASE @E_Cob01_sueldo_pretendido
		    WHEN 'Prefiero no especificar'          THEN     00.00
		    WHEN 'Menos de 5,000 pesos'             THEN   5000.00
		    WHEN 'Entre 5,001 y 10,000 mil pesos'   THEN  10000.00
		    WHEN 'Entre 10,001 y 15,000 mil pesos'  THEN  15000.00
		    WHEN 'Entre 15,001 y 20,000 mil pesos'  THEN  20000.00
		    WHEN 'Entre 20,001 y 25,000 mil pesos'  THEN  25000.00
		    WHEN 'Entre 25,001 y 30,000 mil pesos'  THEN  30000.00
		    WHEN 'Entre 30,001 y 35,000 mil pesos'  THEN  35000.00
		    WHEN 'Entre 35,001 y 40,000 mil pesos'  THEN  40000.00
		    WHEN 'Entre 40,001 y 45,000 mil pesos'  THEN  45000.00
		    WHEN 'Entre 45,001 y 50,000 mil pesos'  THEN  50000.00
		    WHEN 'Entre 50,001 y 55,000 mil pesos'  THEN  55000.00
		    WHEN 'Entre 55,001 y 60,000 mil pesos'  THEN  60000.00
		    WHEN 'Entre 60,001 y 65,000 mil pesos'  THEN  65000.00
		    WHEN 'Entre 65,001 y 70,000 mil pesos'  THEN  70000.00
		    WHEN 'Entre 70,001 y 75,000 mil pesos'  THEN  75000.00
		    WHEN 'Entre 75,001 y 80,000 mil pesos'  THEN  80000.00
		    WHEN 'Entre 80,001 y 85,000 mil pesos'  THEN  85000.00
		    WHEN 'Entre 85,001 y 90,000 mil pesos'  THEN  90000.00
		    WHEN 'Entre 90,001 y 95,000 mil pesos'  THEN  95000.00
		    WHEN 'Entre 95,001 y 100,000 mil pesos' THEN 100000.00
		    WHEN 'Más de 100,000 mil pesos'         THEN 100001.00
			ELSE 999999.00
	      END
	      )

         -- INSERTA EN TABLA: Puestos_TI_cand
		 INSERT INTO [dbo].[Puestos_TI_cand] (Id_candidato, Id_puesto, Ind_puesto_act, Sueldo) VALUES (@T2_Id_candidato, @T2_Id_puesto, @T2_Ind_puesto_act, @T2_Sueldo)


         -- INSERTA EN TABLA: Conocimientos_cand
         SET @T1_Id_conoc_it  = 7   SET @T1_Anios_conoc  = @E_Cob01_cit_7   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 8   SET @T1_Anios_conoc  = @E_Cob01_cit_8   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 9   SET @T1_Anios_conoc  = @E_Cob01_cit_9   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 10  SET @T1_Anios_conoc  = @E_Cob01_cit_10  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 11  SET @T1_Anios_conoc  = @E_Cob01_cit_11  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 12  SET @T1_Anios_conoc  = @E_Cob01_cit_12  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 13  SET @T1_Anios_conoc  = @E_Cob01_cit_13  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)

		 -- Se inicializan variables
         SET @P_certificaciones  = @E_Cob01_certificaciones_lng
    	 SET @posIni = 1

		 -- Ciclo para buscar "palabras" en cadena de texto(@E_Cob01_certificaciones_lng) separadas por comas
         WHILE LEN(@P_certificaciones) > 0
         BEGIN
           SET @posFin = (SELECT CHARINDEX(',', @P_certificaciones, @posIni)) - 1
           PRINT '@posFin: ' + cast (@posFin as varchar(5))
           PRINT 'LEN(@P_certificaciones): ' + cast ( (LEN(@P_certificaciones)) as varchar(5))

		   IF @posFin <= 0
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM( (SELECT SUBSTRING (@P_certificaciones,@posIni,LEN(@P_certificaciones)) )	))
              PRINT '-----------UPDATE 2-----------: ' + @certificX
              SET @P_certificaciones = ''	

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

               -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
               IF @T1_Id_conoc_it is not null
 			    BEGIN
    		      -- UPDATE EN TABLA: Conocimientos_cand
                  UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	   WHERE Id_candidato = @T1_Id_candidato   
				     AND Id_puesto    = @T1_Id_puesto
					 AND Id_conoc_it  = @T1_Id_conoc_it
   
                  PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
                END              
            END
		   ELSE
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM ((SELECT SUBSTRING (@P_certificaciones,@posIni,@posFin) )))

              PRINT '-----------UPDATE 1-----------: ' + @certificX

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

              -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
              IF @T1_Id_conoc_it is not null
			   BEGIN
    		     -- UPDATE EN TABLA: Conocimientos_cand
                 UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	  WHERE Id_candidato = @T1_Id_candidato
				    AND Id_puesto    = @T1_Id_puesto
				 AND Id_conoc_it  = @T1_Id_conoc_it
   
                 PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
               END
    
			  SET @longNueva =LEN(@P_certificaciones) - (@posFin + 1)
      		  SET @P_certificaciones = (SELECT SUBSTRING (@P_certificaciones,@posFin + 2,@longNueva) )

              PRINT '@posFin: ' + cast (@posFin as varchar(5))
              PRINT '@longNueva: ' + cast (@longNueva as varchar(5))
              PRINT '@P_certificaciones: ' + cast (@P_certificaciones as varchar(100))
              PRINT '@P_certificaciones: ' + cast ((LEN(@P_certificaciones)) as varchar(100))

            END		 
         END
      END


	-- ===== PUESTO: Analista Cobol
	IF @E_Vacante = 'Analista Cobol'
	  BEGIN
         SET @T1_Id_puesto      = 'COB02'
         SET @T2_Id_puesto      = 'COB02'
		 SET @T2_Ind_puesto_act = substring(@E_Cob02_puesto_actual,1,1)
		 SET @T2_Sueldo         =
	      (CASE @E_Cob02_sueldo_pretendido
		    WHEN 'Prefiero no especificar'          THEN     00.00
		    WHEN 'Menos de 5,000 pesos'             THEN   5000.00
		    WHEN 'Entre 5,001 y 10,000 mil pesos'   THEN  10000.00
		    WHEN 'Entre 10,001 y 15,000 mil pesos'  THEN  15000.00
		    WHEN 'Entre 15,001 y 20,000 mil pesos'  THEN  20000.00
		    WHEN 'Entre 20,001 y 25,000 mil pesos'  THEN  25000.00
		    WHEN 'Entre 25,001 y 30,000 mil pesos'  THEN  30000.00
		    WHEN 'Entre 30,001 y 35,000 mil pesos'  THEN  35000.00
		    WHEN 'Entre 35,001 y 40,000 mil pesos'  THEN  40000.00
		    WHEN 'Entre 40,001 y 45,000 mil pesos'  THEN  45000.00
		    WHEN 'Entre 45,001 y 50,000 mil pesos'  THEN  50000.00
		    WHEN 'Entre 50,001 y 55,000 mil pesos'  THEN  55000.00
		    WHEN 'Entre 55,001 y 60,000 mil pesos'  THEN  60000.00
		    WHEN 'Entre 60,001 y 65,000 mil pesos'  THEN  65000.00
		    WHEN 'Entre 65,001 y 70,000 mil pesos'  THEN  70000.00
		    WHEN 'Entre 70,001 y 75,000 mil pesos'  THEN  75000.00
		    WHEN 'Entre 75,001 y 80,000 mil pesos'  THEN  80000.00
		    WHEN 'Entre 80,001 y 85,000 mil pesos'  THEN  85000.00
		    WHEN 'Entre 85,001 y 90,000 mil pesos'  THEN  90000.00
		    WHEN 'Entre 90,001 y 95,000 mil pesos'  THEN  95000.00
		    WHEN 'Entre 95,001 y 100,000 mil pesos' THEN 100000.00
		    WHEN 'Más de 100,000 mil pesos'         THEN 100001.00
			ELSE 999999.00
	      END
	      )

         -- INSERTA EN TABLA: Puestos_TI_cand
		 INSERT INTO [dbo].[Puestos_TI_cand] (Id_candidato, Id_puesto, Ind_puesto_act, Sueldo) VALUES (@T2_Id_candidato, @T2_Id_puesto, @T2_Ind_puesto_act, @T2_Sueldo)

         -- INSERTA EN TABLA: Conocimientos_cand
         SET @T1_Id_conoc_it  = 7   SET @T1_Anios_conoc  = @E_Cob02_cit_7   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 8   SET @T1_Anios_conoc  = @E_Cob02_cit_8   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 9   SET @T1_Anios_conoc  = @E_Cob02_cit_9   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 10  SET @T1_Anios_conoc  = @E_Cob02_cit_10  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 11  SET @T1_Anios_conoc  = @E_Cob02_cit_11  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 12  SET @T1_Anios_conoc  = @E_Cob02_cit_12  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 13  SET @T1_Anios_conoc  = @E_Cob02_cit_13  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 14  SET @T1_Anios_conoc  = @E_Cob02_cit_14  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 15  SET @T1_Anios_conoc  = @E_Cob02_cit_15  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)

         SET @T1_Id_conoc_it  = 16  SET @T1_Anios_conoc  = @E_Cob02_cit_16  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)

         SET @T1_Id_conoc_it  = 1   SET @T1_Anios_conoc  = @E_Cob02_cit_1  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 2   SET @T1_Anios_conoc  = @E_Cob02_cit_2  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 3   SET @T1_Anios_conoc  = @E_Cob02_cit_3  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 4   SET @T1_Anios_conoc  = @E_Cob02_cit_4  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 5   SET @T1_Anios_conoc  = @E_Cob02_cit_5  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 6   SET @T1_Anios_conoc  = @E_Cob02_cit_6  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)

		 -- Se inicializan variables
         SET @P_certificaciones  = @E_Cob02_certificaciones_lng
    	 SET @posIni = 1

		 -- Ciclo para buscar "palabras" en cadena de texto(@E_Cob01_certificaciones_lng) separadas por comas
         WHILE LEN(@P_certificaciones) > 0
         BEGIN
           SET @posFin = (SELECT CHARINDEX(',', @P_certificaciones, @posIni)) - 1
           PRINT '@posFin: ' + cast (@posFin as varchar(5))
           PRINT 'LEN(@P_certificaciones): ' + cast ( (LEN(@P_certificaciones)) as varchar(5))

		   IF @posFin <= 0
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM( (SELECT SUBSTRING (@P_certificaciones,@posIni,LEN(@P_certificaciones)) )	))
              PRINT '-----------UPDATE 2-----------: ' + @certificX
              SET @P_certificaciones = ''	

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

               -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
               IF @T1_Id_conoc_it is not null
 			    BEGIN
    		      -- UPDATE EN TABLA: Conocimientos_cand
                  UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	   WHERE Id_candidato = @T1_Id_candidato   
				     AND Id_puesto    = @T1_Id_puesto
					 AND Id_conoc_it  = @T1_Id_conoc_it
   
                  PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
                END              
            END
		   ELSE
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM ((SELECT SUBSTRING (@P_certificaciones,@posIni,@posFin) )))

              PRINT '-----------UPDATE 1-----------: ' + @certificX

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

              -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
              IF @T1_Id_conoc_it is not null
			   BEGIN
    		     -- UPDATE EN TABLA: Conocimientos_cand
                 UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	  WHERE Id_candidato = @T1_Id_candidato
				    AND Id_puesto    = @T1_Id_puesto
				 AND Id_conoc_it  = @T1_Id_conoc_it
   
                 PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
               END
    
			  SET @longNueva =LEN(@P_certificaciones) - (@posFin + 1)
      		  SET @P_certificaciones = (SELECT SUBSTRING (@P_certificaciones,@posFin + 2,@longNueva) )

              PRINT '@posFin: ' + cast (@posFin as varchar(5))
              PRINT '@longNueva: ' + cast (@longNueva as varchar(5))
              PRINT '@P_certificaciones: ' + cast (@P_certificaciones as varchar(100))
              PRINT '@P_certificaciones: ' + cast ((LEN(@P_certificaciones)) as varchar(100))

            END		 
         END

		 -- Se inicializan variables
         SET @P_certificaciones  = @E_Cob02_certificaciones_tem
    	 SET @posIni = 1

		 -- Ciclo para buscar "palabras" en cadena de texto(@E_Cob01_certificaciones_tem) separadas por comas
         WHILE LEN(@P_certificaciones) > 0
         BEGIN
           SET @posFin = (SELECT CHARINDEX(',', @P_certificaciones, @posIni)) - 1
           PRINT '@posFin: ' + cast (@posFin as varchar(5))
           PRINT 'LEN(@P_certificaciones): ' + cast ( (LEN(@P_certificaciones)) as varchar(5))

		   IF @posFin <= 0
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM( (SELECT SUBSTRING (@P_certificaciones,@posIni,LEN(@P_certificaciones)) )	))
              PRINT '-----------UPDATE 2-----------: ' + @certificX
              SET @P_certificaciones = ''	

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

               -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
               IF @T1_Id_conoc_it is not null
 			    BEGIN
    		      -- UPDATE EN TABLA: Conocimientos_cand
                  UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	   WHERE Id_candidato = @T1_Id_candidato   
				     AND Id_puesto    = @T1_Id_puesto
					 AND Id_conoc_it  = @T1_Id_conoc_it
   
                  PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
                END              
            END
		   ELSE
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM ((SELECT SUBSTRING (@P_certificaciones,@posIni,@posFin) )))

              PRINT '-----------UPDATE 1-----------: ' + @certificX

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

              -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
              IF @T1_Id_conoc_it is not null
			   BEGIN
    		     -- UPDATE EN TABLA: Conocimientos_cand
                 UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	  WHERE Id_candidato = @T1_Id_candidato
				    AND Id_puesto    = @T1_Id_puesto
				 AND Id_conoc_it  = @T1_Id_conoc_it
   
                 PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
               END
    
			  SET @longNueva =LEN(@P_certificaciones) - (@posFin + 1)
      		  SET @P_certificaciones = (SELECT SUBSTRING (@P_certificaciones,@posFin + 2,@longNueva) )

              PRINT '@posFin: ' + cast (@posFin as varchar(5))
              PRINT '@longNueva: ' + cast (@longNueva as varchar(5))
              PRINT '@P_certificaciones: ' + cast (@P_certificaciones as varchar(100))
              PRINT '@P_certificaciones: ' + cast ((LEN(@P_certificaciones)) as varchar(100))

            END		 
         END


      END

	-- ===== PUESTO: Líder de Proyecto Cobol
	IF @E_Vacante = 'Líder de Proyecto Cobol'
	  BEGIN
         SET @T1_Id_puesto      = 'COB03'
         SET @T2_Id_puesto      = 'COB03'
		 SET @T2_Ind_puesto_act = substring(@E_Cob03_puesto_actual,1,1)
		 SET @T2_Sueldo         =
	      (CASE @E_Cob03_sueldo_pretendido
		    WHEN 'Prefiero no especificar'          THEN     00.00
		    WHEN 'Menos de 5,000 pesos'             THEN   5000.00
		    WHEN 'Entre 5,001 y 10,000 mil pesos'   THEN  10000.00
		    WHEN 'Entre 10,001 y 15,000 mil pesos'  THEN  15000.00
		    WHEN 'Entre 15,001 y 20,000 mil pesos'  THEN  20000.00
		    WHEN 'Entre 20,001 y 25,000 mil pesos'  THEN  25000.00
		    WHEN 'Entre 25,001 y 30,000 mil pesos'  THEN  30000.00
		    WHEN 'Entre 30,001 y 35,000 mil pesos'  THEN  35000.00
		    WHEN 'Entre 35,001 y 40,000 mil pesos'  THEN  40000.00
		    WHEN 'Entre 40,001 y 45,000 mil pesos'  THEN  45000.00
		    WHEN 'Entre 45,001 y 50,000 mil pesos'  THEN  50000.00
		    WHEN 'Entre 50,001 y 55,000 mil pesos'  THEN  55000.00
		    WHEN 'Entre 55,001 y 60,000 mil pesos'  THEN  60000.00
		    WHEN 'Entre 60,001 y 65,000 mil pesos'  THEN  65000.00
		    WHEN 'Entre 65,001 y 70,000 mil pesos'  THEN  70000.00
		    WHEN 'Entre 70,001 y 75,000 mil pesos'  THEN  75000.00
		    WHEN 'Entre 75,001 y 80,000 mil pesos'  THEN  80000.00
		    WHEN 'Entre 80,001 y 85,000 mil pesos'  THEN  85000.00
		    WHEN 'Entre 85,001 y 90,000 mil pesos'  THEN  90000.00
		    WHEN 'Entre 90,001 y 95,000 mil pesos'  THEN  95000.00
		    WHEN 'Entre 95,001 y 100,000 mil pesos' THEN 100000.00
		    WHEN 'Más de 100,000 mil pesos'         THEN 100001.00
			ELSE 999999.00
	      END
	      )

         -- INSERTA EN TABLA: Puestos_TI_cand
		 INSERT INTO [dbo].[Puestos_TI_cand] (Id_candidato, Id_puesto, Ind_puesto_act, Sueldo) VALUES (@T2_Id_candidato, @T2_Id_puesto, @T2_Ind_puesto_act, @T2_Sueldo)

         -- INSERTA EN TABLA: Conocimientos_cand
         SET @T1_Id_conoc_it  = 7   SET @T1_Anios_conoc  = @E_Cob03_cit_7   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 8   SET @T1_Anios_conoc  = @E_Cob03_cit_8   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 9   SET @T1_Anios_conoc  = @E_Cob03_cit_9   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 10  SET @T1_Anios_conoc  = @E_Cob03_cit_10  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 11  SET @T1_Anios_conoc  = @E_Cob03_cit_11  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 12  SET @T1_Anios_conoc  = @E_Cob03_cit_12  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 13  SET @T1_Anios_conoc  = @E_Cob03_cit_13  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 14  SET @T1_Anios_conoc  = @E_Cob03_cit_14  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 15  SET @T1_Anios_conoc  = @E_Cob03_cit_15  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)

         SET @T1_Id_conoc_it  = 30  SET @T1_Anios_conoc  = @E_Cob03_cit_30  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 31  SET @T1_Anios_conoc  = @E_Cob03_cit_31  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 32  SET @T1_Anios_conoc  = @E_Cob03_cit_32  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 33  SET @T1_Anios_conoc  = @E_Cob03_cit_33  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 16  SET @T1_Anios_conoc  = @E_Cob03_cit_16  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)

         SET @T1_Id_conoc_it  = 1   SET @T1_Anios_conoc  = @E_Cob03_cit_1  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 2   SET @T1_Anios_conoc  = @E_Cob03_cit_2  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 3   SET @T1_Anios_conoc  = @E_Cob03_cit_3  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 4   SET @T1_Anios_conoc  = @E_Cob03_cit_4  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 5   SET @T1_Anios_conoc  = @E_Cob03_cit_5  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 6   SET @T1_Anios_conoc  = @E_Cob03_cit_6  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)

		 -- Se inicializan variables
         SET @P_certificaciones  = @E_Cob03_certificaciones_lng
    	 SET @posIni = 1

		 -- Ciclo para buscar "palabras" en cadena de texto(@E_Cob01_certificaciones_lng) separadas por comas
         WHILE LEN(@P_certificaciones) > 0
         BEGIN
           SET @posFin = (SELECT CHARINDEX(',', @P_certificaciones, @posIni)) - 1
           PRINT '@posFin: ' + cast (@posFin as varchar(5))
           PRINT 'LEN(@P_certificaciones): ' + cast ( (LEN(@P_certificaciones)) as varchar(5))

		   IF @posFin <= 0
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM( (SELECT SUBSTRING (@P_certificaciones,@posIni,LEN(@P_certificaciones)) )	))
              PRINT '-----------UPDATE 2-----------: ' + @certificX
              SET @P_certificaciones = ''	

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

               -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
               IF @T1_Id_conoc_it is not null
 			    BEGIN
    		      -- UPDATE EN TABLA: Conocimientos_cand
                  UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	   WHERE Id_candidato = @T1_Id_candidato   
				     AND Id_puesto    = @T1_Id_puesto
					 AND Id_conoc_it  = @T1_Id_conoc_it
   
                  PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
                END              
            END
		   ELSE
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM ((SELECT SUBSTRING (@P_certificaciones,@posIni,@posFin) )))

              PRINT '-----------UPDATE 1-----------: ' + @certificX

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

              -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
              IF @T1_Id_conoc_it is not null
			   BEGIN
    		     -- UPDATE EN TABLA: Conocimientos_cand
                 UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	  WHERE Id_candidato = @T1_Id_candidato
				    AND Id_puesto    = @T1_Id_puesto
				 AND Id_conoc_it  = @T1_Id_conoc_it
   
                 PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
               END
    
			  SET @longNueva =LEN(@P_certificaciones) - (@posFin + 1)
      		  SET @P_certificaciones = (SELECT SUBSTRING (@P_certificaciones,@posFin + 2,@longNueva) )

              PRINT '@posFin: ' + cast (@posFin as varchar(5))
              PRINT '@longNueva: ' + cast (@longNueva as varchar(5))
              PRINT '@P_certificaciones: ' + cast (@P_certificaciones as varchar(100))
              PRINT '@P_certificaciones: ' + cast ((LEN(@P_certificaciones)) as varchar(100))

            END		 
         END

		 -- Se inicializan variables
         SET @P_certificaciones  = @E_Cob03_certificaciones_tem
    	 SET @posIni = 1

		 -- Ciclo para buscar "palabras" en cadena de texto(@E_Cob01_certificaciones_tem) separadas por comas
         WHILE LEN(@P_certificaciones) > 0
         BEGIN
           SET @posFin = (SELECT CHARINDEX(',', @P_certificaciones, @posIni)) - 1
           PRINT '@posFin: ' + cast (@posFin as varchar(5))
           PRINT 'LEN(@P_certificaciones): ' + cast ( (LEN(@P_certificaciones)) as varchar(5))

		   IF @posFin <= 0
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM( (SELECT SUBSTRING (@P_certificaciones,@posIni,LEN(@P_certificaciones)) )	))
              PRINT '-----------UPDATE 2-----------: ' + @certificX
              SET @P_certificaciones = ''	

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

               -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
               IF @T1_Id_conoc_it is not null
 			    BEGIN
    		      -- UPDATE EN TABLA: Conocimientos_cand
                  UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	   WHERE Id_candidato = @T1_Id_candidato   
				     AND Id_puesto    = @T1_Id_puesto
					 AND Id_conoc_it  = @T1_Id_conoc_it
   
                  PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
                END              
            END
		   ELSE
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM ((SELECT SUBSTRING (@P_certificaciones,@posIni,@posFin) )))

              PRINT '-----------UPDATE 1-----------: ' + @certificX

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

              -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
              IF @T1_Id_conoc_it is not null
			   BEGIN
    		     -- UPDATE EN TABLA: Conocimientos_cand
                 UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	  WHERE Id_candidato = @T1_Id_candidato
				    AND Id_puesto    = @T1_Id_puesto
				 AND Id_conoc_it  = @T1_Id_conoc_it
   
                 PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
               END
    
			  SET @longNueva =LEN(@P_certificaciones) - (@posFin + 1)
      		  SET @P_certificaciones = (SELECT SUBSTRING (@P_certificaciones,@posFin + 2,@longNueva) )

              PRINT '@posFin: ' + cast (@posFin as varchar(5))
              PRINT '@longNueva: ' + cast (@longNueva as varchar(5))
              PRINT '@P_certificaciones: ' + cast (@P_certificaciones as varchar(100))
              PRINT '@P_certificaciones: ' + cast ((LEN(@P_certificaciones)) as varchar(100))

            END		 
         END


      END

	-- ===== PUESTO: Gerente perfil Cobol
	IF @E_Vacante = 'Gerente perfil Cobol'
	  BEGIN
         SET @T1_Id_puesto      = 'COB04'
         SET @T2_Id_puesto      = 'COB04'
		 SET @T2_Ind_puesto_act = substring(@E_Cob04_puesto_actual,1,1)
		 SET @T2_Sueldo         =
	      (CASE @E_Cob04_sueldo_pretendido
		    WHEN 'Prefiero no especificar'          THEN     00.00
		    WHEN 'Menos de 5,000 pesos'             THEN   5000.00
		    WHEN 'Entre 5,001 y 10,000 mil pesos'   THEN  10000.00
		    WHEN 'Entre 10,001 y 15,000 mil pesos'  THEN  15000.00
		    WHEN 'Entre 15,001 y 20,000 mil pesos'  THEN  20000.00
		    WHEN 'Entre 20,001 y 25,000 mil pesos'  THEN  25000.00
		    WHEN 'Entre 25,001 y 30,000 mil pesos'  THEN  30000.00
		    WHEN 'Entre 30,001 y 35,000 mil pesos'  THEN  35000.00
		    WHEN 'Entre 35,001 y 40,000 mil pesos'  THEN  40000.00
		    WHEN 'Entre 40,001 y 45,000 mil pesos'  THEN  45000.00
		    WHEN 'Entre 45,001 y 50,000 mil pesos'  THEN  50000.00
		    WHEN 'Entre 50,001 y 55,000 mil pesos'  THEN  55000.00
		    WHEN 'Entre 55,001 y 60,000 mil pesos'  THEN  60000.00
		    WHEN 'Entre 60,001 y 65,000 mil pesos'  THEN  65000.00
		    WHEN 'Entre 65,001 y 70,000 mil pesos'  THEN  70000.00
		    WHEN 'Entre 70,001 y 75,000 mil pesos'  THEN  75000.00
		    WHEN 'Entre 75,001 y 80,000 mil pesos'  THEN  80000.00
		    WHEN 'Entre 80,001 y 85,000 mil pesos'  THEN  85000.00
		    WHEN 'Entre 85,001 y 90,000 mil pesos'  THEN  90000.00
		    WHEN 'Entre 90,001 y 95,000 mil pesos'  THEN  95000.00
		    WHEN 'Entre 95,001 y 100,000 mil pesos' THEN 100000.00
		    WHEN 'Más de 100,000 mil pesos'         THEN 100001.00
			ELSE 999999.00
	      END
	      )

         -- INSERTA EN TABLA: Puestos_TI_cand
		 INSERT INTO [dbo].[Puestos_TI_cand] (Id_candidato, Id_puesto, Ind_puesto_act, Sueldo) VALUES (@T2_Id_candidato, @T2_Id_puesto, @T2_Ind_puesto_act, @T2_Sueldo)

         -- INSERTA EN TABLA: Conocimientos_cand
         SET @T1_Id_conoc_it  = 7   SET @T1_Anios_conoc  = @E_Cob04_cit_7   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 8   SET @T1_Anios_conoc  = @E_Cob04_cit_8   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 9   SET @T1_Anios_conoc  = @E_Cob04_cit_9   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 10  SET @T1_Anios_conoc  = @E_Cob04_cit_10  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 11  SET @T1_Anios_conoc  = @E_Cob04_cit_11  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 14  SET @T1_Anios_conoc  = @E_Cob04_cit_14  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 15  SET @T1_Anios_conoc  = @E_Cob04_cit_15  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)

         SET @T1_Id_conoc_it  = 30  SET @T1_Anios_conoc  = @E_Cob04_cit_30  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 31  SET @T1_Anios_conoc  = @E_Cob04_cit_31  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 34  SET @T1_Anios_conoc  = @E_Cob04_cit_34  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 35  SET @T1_Anios_conoc  = @E_Cob04_cit_35  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 32  SET @T1_Anios_conoc  = @E_Cob04_cit_32  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 33  SET @T1_Anios_conoc  = @E_Cob04_cit_33  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 16  SET @T1_Anios_conoc  = @E_Cob04_cit_16  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)

         SET @T1_Id_conoc_it  = 1   SET @T1_Anios_conoc  = @E_Cob04_cit_1  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 2   SET @T1_Anios_conoc  = @E_Cob04_cit_2  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 3   SET @T1_Anios_conoc  = @E_Cob04_cit_3  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 4   SET @T1_Anios_conoc  = @E_Cob04_cit_4  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 5   SET @T1_Anios_conoc  = @E_Cob04_cit_5  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 6   SET @T1_Anios_conoc  = @E_Cob04_cit_6  INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)

		 -- Se inicializan variables
         SET @P_certificaciones  = @E_Cob04_certificaciones_lng
    	 SET @posIni = 1

		 -- Ciclo para buscar "palabras" en cadena de texto(@E_Cob01_certificaciones_lng) separadas por comas
         WHILE LEN(@P_certificaciones) > 0
         BEGIN
           SET @posFin = (SELECT CHARINDEX(',', @P_certificaciones, @posIni)) - 1
           PRINT '@posFin: ' + cast (@posFin as varchar(5))
           PRINT 'LEN(@P_certificaciones): ' + cast ( (LEN(@P_certificaciones)) as varchar(5))

		   IF @posFin <= 0
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM( (SELECT SUBSTRING (@P_certificaciones,@posIni,LEN(@P_certificaciones)) )	))
              PRINT '-----------UPDATE 2-----------: ' + @certificX
              SET @P_certificaciones = ''	

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

               -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
               IF @T1_Id_conoc_it is not null
 			    BEGIN
    		      -- UPDATE EN TABLA: Conocimientos_cand
                  UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	   WHERE Id_candidato = @T1_Id_candidato   
				     AND Id_puesto    = @T1_Id_puesto
					 AND Id_conoc_it  = @T1_Id_conoc_it
   
                  PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
                END              
            END
		   ELSE
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM ((SELECT SUBSTRING (@P_certificaciones,@posIni,@posFin) )))

              PRINT '-----------UPDATE 1-----------: ' + @certificX

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

              -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
              IF @T1_Id_conoc_it is not null
			   BEGIN
    		     -- UPDATE EN TABLA: Conocimientos_cand
                 UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	  WHERE Id_candidato = @T1_Id_candidato
				    AND Id_puesto    = @T1_Id_puesto
				 AND Id_conoc_it  = @T1_Id_conoc_it
   
                 PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
               END
    
			  SET @longNueva =LEN(@P_certificaciones) - (@posFin + 1)
      		  SET @P_certificaciones = (SELECT SUBSTRING (@P_certificaciones,@posFin + 2,@longNueva) )

              PRINT '@posFin: ' + cast (@posFin as varchar(5))
              PRINT '@longNueva: ' + cast (@longNueva as varchar(5))
              PRINT '@P_certificaciones: ' + cast (@P_certificaciones as varchar(100))
              PRINT '@P_certificaciones: ' + cast ((LEN(@P_certificaciones)) as varchar(100))

            END		 
         END

		 -- Se inicializan variables
         SET @P_certificaciones  = @E_Cob04_certificaciones_tem
    	 SET @posIni = 1

		 -- Ciclo para buscar "palabras" en cadena de texto(@E_Cob01_certificaciones_tem) separadas por comas
         WHILE LEN(@P_certificaciones) > 0
         BEGIN
           SET @posFin = (SELECT CHARINDEX(',', @P_certificaciones, @posIni)) - 1
           PRINT '@posFin: ' + cast (@posFin as varchar(5))
           PRINT 'LEN(@P_certificaciones): ' + cast ( (LEN(@P_certificaciones)) as varchar(5))

		   IF @posFin <= 0
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM( (SELECT SUBSTRING (@P_certificaciones,@posIni,LEN(@P_certificaciones)) )	))
              PRINT '-----------UPDATE 2-----------: ' + @certificX
              SET @P_certificaciones = ''	

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

               -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
               IF @T1_Id_conoc_it is not null
 			    BEGIN
    		      -- UPDATE EN TABLA: Conocimientos_cand
                  UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	   WHERE Id_candidato = @T1_Id_candidato   
				     AND Id_puesto    = @T1_Id_puesto
					 AND Id_conoc_it  = @T1_Id_conoc_it
   
                  PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
                END              
            END
		   ELSE
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM ((SELECT SUBSTRING (@P_certificaciones,@posIni,@posFin) )))

              PRINT '-----------UPDATE 1-----------: ' + @certificX

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

              -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
              IF @T1_Id_conoc_it is not null
			   BEGIN
    		     -- UPDATE EN TABLA: Conocimientos_cand
                 UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	  WHERE Id_candidato = @T1_Id_candidato
				    AND Id_puesto    = @T1_Id_puesto
				 AND Id_conoc_it  = @T1_Id_conoc_it
   
                 PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
               END
    
			  SET @longNueva =LEN(@P_certificaciones) - (@posFin + 1)
      		  SET @P_certificaciones = (SELECT SUBSTRING (@P_certificaciones,@posFin + 2,@longNueva) )

              PRINT '@posFin: ' + cast (@posFin as varchar(5))
              PRINT '@longNueva: ' + cast (@longNueva as varchar(5))
              PRINT '@P_certificaciones: ' + cast (@P_certificaciones as varchar(100))
              PRINT '@P_certificaciones: ' + cast ((LEN(@P_certificaciones)) as varchar(100))

            END		 
         END


      END

	-- ===== PUESTO: Desarrollador Java
	IF @E_Vacante = 'Desarrollador Java'
	  BEGIN
         SET @T1_Id_puesto      = 'JAV01'
         SET @T2_Id_puesto      = 'JAV01'
		 SET @T2_Ind_puesto_act = substring(@E_Jav01_puesto_actual,1,1)
		 SET @T2_Sueldo         =
	      (CASE @E_Jav01_sueldo_pretendido
		    WHEN 'Prefiero no especificar'          THEN     00.00
		    WHEN 'Menos de 5,000 pesos'             THEN   5000.00
		    WHEN 'Entre 5,001 y 10,000 mil pesos'   THEN  10000.00
		    WHEN 'Entre 10,001 y 15,000 mil pesos'  THEN  15000.00
		    WHEN 'Entre 15,001 y 20,000 mil pesos'  THEN  20000.00
		    WHEN 'Entre 20,001 y 25,000 mil pesos'  THEN  25000.00
		    WHEN 'Entre 25,001 y 30,000 mil pesos'  THEN  30000.00
		    WHEN 'Entre 30,001 y 35,000 mil pesos'  THEN  35000.00
		    WHEN 'Entre 35,001 y 40,000 mil pesos'  THEN  40000.00
		    WHEN 'Entre 40,001 y 45,000 mil pesos'  THEN  45000.00
		    WHEN 'Entre 45,001 y 50,000 mil pesos'  THEN  50000.00
		    WHEN 'Entre 50,001 y 55,000 mil pesos'  THEN  55000.00
		    WHEN 'Entre 55,001 y 60,000 mil pesos'  THEN  60000.00
		    WHEN 'Entre 60,001 y 65,000 mil pesos'  THEN  65000.00
		    WHEN 'Entre 65,001 y 70,000 mil pesos'  THEN  70000.00
		    WHEN 'Entre 70,001 y 75,000 mil pesos'  THEN  75000.00
		    WHEN 'Entre 75,001 y 80,000 mil pesos'  THEN  80000.00
		    WHEN 'Entre 80,001 y 85,000 mil pesos'  THEN  85000.00
		    WHEN 'Entre 85,001 y 90,000 mil pesos'  THEN  90000.00
		    WHEN 'Entre 90,001 y 95,000 mil pesos'  THEN  95000.00
		    WHEN 'Entre 95,001 y 100,000 mil pesos' THEN 100000.00
		    WHEN 'Más de 100,000 mil pesos'         THEN 100001.00
			ELSE 999999.00
	      END
	      )

         -- INSERTA EN TABLA: Puestos_TI_cand
		 INSERT INTO [dbo].[Puestos_TI_cand] (Id_candidato, Id_puesto, Ind_puesto_act, Sueldo) VALUES (@T2_Id_candidato, @T2_Id_puesto, @T2_Ind_puesto_act, @T2_Sueldo)

         -- INSERTA EN TABLA: Conocimientos_cand
         SET @T1_Id_conoc_it  = 17  SET @T1_Anios_conoc  = @E_Jav01_cit_17   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 18  SET @T1_Anios_conoc  = @E_Jav01_cit_18   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 19  SET @T1_Anios_conoc  = @E_Jav01_cit_19   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 20  SET @T1_Anios_conoc  = @E_Jav01_cit_20   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 21  SET @T1_Anios_conoc  = @E_Jav01_cit_21   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 22  SET @T1_Anios_conoc  = @E_Jav01_cit_22   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 23  SET @T1_Anios_conoc  = @E_Jav01_cit_23   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 24  SET @T1_Anios_conoc  = @E_Jav01_cit_24   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 25  SET @T1_Anios_conoc  = @E_Jav01_cit_25   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 26  SET @T1_Anios_conoc  = @E_Jav01_cit_26   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 27  SET @T1_Anios_conoc  = @E_Jav01_cit_27   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 28  SET @T1_Anios_conoc  = @E_Jav01_cit_28   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 29  SET @T1_Anios_conoc  = @E_Jav01_cit_29   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)

		 -- Se inicializan variables
         SET @P_certificaciones  = @E_Jav01_certificaciones_lng
    	 SET @posIni = 1

		 -- Ciclo para buscar "palabras" en cadena de texto(@E_Cob01_certificaciones_lng) separadas por comas
         WHILE LEN(@P_certificaciones) > 0
         BEGIN
           SET @posFin = (SELECT CHARINDEX(',', @P_certificaciones, @posIni)) - 1
           PRINT '@posFin: ' + cast (@posFin as varchar(5))
           PRINT 'LEN(@P_certificaciones): ' + cast ( (LEN(@P_certificaciones)) as varchar(5))

		   IF @posFin <= 0
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM( (SELECT SUBSTRING (@P_certificaciones,@posIni,LEN(@P_certificaciones)) )	))
              PRINT '-----------UPDATE 2-----------: ' + @certificX
              SET @P_certificaciones = ''	

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

               -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
               IF @T1_Id_conoc_it is not null
 			    BEGIN
    		      -- UPDATE EN TABLA: Conocimientos_cand
                  UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	   WHERE Id_candidato = @T1_Id_candidato   
				     AND Id_puesto    = @T1_Id_puesto
					 AND Id_conoc_it  = @T1_Id_conoc_it
   
                  PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
                END              
            END
		   ELSE
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM ((SELECT SUBSTRING (@P_certificaciones,@posIni,@posFin) )))

              PRINT '-----------UPDATE 1-----------: ' + @certificX

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

              -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
              IF @T1_Id_conoc_it is not null
			   BEGIN
    		     -- UPDATE EN TABLA: Conocimientos_cand
                 UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	  WHERE Id_candidato = @T1_Id_candidato
				    AND Id_puesto    = @T1_Id_puesto
				 AND Id_conoc_it  = @T1_Id_conoc_it
   
                 PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
               END
    
			  SET @longNueva =LEN(@P_certificaciones) - (@posFin + 1)
      		  SET @P_certificaciones = (SELECT SUBSTRING (@P_certificaciones,@posFin + 2,@longNueva) )

              PRINT '@posFin: ' + cast (@posFin as varchar(5))
              PRINT '@longNueva: ' + cast (@longNueva as varchar(5))
              PRINT '@P_certificaciones: ' + cast (@P_certificaciones as varchar(100))
              PRINT '@P_certificaciones: ' + cast ((LEN(@P_certificaciones)) as varchar(100))

            END		 
         END
      END


	-- ===== PUESTO: Analista Java
	IF @E_Vacante = 'Analista Java'
	  BEGIN
         SET @T1_Id_puesto      = 'JAV02'
         SET @T2_Id_puesto      = 'JAV02'
		 SET @T2_Ind_puesto_act = substring(@E_Jav02_puesto_actual,1,1)
		 SET @T2_Sueldo         =
	      (CASE @E_Jav02_sueldo_pretendido
		    WHEN 'Prefiero no especificar'          THEN     00.00
		    WHEN 'Menos de 5,000 pesos'             THEN   5000.00
		    WHEN 'Entre 5,001 y 10,000 mil pesos'   THEN  10000.00
		    WHEN 'Entre 10,001 y 15,000 mil pesos'  THEN  15000.00
		    WHEN 'Entre 15,001 y 20,000 mil pesos'  THEN  20000.00
		    WHEN 'Entre 20,001 y 25,000 mil pesos'  THEN  25000.00
		    WHEN 'Entre 25,001 y 30,000 mil pesos'  THEN  30000.00
		    WHEN 'Entre 30,001 y 35,000 mil pesos'  THEN  35000.00
		    WHEN 'Entre 35,001 y 40,000 mil pesos'  THEN  40000.00
		    WHEN 'Entre 40,001 y 45,000 mil pesos'  THEN  45000.00
		    WHEN 'Entre 45,001 y 50,000 mil pesos'  THEN  50000.00
		    WHEN 'Entre 50,001 y 55,000 mil pesos'  THEN  55000.00
		    WHEN 'Entre 55,001 y 60,000 mil pesos'  THEN  60000.00
		    WHEN 'Entre 60,001 y 65,000 mil pesos'  THEN  65000.00
		    WHEN 'Entre 65,001 y 70,000 mil pesos'  THEN  70000.00
		    WHEN 'Entre 70,001 y 75,000 mil pesos'  THEN  75000.00
		    WHEN 'Entre 75,001 y 80,000 mil pesos'  THEN  80000.00
		    WHEN 'Entre 80,001 y 85,000 mil pesos'  THEN  85000.00
		    WHEN 'Entre 85,001 y 90,000 mil pesos'  THEN  90000.00
		    WHEN 'Entre 90,001 y 95,000 mil pesos'  THEN  95000.00
		    WHEN 'Entre 95,001 y 100,000 mil pesos' THEN 100000.00
		    WHEN 'Más de 100,000 mil pesos'         THEN 100001.00
			ELSE 999999.00
	      END
	      )

         -- INSERTA EN TABLA: Puestos_TI_cand
		 INSERT INTO [dbo].[Puestos_TI_cand] (Id_candidato, Id_puesto, Ind_puesto_act, Sueldo) VALUES (@T2_Id_candidato, @T2_Id_puesto, @T2_Ind_puesto_act, @T2_Sueldo)

         -- INSERTA EN TABLA: Conocimientos_cand
         SET @T1_Id_conoc_it  = 17  SET @T1_Anios_conoc  = @E_Jav02_cit_17   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 18  SET @T1_Anios_conoc  = @E_Jav02_cit_18   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 19  SET @T1_Anios_conoc  = @E_Jav02_cit_19   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 20  SET @T1_Anios_conoc  = @E_Jav02_cit_20   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 21  SET @T1_Anios_conoc  = @E_Jav02_cit_21   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 22  SET @T1_Anios_conoc  = @E_Jav02_cit_22   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 23  SET @T1_Anios_conoc  = @E_Jav02_cit_23   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 24  SET @T1_Anios_conoc  = @E_Jav02_cit_24   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 25  SET @T1_Anios_conoc  = @E_Jav02_cit_25   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 26  SET @T1_Anios_conoc  = @E_Jav02_cit_26   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 27  SET @T1_Anios_conoc  = @E_Jav02_cit_27   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 28  SET @T1_Anios_conoc  = @E_Jav02_cit_28   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 29  SET @T1_Anios_conoc  = @E_Jav02_cit_29   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)

         SET @T1_Id_conoc_it  = 16  SET @T1_Anios_conoc  = @E_Jav02_cit_16   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)

         SET @T1_Id_conoc_it  = 1   SET @T1_Anios_conoc  = @E_Jav02_cit_1    INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 2   SET @T1_Anios_conoc  = @E_Jav02_cit_2    INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 3   SET @T1_Anios_conoc  = @E_Jav02_cit_3    INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 4   SET @T1_Anios_conoc  = @E_Jav02_cit_4    INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 5   SET @T1_Anios_conoc  = @E_Jav02_cit_5    INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 6   SET @T1_Anios_conoc  = @E_Jav02_cit_6    INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)


		 -- Se inicializan variables
         SET @P_certificaciones  = @E_Jav02_certificaciones_lng
    	 SET @posIni = 1

		 -- Ciclo para buscar "palabras" en cadena de texto(@E_Cob01_certificaciones_lng) separadas por comas
         WHILE LEN(@P_certificaciones) > 0
         BEGIN
           SET @posFin = (SELECT CHARINDEX(',', @P_certificaciones, @posIni)) - 1
           PRINT '@posFin: ' + cast (@posFin as varchar(5))
           PRINT 'LEN(@P_certificaciones): ' + cast ( (LEN(@P_certificaciones)) as varchar(5))

		   IF @posFin <= 0
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM( (SELECT SUBSTRING (@P_certificaciones,@posIni,LEN(@P_certificaciones)) )	))
              PRINT '-----------UPDATE 2-----------: ' + @certificX
              SET @P_certificaciones = ''	

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

               -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
               IF @T1_Id_conoc_it is not null
 			    BEGIN
    		      -- UPDATE EN TABLA: Conocimientos_cand
                  UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	   WHERE Id_candidato = @T1_Id_candidato   
				     AND Id_puesto    = @T1_Id_puesto
					 AND Id_conoc_it  = @T1_Id_conoc_it
   
                  PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
                END              
            END
		   ELSE
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM ((SELECT SUBSTRING (@P_certificaciones,@posIni,@posFin) )))

              PRINT '-----------UPDATE 1-----------: ' + @certificX

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

              -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
              IF @T1_Id_conoc_it is not null
			   BEGIN
    		     -- UPDATE EN TABLA: Conocimientos_cand
                 UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	  WHERE Id_candidato = @T1_Id_candidato
				    AND Id_puesto    = @T1_Id_puesto
				 AND Id_conoc_it  = @T1_Id_conoc_it
   
                 PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
               END
    
			  SET @longNueva =LEN(@P_certificaciones) - (@posFin + 1)
      		  SET @P_certificaciones = (SELECT SUBSTRING (@P_certificaciones,@posFin + 2,@longNueva) )

              PRINT '@posFin: ' + cast (@posFin as varchar(5))
              PRINT '@longNueva: ' + cast (@longNueva as varchar(5))
              PRINT '@P_certificaciones: ' + cast (@P_certificaciones as varchar(100))
              PRINT '@P_certificaciones: ' + cast ((LEN(@P_certificaciones)) as varchar(100))

            END		 
         END

		 -- Se inicializan variables
         SET @P_certificaciones  = @E_Jav02_certificaciones_tem
    	 SET @posIni = 1

		 -- Ciclo para buscar "palabras" en cadena de texto(@E_Cob01_certificaciones_tem) separadas por comas
         WHILE LEN(@P_certificaciones) > 0
         BEGIN
           SET @posFin = (SELECT CHARINDEX(',', @P_certificaciones, @posIni)) - 1
           PRINT '@posFin: ' + cast (@posFin as varchar(5))
           PRINT 'LEN(@P_certificaciones): ' + cast ( (LEN(@P_certificaciones)) as varchar(5))

		   IF @posFin <= 0
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM( (SELECT SUBSTRING (@P_certificaciones,@posIni,LEN(@P_certificaciones)) )	))
              PRINT '-----------UPDATE 2-----------: ' + @certificX
              SET @P_certificaciones = ''	

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

               -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
               IF @T1_Id_conoc_it is not null
 			    BEGIN
    		      -- UPDATE EN TABLA: Conocimientos_cand
                  UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	   WHERE Id_candidato = @T1_Id_candidato   
				     AND Id_puesto    = @T1_Id_puesto
					 AND Id_conoc_it  = @T1_Id_conoc_it
   
                  PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
                END              
            END
		   ELSE
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM ((SELECT SUBSTRING (@P_certificaciones,@posIni,@posFin) )))

              PRINT '-----------UPDATE 1-----------: ' + @certificX

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

              -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
              IF @T1_Id_conoc_it is not null
			   BEGIN
    		     -- UPDATE EN TABLA: Conocimientos_cand
                 UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	  WHERE Id_candidato = @T1_Id_candidato
				    AND Id_puesto    = @T1_Id_puesto
				 AND Id_conoc_it  = @T1_Id_conoc_it
   
                 PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
               END
    
			  SET @longNueva =LEN(@P_certificaciones) - (@posFin + 1)
      		  SET @P_certificaciones = (SELECT SUBSTRING (@P_certificaciones,@posFin + 2,@longNueva) )

              PRINT '@posFin: ' + cast (@posFin as varchar(5))
              PRINT '@longNueva: ' + cast (@longNueva as varchar(5))
              PRINT '@P_certificaciones: ' + cast (@P_certificaciones as varchar(100))
              PRINT '@P_certificaciones: ' + cast ((LEN(@P_certificaciones)) as varchar(100))

            END		 
         END


      END

	-- ===== PUESTO: Líder de Proyecto Java
	IF @E_Vacante = 'Líder de Proyecto Java'
	  BEGIN
         SET @T1_Id_puesto      = 'JAV03'
         SET @T2_Id_puesto      = 'JAV03'
		 SET @T2_Ind_puesto_act = substring(@E_Jav03_puesto_actual,1,1)
		 SET @T2_Sueldo         =
	      (CASE @E_Jav03_sueldo_pretendido
		    WHEN 'Prefiero no especificar'          THEN     00.00
		    WHEN 'Menos de 5,000 pesos'             THEN   5000.00
		    WHEN 'Entre 5,001 y 10,000 mil pesos'   THEN  10000.00
		    WHEN 'Entre 10,001 y 15,000 mil pesos'  THEN  15000.00
		    WHEN 'Entre 15,001 y 20,000 mil pesos'  THEN  20000.00
		    WHEN 'Entre 20,001 y 25,000 mil pesos'  THEN  25000.00
		    WHEN 'Entre 25,001 y 30,000 mil pesos'  THEN  30000.00
		    WHEN 'Entre 30,001 y 35,000 mil pesos'  THEN  35000.00
		    WHEN 'Entre 35,001 y 40,000 mil pesos'  THEN  40000.00
		    WHEN 'Entre 40,001 y 45,000 mil pesos'  THEN  45000.00
		    WHEN 'Entre 45,001 y 50,000 mil pesos'  THEN  50000.00
		    WHEN 'Entre 50,001 y 55,000 mil pesos'  THEN  55000.00
		    WHEN 'Entre 55,001 y 60,000 mil pesos'  THEN  60000.00
		    WHEN 'Entre 60,001 y 65,000 mil pesos'  THEN  65000.00
		    WHEN 'Entre 65,001 y 70,000 mil pesos'  THEN  70000.00
		    WHEN 'Entre 70,001 y 75,000 mil pesos'  THEN  75000.00
		    WHEN 'Entre 75,001 y 80,000 mil pesos'  THEN  80000.00
		    WHEN 'Entre 80,001 y 85,000 mil pesos'  THEN  85000.00
		    WHEN 'Entre 85,001 y 90,000 mil pesos'  THEN  90000.00
		    WHEN 'Entre 90,001 y 95,000 mil pesos'  THEN  95000.00
		    WHEN 'Entre 95,001 y 100,000 mil pesos' THEN 100000.00
		    WHEN 'Más de 100,000 mil pesos'         THEN 100001.00
			ELSE 999999.00
	      END
	      )

         -- INSERTA EN TABLA: Puestos_TI_cand
		 INSERT INTO [dbo].[Puestos_TI_cand] (Id_candidato, Id_puesto, Ind_puesto_act, Sueldo) VALUES (@T2_Id_candidato, @T2_Id_puesto, @T2_Ind_puesto_act, @T2_Sueldo)

         -- INSERTA EN TABLA: Conocimientos_cand
         SET @T1_Id_conoc_it  = 17  SET @T1_Anios_conoc  = @E_Jav03_cit_17   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 18  SET @T1_Anios_conoc  = @E_Jav03_cit_18   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 19  SET @T1_Anios_conoc  = @E_Jav03_cit_19   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 20  SET @T1_Anios_conoc  = @E_Jav03_cit_20   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 21  SET @T1_Anios_conoc  = @E_Jav03_cit_21   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 22  SET @T1_Anios_conoc  = @E_Jav03_cit_22   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 23  SET @T1_Anios_conoc  = @E_Jav03_cit_23   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 24  SET @T1_Anios_conoc  = @E_Jav03_cit_24   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 25  SET @T1_Anios_conoc  = @E_Jav03_cit_25   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 26  SET @T1_Anios_conoc  = @E_Jav03_cit_26   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 27  SET @T1_Anios_conoc  = @E_Jav03_cit_27   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 28  SET @T1_Anios_conoc  = @E_Jav03_cit_28   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 29  SET @T1_Anios_conoc  = @E_Jav03_cit_29   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)

         SET @T1_Id_conoc_it  = 30  SET @T1_Anios_conoc  = @E_Jav03_cit_30   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 31  SET @T1_Anios_conoc  = @E_Jav03_cit_31   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 32  SET @T1_Anios_conoc  = @E_Jav03_cit_32   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 33  SET @T1_Anios_conoc  = @E_Jav03_cit_33   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 16  SET @T1_Anios_conoc  = @E_Jav03_cit_16   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)

         SET @T1_Id_conoc_it  = 1   SET @T1_Anios_conoc  = @E_Jav03_cit_1    INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 2   SET @T1_Anios_conoc  = @E_Jav03_cit_2    INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 3   SET @T1_Anios_conoc  = @E_Jav03_cit_3    INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 4   SET @T1_Anios_conoc  = @E_Jav03_cit_4    INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 5   SET @T1_Anios_conoc  = @E_Jav03_cit_5    INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 6   SET @T1_Anios_conoc  = @E_Jav03_cit_6    INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)


		 -- Se inicializan variables
         SET @P_certificaciones  = @E_Jav03_certificaciones_lng
    	 SET @posIni = 1

		 -- Ciclo para buscar "palabras" en cadena de texto(@E_Cob01_certificaciones_lng) separadas por comas
         WHILE LEN(@P_certificaciones) > 0
         BEGIN
           SET @posFin = (SELECT CHARINDEX(',', @P_certificaciones, @posIni)) - 1
           PRINT '@posFin: ' + cast (@posFin as varchar(5))
           PRINT 'LEN(@P_certificaciones): ' + cast ( (LEN(@P_certificaciones)) as varchar(5))

		   IF @posFin <= 0
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM( (SELECT SUBSTRING (@P_certificaciones,@posIni,LEN(@P_certificaciones)) )	))
              PRINT '-----------UPDATE 2-----------: ' + @certificX
              SET @P_certificaciones = ''	

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

               -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
               IF @T1_Id_conoc_it is not null
 			    BEGIN
    		      -- UPDATE EN TABLA: Conocimientos_cand
                  UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	   WHERE Id_candidato = @T1_Id_candidato   
				     AND Id_puesto    = @T1_Id_puesto
					 AND Id_conoc_it  = @T1_Id_conoc_it
   
                  PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
                END              
            END
		   ELSE
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM ((SELECT SUBSTRING (@P_certificaciones,@posIni,@posFin) )))

              PRINT '-----------UPDATE 1-----------: ' + @certificX

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

              -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
              IF @T1_Id_conoc_it is not null
			   BEGIN
    		     -- UPDATE EN TABLA: Conocimientos_cand
                 UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	  WHERE Id_candidato = @T1_Id_candidato
				    AND Id_puesto    = @T1_Id_puesto
				 AND Id_conoc_it  = @T1_Id_conoc_it
   
                 PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
               END
    
			  SET @longNueva =LEN(@P_certificaciones) - (@posFin + 1)
      		  SET @P_certificaciones = (SELECT SUBSTRING (@P_certificaciones,@posFin + 2,@longNueva) )

              PRINT '@posFin: ' + cast (@posFin as varchar(5))
              PRINT '@longNueva: ' + cast (@longNueva as varchar(5))
              PRINT '@P_certificaciones: ' + cast (@P_certificaciones as varchar(100))
              PRINT '@P_certificaciones: ' + cast ((LEN(@P_certificaciones)) as varchar(100))

            END		 
         END

		 -- Se inicializan variables
         SET @P_certificaciones  = @E_Jav03_certificaciones_tem
    	 SET @posIni = 1

		 -- Ciclo para buscar "palabras" en cadena de texto(@E_Cob01_certificaciones_tem) separadas por comas
         WHILE LEN(@P_certificaciones) > 0
         BEGIN
           SET @posFin = (SELECT CHARINDEX(',', @P_certificaciones, @posIni)) - 1
           PRINT '@posFin: ' + cast (@posFin as varchar(5))
           PRINT 'LEN(@P_certificaciones): ' + cast ( (LEN(@P_certificaciones)) as varchar(5))

		   IF @posFin <= 0
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM( (SELECT SUBSTRING (@P_certificaciones,@posIni,LEN(@P_certificaciones)) )	))
              PRINT '-----------UPDATE 2-----------: ' + @certificX
              SET @P_certificaciones = ''	

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

               -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
               IF @T1_Id_conoc_it is not null
 			    BEGIN
    		      -- UPDATE EN TABLA: Conocimientos_cand
                  UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	   WHERE Id_candidato = @T1_Id_candidato   
				     AND Id_puesto    = @T1_Id_puesto
					 AND Id_conoc_it  = @T1_Id_conoc_it
   
                  PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
                END              
            END
		   ELSE
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM ((SELECT SUBSTRING (@P_certificaciones,@posIni,@posFin) )))

              PRINT '-----------UPDATE 1-----------: ' + @certificX

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

              -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
              IF @T1_Id_conoc_it is not null
			   BEGIN
    		     -- UPDATE EN TABLA: Conocimientos_cand
                 UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	  WHERE Id_candidato = @T1_Id_candidato
				    AND Id_puesto    = @T1_Id_puesto
				 AND Id_conoc_it  = @T1_Id_conoc_it
   
                 PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
               END
    
			  SET @longNueva =LEN(@P_certificaciones) - (@posFin + 1)
      		  SET @P_certificaciones = (SELECT SUBSTRING (@P_certificaciones,@posFin + 2,@longNueva) )

              PRINT '@posFin: ' + cast (@posFin as varchar(5))
              PRINT '@longNueva: ' + cast (@longNueva as varchar(5))
              PRINT '@P_certificaciones: ' + cast (@P_certificaciones as varchar(100))
              PRINT '@P_certificaciones: ' + cast ((LEN(@P_certificaciones)) as varchar(100))

            END		 
         END


      END


	-- ===== PUESTO: Gerente Perfil Java
	IF @E_Vacante = 'Gerente Perfil Java'
	  BEGIN
         SET @T1_Id_puesto      = 'JAV04'
         SET @T2_Id_puesto      = 'JAV04'
		 SET @T2_Ind_puesto_act = substring(@E_Jav04_puesto_actual,1,1)
		 SET @T2_Sueldo         =
	      (CASE @E_Jav04_sueldo_pretendido
		    WHEN 'Prefiero no especificar'          THEN     00.00
		    WHEN 'Menos de 5,000 pesos'             THEN   5000.00
		    WHEN 'Entre 5,001 y 10,000 mil pesos'   THEN  10000.00
		    WHEN 'Entre 10,001 y 15,000 mil pesos'  THEN  15000.00
		    WHEN 'Entre 15,001 y 20,000 mil pesos'  THEN  20000.00
		    WHEN 'Entre 20,001 y 25,000 mil pesos'  THEN  25000.00
		    WHEN 'Entre 25,001 y 30,000 mil pesos'  THEN  30000.00
		    WHEN 'Entre 30,001 y 35,000 mil pesos'  THEN  35000.00
		    WHEN 'Entre 35,001 y 40,000 mil pesos'  THEN  40000.00
		    WHEN 'Entre 40,001 y 45,000 mil pesos'  THEN  45000.00
		    WHEN 'Entre 45,001 y 50,000 mil pesos'  THEN  50000.00
		    WHEN 'Entre 50,001 y 55,000 mil pesos'  THEN  55000.00
		    WHEN 'Entre 55,001 y 60,000 mil pesos'  THEN  60000.00
		    WHEN 'Entre 60,001 y 65,000 mil pesos'  THEN  65000.00
		    WHEN 'Entre 65,001 y 70,000 mil pesos'  THEN  70000.00
		    WHEN 'Entre 70,001 y 75,000 mil pesos'  THEN  75000.00
		    WHEN 'Entre 75,001 y 80,000 mil pesos'  THEN  80000.00
		    WHEN 'Entre 80,001 y 85,000 mil pesos'  THEN  85000.00
		    WHEN 'Entre 85,001 y 90,000 mil pesos'  THEN  90000.00
		    WHEN 'Entre 90,001 y 95,000 mil pesos'  THEN  95000.00
		    WHEN 'Entre 95,001 y 100,000 mil pesos' THEN 100000.00
		    WHEN 'Más de 100,000 mil pesos'         THEN 100001.00
			ELSE 999999.00
	      END
	      )

         -- INSERTA EN TABLA: Puestos_TI_cand
		 INSERT INTO [dbo].[Puestos_TI_cand] (Id_candidato, Id_puesto, Ind_puesto_act, Sueldo) VALUES (@T2_Id_candidato, @T2_Id_puesto, @T2_Ind_puesto_act, @T2_Sueldo)

         -- INSERTA EN TABLA: Conocimientos_cand
         SET @T1_Id_conoc_it  = 17  SET @T1_Anios_conoc  = @E_Jav04_cit_17   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 18  SET @T1_Anios_conoc  = @E_Jav04_cit_18   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 19  SET @T1_Anios_conoc  = @E_Jav04_cit_19   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 20  SET @T1_Anios_conoc  = @E_Jav04_cit_20   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 21  SET @T1_Anios_conoc  = @E_Jav04_cit_21   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 22  SET @T1_Anios_conoc  = @E_Jav04_cit_22   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 23  SET @T1_Anios_conoc  = @E_Jav04_cit_23   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 24  SET @T1_Anios_conoc  = @E_Jav04_cit_24   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 25  SET @T1_Anios_conoc  = @E_Jav04_cit_25   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 26  SET @T1_Anios_conoc  = @E_Jav04_cit_26   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 27  SET @T1_Anios_conoc  = @E_Jav04_cit_27   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 28  SET @T1_Anios_conoc  = @E_Jav04_cit_28   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 29  SET @T1_Anios_conoc  = @E_Jav04_cit_29   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)

         SET @T1_Id_conoc_it  = 30  SET @T1_Anios_conoc  = @E_Jav04_cit_30   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 31  SET @T1_Anios_conoc  = @E_Jav04_cit_31   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 34  SET @T1_Anios_conoc  = @E_Jav04_cit_34   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 35  SET @T1_Anios_conoc  = @E_Jav04_cit_35   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 32  SET @T1_Anios_conoc  = @E_Jav04_cit_32   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 33  SET @T1_Anios_conoc  = @E_Jav04_cit_33   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 16  SET @T1_Anios_conoc  = @E_Jav04_cit_16   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)

         SET @T1_Id_conoc_it  = 1   SET @T1_Anios_conoc  = @E_Jav04_cit_1    INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 2   SET @T1_Anios_conoc  = @E_Jav04_cit_2    INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 3   SET @T1_Anios_conoc  = @E_Jav04_cit_3    INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 4   SET @T1_Anios_conoc  = @E_Jav04_cit_4    INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 5   SET @T1_Anios_conoc  = @E_Jav04_cit_5    INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 6   SET @T1_Anios_conoc  = @E_Jav04_cit_6    INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)


		 -- Se inicializan variables
         SET @P_certificaciones  = @E_Jav04_certificaciones_lng
    	 SET @posIni = 1

		 -- Ciclo para buscar "palabras" en cadena de texto(@E_Cob01_certificaciones_lng) separadas por comas
         WHILE LEN(@P_certificaciones) > 0
         BEGIN
           SET @posFin = (SELECT CHARINDEX(',', @P_certificaciones, @posIni)) - 1
           PRINT '@posFin: ' + cast (@posFin as varchar(5))
           PRINT 'LEN(@P_certificaciones): ' + cast ( (LEN(@P_certificaciones)) as varchar(5))

		   IF @posFin <= 0
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM( (SELECT SUBSTRING (@P_certificaciones,@posIni,LEN(@P_certificaciones)) )	))
              PRINT '-----------UPDATE 2-----------: ' + @certificX
              SET @P_certificaciones = ''	

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

               -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
               IF @T1_Id_conoc_it is not null
 			    BEGIN
    		      -- UPDATE EN TABLA: Conocimientos_cand
                  UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	   WHERE Id_candidato = @T1_Id_candidato   
				     AND Id_puesto    = @T1_Id_puesto
					 AND Id_conoc_it  = @T1_Id_conoc_it
   
                  PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
                END              
            END
		   ELSE
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM ((SELECT SUBSTRING (@P_certificaciones,@posIni,@posFin) )))

              PRINT '-----------UPDATE 1-----------: ' + @certificX

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

              -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
              IF @T1_Id_conoc_it is not null
			   BEGIN
    		     -- UPDATE EN TABLA: Conocimientos_cand
                 UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	  WHERE Id_candidato = @T1_Id_candidato
				    AND Id_puesto    = @T1_Id_puesto
				 AND Id_conoc_it  = @T1_Id_conoc_it
   
                 PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
               END
    
			  SET @longNueva =LEN(@P_certificaciones) - (@posFin + 1)
      		  SET @P_certificaciones = (SELECT SUBSTRING (@P_certificaciones,@posFin + 2,@longNueva) )

              PRINT '@posFin: ' + cast (@posFin as varchar(5))
              PRINT '@longNueva: ' + cast (@longNueva as varchar(5))
              PRINT '@P_certificaciones: ' + cast (@P_certificaciones as varchar(100))
              PRINT '@P_certificaciones: ' + cast ((LEN(@P_certificaciones)) as varchar(100))

            END		 
         END

		 -- Se inicializan variables
         SET @P_certificaciones  = @E_Jav04_certificaciones_tem
    	 SET @posIni = 1

		 -- Ciclo para buscar "palabras" en cadena de texto(@E_Cob01_certificaciones_tem) separadas por comas
         WHILE LEN(@P_certificaciones) > 0
         BEGIN
           SET @posFin = (SELECT CHARINDEX(',', @P_certificaciones, @posIni)) - 1
           PRINT '@posFin: ' + cast (@posFin as varchar(5))
           PRINT 'LEN(@P_certificaciones): ' + cast ( (LEN(@P_certificaciones)) as varchar(5))

		   IF @posFin <= 0
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM( (SELECT SUBSTRING (@P_certificaciones,@posIni,LEN(@P_certificaciones)) )	))
              PRINT '-----------UPDATE 2-----------: ' + @certificX
              SET @P_certificaciones = ''	

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

               -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
               IF @T1_Id_conoc_it is not null
 			    BEGIN
    		      -- UPDATE EN TABLA: Conocimientos_cand
                  UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	   WHERE Id_candidato = @T1_Id_candidato   
				     AND Id_puesto    = @T1_Id_puesto
					 AND Id_conoc_it  = @T1_Id_conoc_it
   
                  PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
                END              
            END
		   ELSE
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM ((SELECT SUBSTRING (@P_certificaciones,@posIni,@posFin) )))

              PRINT '-----------UPDATE 1-----------: ' + @certificX

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

              -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
              IF @T1_Id_conoc_it is not null
			   BEGIN
    		     -- UPDATE EN TABLA: Conocimientos_cand
                 UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	  WHERE Id_candidato = @T1_Id_candidato
				    AND Id_puesto    = @T1_Id_puesto
				 AND Id_conoc_it  = @T1_Id_conoc_it
   
                 PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
               END
    
			  SET @longNueva =LEN(@P_certificaciones) - (@posFin + 1)
      		  SET @P_certificaciones = (SELECT SUBSTRING (@P_certificaciones,@posFin + 2,@longNueva) )

              PRINT '@posFin: ' + cast (@posFin as varchar(5))
              PRINT '@longNueva: ' + cast (@longNueva as varchar(5))
              PRINT '@P_certificaciones: ' + cast (@P_certificaciones as varchar(100))
              PRINT '@P_certificaciones: ' + cast ((LEN(@P_certificaciones)) as varchar(100))

            END		 
         END


      END


	-- ===== PUESTO: Administrador de Base de Datos Oracle
	IF @E_Vacante = 'Administrador de Base de Datos Oracle'
	  BEGIN
         SET @T1_Id_puesto      = 'ORA01'
         SET @T2_Id_puesto      = 'ORA01'
		 SET @T2_Ind_puesto_act = substring(@E_Ora01_puesto_actual,1,1)
		 SET @T2_Sueldo         =
	      (CASE @E_Ora01_sueldo_pretendido
		    WHEN 'Prefiero no especificar'          THEN     00.00
		    WHEN 'Menos de 5,000 pesos'             THEN   5000.00
		    WHEN 'Entre 5,001 y 10,000 mil pesos'   THEN  10000.00
		    WHEN 'Entre 10,001 y 15,000 mil pesos'  THEN  15000.00
		    WHEN 'Entre 15,001 y 20,000 mil pesos'  THEN  20000.00
		    WHEN 'Entre 20,001 y 25,000 mil pesos'  THEN  25000.00
		    WHEN 'Entre 25,001 y 30,000 mil pesos'  THEN  30000.00
		    WHEN 'Entre 30,001 y 35,000 mil pesos'  THEN  35000.00
		    WHEN 'Entre 35,001 y 40,000 mil pesos'  THEN  40000.00
		    WHEN 'Entre 40,001 y 45,000 mil pesos'  THEN  45000.00
		    WHEN 'Entre 45,001 y 50,000 mil pesos'  THEN  50000.00
		    WHEN 'Entre 50,001 y 55,000 mil pesos'  THEN  55000.00
		    WHEN 'Entre 55,001 y 60,000 mil pesos'  THEN  60000.00
		    WHEN 'Entre 60,001 y 65,000 mil pesos'  THEN  65000.00
		    WHEN 'Entre 65,001 y 70,000 mil pesos'  THEN  70000.00
		    WHEN 'Entre 70,001 y 75,000 mil pesos'  THEN  75000.00
		    WHEN 'Entre 75,001 y 80,000 mil pesos'  THEN  80000.00
		    WHEN 'Entre 80,001 y 85,000 mil pesos'  THEN  85000.00
		    WHEN 'Entre 85,001 y 90,000 mil pesos'  THEN  90000.00
		    WHEN 'Entre 90,001 y 95,000 mil pesos'  THEN  95000.00
		    WHEN 'Entre 95,001 y 100,000 mil pesos' THEN 100000.00
		    WHEN 'Más de 100,000 mil pesos'         THEN 100001.00
			ELSE 999999.00
	      END
	      )

         -- INSERTA EN TABLA: Puestos_TI_cand
		 INSERT INTO [dbo].[Puestos_TI_cand] (Id_candidato, Id_puesto, Ind_puesto_act, Sueldo) VALUES (@T2_Id_candidato, @T2_Id_puesto, @T2_Ind_puesto_act, @T2_Sueldo)

         -- INSERTA EN TABLA: Conocimientos_cand
         SET @T1_Id_conoc_it  = 36  SET @T1_Anios_conoc  = @E_Ora01_cit_36   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 37  SET @T1_Anios_conoc  = @E_Ora01_cit_37   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 38  SET @T1_Anios_conoc  = @E_Ora01_cit_38   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 39  SET @T1_Anios_conoc  = @E_Ora01_cit_39   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 40  SET @T1_Anios_conoc  = @E_Ora01_cit_40   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 41  SET @T1_Anios_conoc  = @E_Ora01_cit_41   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 42  SET @T1_Anios_conoc  = @E_Ora01_cit_42   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)

         SET @T1_Id_conoc_it  = 30  SET @T1_Anios_conoc  = @E_Ora01_cit_30   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 31  SET @T1_Anios_conoc  = @E_Ora01_cit_31   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 43  SET @T1_Anios_conoc  = @E_Ora01_cit_43   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 44  SET @T1_Anios_conoc  = @E_Ora01_cit_44   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 45  SET @T1_Anios_conoc  = @E_Ora01_cit_45   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 46  SET @T1_Anios_conoc  = @E_Ora01_cit_46   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)
         SET @T1_Id_conoc_it  = 47  SET @T1_Anios_conoc  = @E_Ora01_cit_47   INSERT INTO [dbo].[Conocimientos_cand] (Id_candidato, Id_puesto, Id_conoc_it, Anios_conoc, Ind_certificacion) VALUES (@T1_Id_candidato, @T1_Id_puesto, @T1_Id_conoc_it, @T1_Anios_conoc, @T1_Ind_certificacion)


		 -- Se inicializan variables
         SET @P_certificaciones  = @E_Ora01_certificaciones_lng
    	 SET @posIni = 1

		 -- Ciclo para buscar "palabras" en cadena de texto(@E_Cob01_certificaciones_lng) separadas por comas
         WHILE LEN(@P_certificaciones) > 0
         BEGIN
           SET @posFin = (SELECT CHARINDEX(',', @P_certificaciones, @posIni)) - 1
           PRINT '@posFin: ' + cast (@posFin as varchar(5))
           PRINT 'LEN(@P_certificaciones): ' + cast ( (LEN(@P_certificaciones)) as varchar(5))

		   IF @posFin <= 0
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM( (SELECT SUBSTRING (@P_certificaciones,@posIni,LEN(@P_certificaciones)) )	))
              PRINT '-----------UPDATE 2-----------: ' + @certificX
              SET @P_certificaciones = ''	

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

               -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
               IF @T1_Id_conoc_it is not null
 			    BEGIN
    		      -- UPDATE EN TABLA: Conocimientos_cand
                  UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	   WHERE Id_candidato = @T1_Id_candidato   
				     AND Id_puesto    = @T1_Id_puesto
					 AND Id_conoc_it  = @T1_Id_conoc_it
   
                  PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
                END              
            END
		   ELSE
		    BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @certificX = (SELECT LTRIM ((SELECT SUBSTRING (@P_certificaciones,@posIni,@posFin) )))

              PRINT '-----------UPDATE 1-----------: ' + @certificX

             -- Se obtiene el Id del conocimeinto de IT
              SET @T1_Id_conoc_it =
              ( SELECT Id_conoc_it FROM [dbo].[Codigos_conocimientos_TI]
                    WHERE Descrip_conoc_it = @certificX)

              PRINT '@certificX        : ' + cast (@certificX as varchar(100))
              PRINT '@T1_Id_conoc_it   : ' + cast (@T1_Id_conoc_it as varchar(5))

              -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
              IF @T1_Id_conoc_it is not null
			   BEGIN
    		     -- UPDATE EN TABLA: Conocimientos_cand
                 UPDATE  [dbo].[Conocimientos_cand] SET Ind_certificacion = 'S'
		    	  WHERE Id_candidato = @T1_Id_candidato
				    AND Id_puesto    = @T1_Id_puesto
				 AND Id_conoc_it  = @T1_Id_conoc_it
   
                 PRINT '@T1_Id_conoc_it (UP) : ' + cast (@T1_Id_conoc_it as varchar(5))
               END
    
			  SET @longNueva =LEN(@P_certificaciones) - (@posFin + 1)
      		  SET @P_certificaciones = (SELECT SUBSTRING (@P_certificaciones,@posFin + 2,@longNueva) )

              PRINT '@posFin: ' + cast (@posFin as varchar(5))
              PRINT '@longNueva: ' + cast (@longNueva as varchar(5))
              PRINT '@P_certificaciones: ' + cast (@P_certificaciones as varchar(100))
              PRINT '@P_certificaciones: ' + cast ((LEN(@P_certificaciones)) as varchar(100))

            END		 
         END
      END





   -- LECTURA DEL CURSOR Encuesta_general_cursor (SIGUIENTE REGISTRO)
  FETCH NEXT FROM Encuesta_puestos_cursor
  INTO
	@E_Id_candidato,
	@E_Vacante, 

	@E_Cob01_puesto_actual, 
	@E_Cob01_cit_7, 
	@E_Cob01_cit_8, 
	@E_Cob01_cit_9, 
	@E_Cob01_cit_10, 
	@E_Cob01_cit_11, 
	@E_Cob01_cit_12, 
	@E_Cob01_cit_13, 
	@E_Cob01_certificaciones_lng, 
	@E_Cob01_sueldo_pretendido, 
	
	@E_Cob02_puesto_actual, 
	@E_Cob02_cit_7, 
	@E_Cob02_cit_8, 
	@E_Cob02_cit_9,
    @E_Cob02_cit_10,  
	@E_Cob02_cit_11, 
	@E_Cob02_cit_12, 
	@E_Cob02_cit_13, 
	@E_Cob02_cit_14, 
	@E_Cob02_cit_15, 
	@E_Cob02_certificaciones_lng, 
	@E_Cob02_cit_16,
	@E_Cob02_certificaciones_tem, 
	@E_Cob02_cit_1, 
	@E_Cob02_cit_2, 
	@E_Cob02_cit_3, 
	@E_Cob02_cit_4, 
	@E_Cob02_cit_5, 
	@E_Cob02_cit_6, 
	@E_Cob02_sueldo_pretendido, 
	
	@E_Jav01_puesto_actual, 
	@E_Jav01_cit_17, 
	@E_Jav01_cit_18, 
	@E_Jav01_cit_19, 
	@E_Jav01_cit_20, 
	@E_Jav01_cit_21, 
    @E_Jav01_cit_22,
	@E_Jav01_cit_23, 
	@E_Jav01_cit_24, 
	@E_Jav01_cit_25, 
	@E_Jav01_cit_26, 
	@E_Jav01_cit_27, 
	@E_Jav01_cit_28, 
	@E_Jav01_cit_29, 
    @E_Jav01_certificaciones_lng,
	@E_Jav01_sueldo_pretendido, 
	
	@E_Jav02_puesto_actual, 
	@E_Jav02_cit_17, 
	@E_Jav02_cit_18, 
	@E_Jav02_cit_19, 
	@E_Jav02_cit_20, 
	@E_Jav02_cit_21, 
	@E_Jav02_cit_22, 
	@E_Jav02_cit_23, 
	@E_Jav02_cit_24, 
	@E_Jav02_cit_25, 
	@E_Jav02_cit_26, 
	@E_Jav02_cit_27, 
	@E_Jav02_cit_28, 
	@E_Jav02_cit_29, 
	@E_Jav02_certificaciones_lng, 
	@E_Jav02_cit_16, 
	@E_Jav02_certificaciones_tem, 
	@E_Jav02_cit_1, 
	@E_Jav02_cit_2, 
	@E_Jav02_cit_3, 
	@E_Jav02_cit_4, 
	@E_Jav02_cit_5, 
	@E_Jav02_cit_6, 
	@E_Jav02_sueldo_pretendido, 
	
	@E_Cob03_puesto_actual, 
	@E_Cob03_cit_7, 
	@E_Cob03_cit_8, 
	@E_Cob03_cit_9, 
	@E_Cob03_cit_10, 
	@E_Cob03_cit_11, 
	@E_Cob03_cit_12, 
	@E_Cob03_cit_13, 
	@E_Cob03_cit_14, 
	@E_Cob03_cit_15, 
	@E_Cob03_certificaciones_lng, 
	@E_Cob03_cit_30, 
	@E_Cob03_cit_31, 
	@E_Cob03_cit_32, 
	@E_Cob03_cit_33, 
	@E_Cob03_cit_16, 
	@E_Cob03_certificaciones_tem, 
	@E_Cob03_cit_1, 
	@E_Cob03_cit_2, 
	@E_Cob03_cit_3, 
	@E_Cob03_cit_4, 
	@E_Cob03_cit_5, 
	@E_Cob03_cit_6, 
	@E_Cob03_sueldo_pretendido, 
	
	@E_Jav03_puesto_actual, 
	@E_Jav03_cit_17, 
	@E_Jav03_cit_18, 
	@E_Jav03_cit_19, 
	@E_Jav03_cit_20, 
	@E_Jav03_cit_21, 
	@E_Jav03_cit_22, 
	@E_Jav03_cit_23, 
	@E_Jav03_cit_24, 
	@E_Jav03_cit_25, 
	@E_Jav03_cit_26, 
	@E_Jav03_cit_27, 
	@E_Jav03_cit_28, 
	@E_Jav03_cit_29, 
	@E_Jav03_certificaciones_lng, 
	@E_Jav03_cit_30, 
	@E_Jav03_cit_31, 
	@E_Jav03_cit_32, 
	@E_Jav03_cit_33, 
	@E_Jav03_cit_16, 
	@E_Jav03_certificaciones_tem, 
	@E_Jav03_cit_1, 
	@E_Jav03_cit_2, 
	@E_Jav03_cit_3, 
	@E_Jav03_cit_4, 
	@E_Jav03_cit_5, 
	@E_Jav03_cit_6, 
	@E_Jav03_sueldo_pretendido, 
	
	@E_Cob04_puesto_actual, 
	@E_Cob04_cit_7, 
	@E_Cob04_cit_8, 
	@E_Cob04_cit_9, 
	@E_Cob04_cit_10, 
	@E_Cob04_cit_11, 
	@E_Cob04_cit_14, 
	@E_Cob04_cit_15, 
	@E_Cob04_certificaciones_lng, 
	@E_Cob04_cit_30, 
	@E_Cob04_cit_31, 
	@E_Cob04_cit_34, 
	@E_Cob04_cit_35, 
	@E_Cob04_cit_32, 
	@E_Cob04_cit_33, 
	@E_Cob04_cit_16, 
	@E_Cob04_certificaciones_tem, 
	@E_Cob04_cit_1, 
	@E_Cob04_cit_2, 
	@E_Cob04_cit_3, 
	@E_Cob04_cit_4, 
	@E_Cob04_cit_5, 
	@E_Cob04_cit_6, 
	@E_Cob04_sueldo_pretendido, 
	
	@E_Jav04_puesto_actual, 
	@E_Jav04_cit_17, 
	@E_Jav04_cit_18, 
	@E_Jav04_cit_19, 
	@E_Jav04_cit_20, 
	@E_Jav04_cit_21, 
	@E_Jav04_cit_22, 
	@E_Jav04_cit_23, 
	@E_Jav04_cit_24, 
	@E_Jav04_cit_25, 
	@E_Jav04_cit_26, 
	@E_Jav04_cit_27, 
	@E_Jav04_cit_28, 
	@E_Jav04_cit_29, 
	@E_Jav04_certificaciones_lng, 
	@E_Jav04_cit_30, 
	@E_Jav04_cit_31, 
	@E_Jav04_cit_34, 
	@E_Jav04_cit_35, 
	@E_Jav04_cit_32, 
	@E_Jav04_cit_33, 
	@E_Jav04_cit_16, 
	@E_Jav04_certificaciones_tem, 
	@E_Jav04_cit_1, 
	@E_Jav04_cit_2, 
	@E_Jav04_cit_3, 
	@E_Jav04_cit_4, 
	@E_Jav04_cit_5, 
	@E_Jav04_cit_6, 
	@E_Jav04_sueldo_pretendido, 
	
	@E_Ora01_puesto_actual, 
	@E_Ora01_cit_36, 
	@E_Ora01_cit_37, 
	@E_Ora01_cit_38, 
	@E_Ora01_cit_39, 
	@E_Ora01_cit_40, 
	@E_Ora01_cit_41, 
	@E_Ora01_cit_42, 
	@E_Ora01_certificaciones_lng, 
	@E_Ora01_cit_30, 
	@E_Ora01_cit_31, 
	@E_Ora01_cit_43, 
	@E_Ora01_cit_44, 
	@E_Ora01_cit_45, 
	@E_Ora01_cit_46, 
	@E_Ora01_cit_47, 
	@E_Ora01_sueldo_pretendido


END  


-- CIERRA CURSOR 
CLOSE Encuesta_puestos_cursor;  
DEALLOCATE Encuesta_puestos_cursor;  
GO  




