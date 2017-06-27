/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tesis_rhti;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;

/**
 *
 * @author CD
 */
public class ConsultaFecha 
{
    // ----- Consulta para recuperar la descripción de la tabla: Codigos_conocimientos_TI
 public  Date consultarFechaActual()
 {    
     java.util.Date utilDate = new java.util.Date();
     java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

     System.out.println("java.util.Date: " + utilDate);
     System.out.println("java.sql.Date.: " + sqlDate);
        
     return sqlDate;
      
  }
 }
