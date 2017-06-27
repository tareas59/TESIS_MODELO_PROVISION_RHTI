/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tesis_rhti;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;

/**
 *
 * @author CD
 */
public class Consulta 
{

    public static void main(String[] args) throws SQLException 
    {
   
     Conexion c = new Conexion();
     Connection con = c.getConexion();

        if(con != null)
       {       
          System.out.println("SQL OK  :  " );

       ResultSet rs;
       
       try (Statement st = con.createStatement()) 
       {
           rs = st.executeQuery("SELECT * FROM Candidatos " );
   
           while(rs.next())
           {
            System.out.println("ID_CANDIDATO " + rs.getString(1) );
            System.out.println("NOMBRE " + rs.getString(2) );           
                                          
           }   
       }
          
       }
        else
       {       
          System.out.println("SQL ERROR :  " );

       }

    Calendar fecha = new GregorianCalendar();
        //Obtenemos el valor del año, mes, día, hora, minuto y segundo del sistema.
        //Usando el método get y el parámetro correspondiente.
        int anio = fecha.get(Calendar.YEAR);
        int mes = fecha.get(Calendar.MONTH) ;
        int dia = fecha.get(Calendar.DAY_OF_MONTH);
  
        String fecha2 = String.valueOf(anio) +"-"+ mes +"-"+ dia;
                
        System.out.println("ano" + anio );
        System.out.println("mes" + mes );
        System.out.println("dia" + dia );
        System.out.println("fecha" + fecha2 );

        ConsultaFecha cons = new ConsultaFecha();
        cons.consultarFechaActual();
        

      MedidasDistancia.obtieneMedidaDistancia(1, "0000000004");

      
//     ConsultasDescripciones cons = new ConsultasDescripciones ();
//     String descr = cons.consultarDescripCodigoConoc(1);
//     System.out.println("Descripciòn" + descr);

//    System.out.println("Error del MySQL, SQLSTATE: " + e.getSQLState());
//--   System.out.println("SQL ERROR  :  " + e.getErrorCode());
//    System.out.println("SQL MESSAGE:  " + e.getMessage());
  
    }
    
   
    
}
