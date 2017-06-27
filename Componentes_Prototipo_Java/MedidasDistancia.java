/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tesis_rhti;

//import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

/**
 *
 * @author CD
 */
public class MedidasDistancia 
{
    
 public static int[][] obtieneMedidaDistancia(int idPerfilIdoneo, String idCandidato)
 {


     int arregloPerfiles[][] = new int[100][2];
     int filas = 0;

     Conexion c = new Conexion();
     Connection con = c.getConexion();

     String sql_1 = "SELECT A.Id_tipo_carac_perfil , B.Id_tipo_carac_perfil, "
                         + "A.Id_carac_perfil      , B.Id_carac_perfil, "
                         + "A.Valor_binario_perfil , B.Valor_binario_perfil "
                   + "FROM Perfiles_idoneos_detalle A "
                   + "INNER JOIN  Perfiles_candidatos_detalle B"
                   + " ON A.Id_perfil_idoneo     = B.Id_perfil_idoneo"
                   + " AND A.Id_tipo_carac_perfil = B.Id_tipo_carac_perfil" 
                   + " AND A.Id_carac_perfil      = B.Id_carac_perfil" 
                   + " AND A.Id_perfil_idoneo     = " + idPerfilIdoneo  
                   + " AND B.Id_candidato         = '" + idCandidato + "'"
                   + " ORDER BY A.Id_perfil_idoneo,A.Id_tipo_carac_perfil,A.Id_carac_perfil" ;

     

     try {            
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_1);

             
         while(rs.next())
         {        
          System.out.println("rs.getInt(5)" + String.valueOf(rs.getInt(5) ));
          System.out.println("rs.getInt(6)" + String.valueOf(rs.getInt(6) ));
             
          arregloPerfiles[filas][0]= rs.getInt(5);
          arregloPerfiles[filas][1]= rs.getInt(6);
          
          filas ++;
         }   

         System.out.println("filas" + String.valueOf(filas ));
       
        rs.close();
        c.cerrarConexion();
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }
     
     
      imprimirArreglo(arregloPerfiles);

      double distHamming = calculaDistanciaHamming(arregloPerfiles, filas);
      System.out.println("Distancia de Hamming :" + String.valueOf(distHamming));

      double distEuclidiana = calculaDistanciaEuclidiana(arregloPerfiles, filas);
      System.out.println("Distancia de Euclidiana :" + String.valueOf(distEuclidiana));
      
      double distRusselRao = calculaDistanciaRusselRao(arregloPerfiles, filas);
      System.out.println("Distancia de RusselRao :" + String.valueOf(distRusselRao));

      double distJaccard = calculaDistanciaJaccard(arregloPerfiles, filas);
      System.out.println("Distancia de Jaccard :" + String.valueOf(distJaccard));

      actualizaCalif(idCandidato, idPerfilIdoneo, distHamming, distEuclidiana, distRusselRao, distJaccard );    
      
     return arregloPerfiles;
             
 }
 

public static Double calculaDistanciaHamming( int arregloPerfiles[][], int numFilas )
 {

   double distanciaHamming = 0;
           
   for ( int fila = 0; fila < numFilas; fila++ )
   {
    if (arregloPerfiles[fila][0] == arregloPerfiles[fila][1])
     {
       distanciaHamming++;
     }
   }

   // Se transforma el valor al rango de  0 a 1
   distanciaHamming   =  (distanciaHamming * 1) / (numFilas);
           
   return distanciaHamming;
 } 

public static Double calculaDistanciaEuclidiana( int arregloPerfiles[][], int numFilas )
 {

   Double distanciaEuclidiana = 0.00;
   Double  puntoX = 0.00;
           
   for ( int fila = 0; fila < numFilas; fila++ )
   {
       
       puntoX = puntoX + Math.pow(arregloPerfiles[fila][0] - arregloPerfiles[fila][1], 2);             
        
   }
   
   distanciaEuclidiana = Math.sqrt(puntoX);
           
   
   return distanciaEuclidiana;
 } 


public static Double calculaDistanciaJaccard( int arregloPerfiles[][], int numFilas )
 {

   Double distanciaJaccard = 0.00;
   
   Double A = 0.00;
   Double B = 0.00;
   Double C = 0.00;
   Double a = 0.00;
   Double b = 0.00;
   Double c = 0.00;

   int n = 0;
   
   
   for ( int fila = 0; fila < numFilas; fila++ )
   {
       
       if((arregloPerfiles[fila][0] == 1) && (arregloPerfiles[fila][1] == 1))             
      { 
        A++;
      } 
       if((arregloPerfiles[fila][0] == 1) && (arregloPerfiles[fila][1] == 0))             
      { 
        B++;
      } 
       if((arregloPerfiles[fila][0] == 0) && (arregloPerfiles[fila][1] == 1))             
      { 
        C++;
      } 
      
      n ++;
        
   }
   
   a = A/n;
   b = B/n;
   c = C/n;

   System.out.println("---- JACCARD ---'");
   System.out.println("Valor A :" + String.valueOf(A));
   System.out.println("Valor B :" + String.valueOf(B));
   System.out.println("Valor C :" + String.valueOf(C));
   System.out.println("Valor a :" + String.valueOf(a));
   System.out.println("Valor b :" + String.valueOf(b));
   System.out.println("Valor c :" + String.valueOf(c));
            
   System.out.println("Valor de n en DISTANCIA" + n);
   distanciaJaccard = (a)/(a + b + c );
   
   return distanciaJaccard;
 }
 

public static Double calculaDistanciaRusselRao( int arregloPerfiles[][], int numFilas )
 {

   Double distanciaRusselRao = 0.00;
   
   Double A = 0.00;
   Double B = 0.00;
   Double C = 0.00;
   Double D = 0.00;
   Double a = 0.00;
   Double b = 0.00;
   Double c = 0.00;
   Double d = 0.00;

   int n = 0;
   
   
   for ( int fila = 0; fila < numFilas; fila++ )
   {
       
       if((arregloPerfiles[fila][0] == 1) && (arregloPerfiles[fila][1] == 1))             
      { 
        A++;
      } 
       if((arregloPerfiles[fila][0] == 1) && (arregloPerfiles[fila][1] == 0))             
      { 
        B++;
      } 
       if((arregloPerfiles[fila][0] == 0) && (arregloPerfiles[fila][1] == 1))             
      { 
        C++;
      } 
       if((arregloPerfiles[fila][0] == 0) && (arregloPerfiles[fila][1] == 0))             
      { 
        D++;
      }
      
      n ++;
        
   }
   
   a = A/n;
   b = B/n;
   c = C/n;
   d = D/n;

   System.out.println("---- RUSSEL Y RAO ---'");
   System.out.println("Valor A :" + String.valueOf(A));
   System.out.println("Valor B :" + String.valueOf(B));
   System.out.println("Valor C :" + String.valueOf(C));
   System.out.println("Valor a :" + String.valueOf(a));
   System.out.println("Valor b :" + String.valueOf(b));
   System.out.println("Valor c :" + String.valueOf(c));
   
   
   distanciaRusselRao = (a)/(a + b + c + d);
   
   return distanciaRusselRao;
 } 


  public static void actualizaCalif(String idCandidato, int idPerfilIdoneo, double distHamming, double distEuclidiana, double distRusselRao, double distJaccard  )
 {

     Conexion c = new Conexion();
     Connection con = c.getConexion();
          
    String sql_1 = "UPDATE Perfiles_candidatos_general SET Distancia_hamming    = '" + distHamming    + "', "
                                                        + "Distancia_euclidiana = '" + distEuclidiana + "',  "
                                                        + "Distancia_russelrao  = '" + distRusselRao + "',  "
                                                        + "Distancia_jaccard    = '" + distJaccard + "' "
                    + "WHERE Id_candidato = '" + idCandidato + "'"
                      + "AND Id_perfil_idoneo = " + idPerfilIdoneo ;
         
       try (PreparedStatement pst = con.prepareStatement(sql_1)) 
       {
            pst.executeUpdate();           
            
            pst.close();
            con.close();
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }
       
            
       
     c.cerrarConexion();
    
    
 }


public static void imprimirArreglo( int arreglo[][] )
 {

   for ( int fila = 0; fila < arreglo.length; fila++ )
  {
    for ( int columna = 0; columna < arreglo[ fila ].length; columna++ )
    System.out.printf( "%d ", arreglo[ fila ][ columna ] );
    System.out.println(); // inicia nueva línea de salida
  }
 } 
 
}
