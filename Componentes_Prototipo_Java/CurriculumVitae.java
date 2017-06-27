/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tesis_rhti;

 
//import java.io.FileOutputStream;
        
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPCell;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

        
/**
 *
 * @author CD
 */
public class CurriculumVitae
{ 
//    public static void main(String[] args)

    public  void imprimeCurriculum (String idCandidato)
    {

        try {
            Document documento = new Document();           
            PdfWriter.getInstance (documento, new FileOutputStream("d:/CV_"+ idCandidato + ".pdf"));

            documento.open();
            
            // ENCABEZADO (CURRÍCULUM VITAE)
            Paragraph parrafo1 = new Paragraph("CURRÍCULUM VITAE\n",FontFactory.getFont("Arial",30,Font.BOLD,BaseColor.DARK_GRAY));
            parrafo1.setAlignment(Element.ALIGN_CENTER);
            documento.add(parrafo1);            
 
            // INFORMACIÓN PERSONAL
            Paragraph parrafo2 = new Paragraph("\nINFORMACIÓN PERSONAL\n\n",FontFactory.getFont("Arial",14,Font.BOLD,BaseColor.DARK_GRAY));
            parrafo2.setAlignment(Element.ALIGN_CENTER);
            documento.add(parrafo2);            
                
            ArrayList<String> consultaCandidatos = new ArrayList<> ();                       
            ConsultaTablas tablaCandidatos = new ConsultaTablas();
            consultaCandidatos = tablaCandidatos.consultaCandidatos(idCandidato);        
                                   
            PdfPTable tabla1 = new PdfPTable(2);
            tabla1.addCell(new Paragraph ("NOMBRE:",FontFactory.getFont("Arial",10,Font.BOLD)));
            tabla1.addCell(new Paragraph (consultaCandidatos.get(1),FontFactory.getFont("Arial",10)));

            tabla1.addCell(new Paragraph ("SEXO:",FontFactory.getFont("Arial",10,Font.BOLD)));
            String sexo;
                   switch( consultaCandidatos.get(2).trim())
                   {  
                    case "M"    : sexo = "Masculino"  ;  break;
                    case "F"    : sexo = "Femenino" ;  break;
                    default     : sexo = ""  ;  break;
                   }
            tabla1.addCell(new Paragraph (sexo,FontFactory.getFont("Arial",10)));

            tabla1.addCell(new Paragraph ("EDAD:",FontFactory.getFont("Arial",10,Font.BOLD)));
            tabla1.addCell(new Paragraph (consultaCandidatos.get(3),FontFactory.getFont("Arial",10)));

            tabla1.addCell(new Paragraph ("EDO. CIVIL:",FontFactory.getFont("Arial",10,Font.BOLD)));
            String edoCivil;
                   switch( consultaCandidatos.get(4).trim())
                   {  
                    case "S"    : edoCivil = "Soltero"  ;  break;
                    case "C"    : edoCivil = "Casado" ;  break;
                    case "O"    : edoCivil = "Otro" ;  break;
                    default     : edoCivil = ""  ;  break;
                   }
            tabla1.addCell(new Paragraph (edoCivil,FontFactory.getFont("Arial",10)));
            
            // se agrega tabla1
            float [] medidas1 = {3,6};
            tabla1.setWidths(medidas1);
            documento.add(tabla1);
                                   

            // INFORMACIÓN ACADÉMICA
            Paragraph parrafo3 = new Paragraph("\nINFORMACIÓN ACADÉMICA\n\n",FontFactory.getFont("Arial",14,Font.BOLD,BaseColor.DARK_GRAY));
            parrafo3.setAlignment(Element.ALIGN_CENTER);
            documento.add(parrafo3);            

           
            String arregloEducaAcadCand[][] = new String[10][7];
                   
            ConsultaTablas tablaEducaAcadCandidatos = new ConsultaTablas();
            arregloEducaAcadCand = tablaEducaAcadCandidatos.consultaEducacionAcadCandidatos(idCandidato);
                                   
       
            for ( int fila = 0; fila < arregloEducaAcadCand.length ; fila++ )
            {
              if (arregloEducaAcadCand[fila][0] != null )
              {
                PdfPTable tabla2 = new PdfPTable(2);
 
                tabla2.addCell(new Paragraph ("NIVEL ACADÉMICO:",FontFactory.getFont("Arial",10,Font.BOLD)));

                   String nivelEduca = "";

                   switch( Integer.parseInt(arregloEducaAcadCand[fila][1].trim()))
                   {  
                    case 1    : nivelEduca = "PRIMARIA"                 ;  break;
                    case 2    : nivelEduca = "SECUNDARIA"               ;  break;
                    case 3    : nivelEduca = "EDUCACIÓN MEDIA SUPERIOR" ;  break;
                    case 4    : nivelEduca = "EDUCACIÓN SUPERIOR"       ;  break;
                    case 5    : nivelEduca = "MAESTRÍA"                 ;  break;
                    case 6    : nivelEduca = "DOCTORADO"                ;  break;
                    default   : nivelEduca = ""                         ;  break;
                   }

                tabla2.addCell(new Paragraph (nivelEduca,FontFactory.getFont("Arial",10)));

                tabla2.addCell(new Paragraph ("INSTITUCIÓN:",FontFactory.getFont("Arial",10)));
                tabla2.addCell(new Paragraph (arregloEducaAcadCand[fila][4],FontFactory.getFont("Arial",10)));

                tabla2.addCell(new Paragraph ("CARRERRA:",FontFactory.getFont("Arial",10)));
                tabla2.addCell(new Paragraph (arregloEducaAcadCand[fila][5],FontFactory.getFont("Arial",10)));

                tabla2.addCell(new Paragraph ("SITUACIÓN:",FontFactory.getFont("Arial",10)));
                   String sitEduca = "";

                   switch( Integer.parseInt(arregloEducaAcadCand[fila][2].trim()))
                   {  
                    case 1    : sitEduca = "Trunca"                 ;  break;
                    case 2    : sitEduca = "Cursando"               ;  break;
                    case 3    : sitEduca = "Concluido (sin título)" ;  break;
                    case 4    : sitEduca = "Concluido (con título)" ;  break;
                    default   : sitEduca = ""                       ;  break;
                   }

                tabla2.addCell(new Paragraph (sitEduca,FontFactory.getFont("Arial",10)));

                tabla2.addCell(new Paragraph ("FECHA DE TÉRMINO:",FontFactory.getFont("Arial",10)));
                tabla2.addCell(new Paragraph (arregloEducaAcadCand[fila][3],FontFactory.getFont("Arial",10)));

                // se agrega tabla1
                float [] medidas2 = {3,6};
                tabla2.setWidths(medidas2);
                documento.add(tabla2);
                
                
              }
            }
            


            // INFORMACIÓN LABORAL
            Paragraph parrafo4 = new Paragraph("\nINFORMACIÓN LABORAL\n\n",FontFactory.getFont("Arial",14,Font.BOLD,BaseColor.DARK_GRAY));
            parrafo4.setAlignment(Element.ALIGN_CENTER);
            documento.add(parrafo4);            
            

            String arregloEmpleosCand[][] = new String[10][10];
                   
            ConsultaTablas tablaEmpleosCandidatos = new ConsultaTablas();
            arregloEmpleosCand = tablaEmpleosCandidatos.consultaEmpleosCandidatos(idCandidato);
                                   
       
            for ( int fila = 0; fila < arregloEmpleosCand.length ; fila++ )
            {
              if (arregloEmpleosCand[fila][0] != null )
              {
                PdfPTable tabla3 = new PdfPTable(2);
 
                tabla3.addCell(new Paragraph ("EMPLEO:",FontFactory.getFont("Arial",10,Font.BOLD)));

                   String tipoEmpleo = "";

                   switch( Integer.parseInt(arregloEmpleosCand[fila][1].trim()))
                   {  
                    case 1    : tipoEmpleo = "ACTUAL"     ;  break;
                    case 2    : tipoEmpleo = "ÚLTIMO"     ;  break;
                    default   : tipoEmpleo = ""           ;  break;
                   }

                tabla3.addCell(new Paragraph (tipoEmpleo,FontFactory.getFont("Arial",10)));

                tabla3.addCell(new Paragraph ("EMPRESA:",FontFactory.getFont("Arial",10,Font.BOLD)));
                tabla3.addCell(new Paragraph (arregloEmpleosCand[fila][6],FontFactory.getFont("Arial",10)));

                tabla3.addCell(new Paragraph ("SECTOR:",FontFactory.getFont("Arial",10,Font.BOLD)));
  
                String sectorEmpleo = "";

                   switch(arregloEmpleosCand[fila][5].trim())
                   {  
                    case "PUB"    : sectorEmpleo = "Público"     ;  break;
                    case "PRI"    : sectorEmpleo = "Privado"     ;  break;
                    default       : sectorEmpleo = ""           ;  break;
                   }
                tabla3.addCell(new Paragraph (sectorEmpleo,FontFactory.getFont("Arial",10)));

                tabla3.addCell(new Paragraph ("ANTIGÜEDAD EMPLEO:",FontFactory.getFont("Arial",10,Font.BOLD)));
                tabla3.addCell(new Paragraph (arregloEmpleosCand[fila][3] + " al " + arregloEmpleosCand[fila][4],FontFactory.getFont("Arial",10)));

                tabla3.addCell(new Paragraph ("PUESTO:",FontFactory.getFont("Arial",10,Font.BOLD)));
                tabla3.addCell(new Paragraph (arregloEmpleosCand[fila][7],FontFactory.getFont("Arial",10)));

                tabla3.addCell(new Paragraph ("ANTIGÜEDAD PUESTO:",FontFactory.getFont("Arial",10,Font.BOLD)));
                String aniosPuesto = "";
                switch(Integer.parseInt(arregloEmpleosCand[fila][8].trim()))
                  {
                   case 0   : aniosPuesto = "Menos de 1 año" ;  break;
                   case 1   : aniosPuesto = "1 año"          ;  break;
                   default  : aniosPuesto = arregloEmpleosCand[fila][8].trim() + " años"  ;  break;
                  }               
                tabla3.addCell(new Paragraph (aniosPuesto,FontFactory.getFont("Arial",10)));

                tabla3.addCell(new Paragraph ("SUELDO:",FontFactory.getFont("Arial",10,Font.BOLD)));
                tabla3.addCell(new Paragraph (arregloEmpleosCand[fila][9],FontFactory.getFont("Arial",10)));

                
                // se agrega tabla1
                float [] medidas2 = {3,6};
                tabla3.setWidths(medidas2);
                documento.add(tabla3);
                
                
              }
            }


            // HISTORIAL LABORAL
            Paragraph parrafo6 = new Paragraph("\nHISTORIAL LABORAL\n\n",FontFactory.getFont("Arial",14,Font.BOLD,BaseColor.DARK_GRAY));
            parrafo6.setAlignment(Element.ALIGN_CENTER);
            documento.add(parrafo6);            

            String arregloExpLaboral[][] = new String[2][6];
                   
            ConsultaTablas tablaExpLaboralCand = new ConsultaTablas();
            arregloExpLaboral = tablaExpLaboralCand.consultaExperienciaLaboral(idCandidato);
            

            for ( int fila = 0; fila < arregloExpLaboral.length ; fila++ )
            {
              if (arregloExpLaboral[fila][0] != null )
              {
                PdfPTable tabla3 = new PdfPTable(2);
 
                tabla3.addCell(new Paragraph ("EXPERIENCIA LABORAL:",FontFactory.getFont("Arial",10,Font.BOLD)));
                
                String aniosExpLaboral = "";
                switch(Integer.parseInt(arregloExpLaboral[fila][1].trim()))
                  {
                   case 0   : aniosExpLaboral = "Menos de 1 año" ;  break;
                   case 1   : aniosExpLaboral = "1 año"          ;  break;
                   default  : aniosExpLaboral = arregloExpLaboral[fila][1].trim() + " años"  ;  break;
                  }               
                tabla3.addCell(new Paragraph (aniosExpLaboral,FontFactory.getFont("Arial",10)));

                tabla3.addCell(new Paragraph ("TOTAL DE EMPLEOS:",FontFactory.getFont("Arial",10,Font.BOLD)));
                String aniosTotEmpleos = "";
                switch(Integer.parseInt(arregloExpLaboral[fila][2].trim()))
                  {
                   case 0   : aniosTotEmpleos = "Menos de 1 año" ;  break;
                   case 1   : aniosTotEmpleos = "1 año"          ;  break;
                   default  : aniosTotEmpleos = arregloExpLaboral[fila][2].trim() + " años"  ;  break;
                  }               
                tabla3.addCell(new Paragraph (aniosTotEmpleos,FontFactory.getFont("Arial",10)));

                tabla3.addCell(new Paragraph ("MAX.ANTIGÜEDAD(EMPL):",FontFactory.getFont("Arial",10,Font.BOLD)));
                String aniosMaxAntEmpleos = "";
                switch(Integer.parseInt(arregloExpLaboral[fila][3].trim()))
                  {
                   case 0   : aniosMaxAntEmpleos = "Menos de 1 año" ;  break;
                   case 1   : aniosMaxAntEmpleos = "1 año"          ;  break;
                   default  : aniosMaxAntEmpleos = arregloExpLaboral[fila][3].trim() + " años"  ;  break;
                  }               
                tabla3.addCell(new Paragraph (aniosMaxAntEmpleos,FontFactory.getFont("Arial",10)));

                tabla3.addCell(new Paragraph ("MIN.ANTIGÜEDAD(EMPL):",FontFactory.getFont("Arial",10,Font.BOLD)));
                String aniosMinAntEmpleos = "";
                switch(Integer.parseInt(arregloExpLaboral[fila][4].trim()))
                  {
                   case 0   : aniosMinAntEmpleos = "Menos de 1 año" ;  break;
                   case 1   : aniosMinAntEmpleos = "1 año"          ;  break;
                   default  : aniosMinAntEmpleos = arregloExpLaboral[fila][4].trim() + " años"  ;  break;
                  }               
                tabla3.addCell(new Paragraph (aniosMinAntEmpleos,FontFactory.getFont("Arial",10)));

                tabla3.addCell(new Paragraph ("MAX.INACTIVIDAD(EMPL):",FontFactory.getFont("Arial",10,Font.BOLD)));
                String aniosMaxInacEmpleos = "";
                switch(Integer.parseInt(arregloExpLaboral[fila][5].trim()))
                  {
                   case 0   : aniosMaxInacEmpleos = "Menos de 1 año" ;  break;
                   case 1   : aniosMaxInacEmpleos = "1 año"          ;  break;
                   default  : aniosMaxInacEmpleos = arregloExpLaboral[fila][5].trim() + " años"  ;  break;
                  }               
                tabla3.addCell(new Paragraph (aniosMaxInacEmpleos,FontFactory.getFont("Arial",10)));

                
                // se agrega tabla1
                float [] medidas2 = {3,6};
                tabla3.setWidths(medidas2);
                documento.add(tabla3);
                                
              }
            }
                       
                       
            
            
            // IDIOMAS
            Paragraph parrafo5 = new Paragraph("\nIDIOMAS\n\n",FontFactory.getFont("Arial",14,Font.BOLD,BaseColor.DARK_GRAY));
            parrafo5.setAlignment(Element.ALIGN_CENTER);
            documento.add(parrafo5);            
                       

            String arregloIdiomasCand[][] = new String[10][3];
                   
            ConsultaTablas tablaIdiomasCandidatos = new ConsultaTablas();
            arregloIdiomasCand = tablaIdiomasCandidatos.consultaIdiomasCandidatos(idCandidato);
                                   
       
            for ( int fila = 0; fila < arregloIdiomasCand.length ; fila++ )
            {
              if (arregloIdiomasCand[fila][0] != null )
              {
                PdfPTable tabla4 = new PdfPTable(2);
 
                   String idiomaCand = "";

                   switch(arregloIdiomasCand[fila][1].trim())
                   {  
                    case "ING"    : idiomaCand = "Inglés"     ;  break;
                    case "FRA"    : idiomaCand = "Francés"    ;  break;
                    case "ALE"    : idiomaCand = "Alemán"     ;  break;
                    case "JAP"    : idiomaCand = "Japonés"    ;  break;
                    case "MAN"    : idiomaCand = "Mandarín"   ;  break;
                    default       : idiomaCand = ""           ;  break;
                   }

                tabla4.addCell(new Paragraph (idiomaCand,FontFactory.getFont("Arial",10,Font.BOLD)));
 
                String nivelIdioma = "";

                   switch(Integer.parseInt(arregloIdiomasCand[fila][2].trim()))
                   {  
                    case 0    : nivelIdioma = "Nulo"              ;  break;
                    case 1    : nivelIdioma = "Bajo"              ;  break;
                    case 2    : nivelIdioma = "Medio"             ;  break;
                    case 3    : nivelIdioma = "Alto"              ;  break;
                    case 4    : nivelIdioma = "Con certificación" ;  break;
                    default   : nivelIdioma = ""                  ;  break;
                   }
                tabla4.addCell(new Paragraph (nivelIdioma,FontFactory.getFont("Arial",10)));

                
                // se agrega tabla1
                float [] medidas2 = {3,6};
                tabla4.setWidths(medidas2);
                documento.add(tabla4);
                
                
              }
            }


            
            
            
            
            documento.close();
            
            JOptionPane.showMessageDialog(null, "SE HA IMPRESO CORRECTAMENTE EL CURRICULUM VITAE \nDEL CANDIDATO CON ID: " + idCandidato);


            
        } catch (DocumentException ex) {
            Logger.getLogger(CurriculumVitae.class.getName()).log(Level.SEVERE, null, ex);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(CurriculumVitae.class.getName()).log(Level.SEVERE, null, ex);
        }
            
 }
}


 //   OutputStream archivo = new FileOutputStream(new File("c:/hellow.pdf"));
//    FileOutputStream archivo = new FileOutputStream("c:/hellow.pdf");
//    PdfWriter.getInstance (document, new FileOutputStream("d:/hellow.pdf"));
            
//    PdfWriter.getInstance(document,new FileOutputStream("c:/hellopdf.pdf")); 
    
