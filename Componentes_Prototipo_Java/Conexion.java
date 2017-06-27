/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tesis_rhti;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author CD
 */
public class Conexion 
{

 private Connection con = null;
 // nombre del controlador de JDBC y URL de la base de datos
 private static  String CONTROLADOR = "com.microsoft.sqlserver.jdbc.SQLServerDriver"; 
 private static  String URL_BASEDATOS = "jdbc:sqlserver://Lenovo-PC:1433;databaseName=tesisrh";
 
 public Conexion()
 {
     
  try   
  {
   Class.forName(CONTROLADOR).newInstance();
   con = DriverManager.getConnection(URL_BASEDATOS,"sa","daniel");
  }   
  catch (ClassNotFoundException | InstantiationException | IllegalAccessException ex) {          
     } 
  catch (SQLException ex) {
          System.out.println("Error del MySQL, SQLSTATE: " + ex.getSQLState());
          System.out.println("SQL ERROR  :  " + ex.getErrorCode());
          System.out.println("SQL MESSAGE:  " + ex.getMessage());
          
     }             
 }
 
 public Connection getConexion()
 {
  return con;
 }
 
 public void cerrarConexion()
 {
  try 
  {
   con.close();
  } catch (SQLException ex) {
   ex.printStackTrace();
  }
 }
    
}
