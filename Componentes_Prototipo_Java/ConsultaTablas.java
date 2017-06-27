/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tesis_rhti;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author CD
 */
public class ConsultaTablas 
{

    public ArrayList consultaCandidatos(String idCandidato)
 {

     // Crea un lista para almacenar los valores de los campos que queremos
     ArrayList<String> consCandidatos = new ArrayList<> ();           

     Conexion c = new Conexion();
     Connection con = c.getConexion();
 
     // Consulta tabla: Candidatos
     String sql_1 = "SELECT * FROM Candidatos WHERE Id_candidato = '" + idCandidato + "'" ;

     try {
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_1);
                  
         while(rs.next())
         {        
            consCandidatos.add(rs.getString(1));
            consCandidatos.add(rs.getString(2));
            consCandidatos.add(rs.getString(3));
            consCandidatos.add(String.valueOf(rs.getInt(4)));
            consCandidatos.add(rs.getString(5));
            consCandidatos.add(rs.getString(6));
         }
       
        rs.close();
        con.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }

       
     c.cerrarConexion();
    
    
    return consCandidatos;
 }
    


    public String[][] consultaEducacionAcadCandidatos(String idCandidato)
 {

     String arregloPerfiles[][] = new String[10][7];
     int filas = 0;

     Conexion c = new Conexion();
     Connection con = c.getConexion();
 
     // Consulta tabla: Candidatos
     String sql_1 = "SELECT * FROM Educacion_academica_cand WHERE Id_candidato = '" + idCandidato + "'"
                   + "ORDER BY Id_nivel";

     try {
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_1);
                  
         while(rs.next())
         {   
            arregloPerfiles[filas][0]= rs.getString(1);
            arregloPerfiles[filas][1]= String.valueOf(rs.getInt(2));
            arregloPerfiles[filas][2]= String.valueOf(rs.getInt(3));
            arregloPerfiles[filas][3]= String.valueOf(rs.getInt(4));
            arregloPerfiles[filas][4]= rs.getString(5);
            arregloPerfiles[filas][5]= rs.getString(6);
            arregloPerfiles[filas][6]= rs.getString(7);

            filas ++;
         }
       
        rs.close();
        con.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }

       
     c.cerrarConexion();
    
    
    return arregloPerfiles;
 }



    public String[][] consultaEmpleosCandidatos(String idCandidato)
 {

     String arregloPerfiles[][] = new String[10][10];
     int filas = 0;

     Conexion c = new Conexion();
     Connection con = c.getConexion();
 
     // Consulta tabla: Candidatos
     String sql_1 = "SELECT * FROM Empleos_cand WHERE Id_candidato = '" + idCandidato + "'"
                   + "ORDER BY Id_tipo_empleo";

     try {
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_1);
                  
         while(rs.next())
         {   
            arregloPerfiles[filas][0]= rs.getString(1); 
            arregloPerfiles[filas][1]= String.valueOf(rs.getInt(2));
            arregloPerfiles[filas][2]= String.valueOf(rs.getInt(3));
            arregloPerfiles[filas][3]= String.valueOf(rs.getInt(4));
            arregloPerfiles[filas][4]= String.valueOf(rs.getInt(5));
            arregloPerfiles[filas][5]= rs.getString(6);
            arregloPerfiles[filas][6]= rs.getString(7);
            arregloPerfiles[filas][7]= rs.getString(8);
            arregloPerfiles[filas][8]= String.valueOf(rs.getInt(9));
            arregloPerfiles[filas][9]= String.valueOf(rs.getDouble(10));

            filas ++;
         }
       
        rs.close();
        con.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }

       
     c.cerrarConexion();
    
    
    return arregloPerfiles;
 }

    
    
    
    public String[][] consultaExperienciaLaboral(String idCandidato)
 {

     String arregloPerfiles[][] = new String[2][6];
     int filas = 0;

     Conexion c = new Conexion();
     Connection con = c.getConexion();
 
     // Consulta tabla: Candidatos
     String sql_1 = "SELECT * FROM Experiencia_laboral_cand WHERE Id_candidato = '" + idCandidato + "'"
                   + "ORDER BY Id_candidato";

     try {
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_1);
                  
         while(rs.next())
         {   
            arregloPerfiles[filas][0]= rs.getString(1); 
            arregloPerfiles[filas][1]= String.valueOf(rs.getInt(2));
            arregloPerfiles[filas][2]= String.valueOf(rs.getInt(3));
            arregloPerfiles[filas][3]= String.valueOf(rs.getInt(4));
            arregloPerfiles[filas][4]= String.valueOf(rs.getInt(5));
            arregloPerfiles[filas][5]= String.valueOf(rs.getInt(6));

            filas ++;
         }
       
        rs.close();
        con.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }

       
     c.cerrarConexion();
    
    
    return arregloPerfiles;
 }




    public String[][] consultaIdiomasCandidatos(String idCandidato)
 {

     String arregloPerfiles[][] = new String[10][3];
     int filas = 0;

     Conexion c = new Conexion();
     Connection con = c.getConexion();
 
     // Consulta tabla: Candidatos
     String sql_1 = "SELECT * FROM Idiomas_cand WHERE Id_candidato = '" + idCandidato + "'"
                   + "ORDER BY Id_idioma";

     try {
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_1);
                  
         while(rs.next())
         {   
            arregloPerfiles[filas][0]= rs.getString(1);
            arregloPerfiles[filas][1]= rs.getString(2);
            arregloPerfiles[filas][2]= String.valueOf(rs.getInt(3));
 
            filas ++;
         }
       
        rs.close();
        con.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }

       
     c.cerrarConexion();
    
    
    return arregloPerfiles;
 }




    
    
}
