
**;

%%put "xxxx options ls=255 ps=65  nofmterr nocenter nodate nonumber noquotelenmax validvarname=upcase
 compress=no FORMCHAR='|----|+|---+=|-/\<>*' xxxx" ;

%let _init_= %str(
 /* filename wpswbhtm clear; */
  ods _all_ close;
  ods listing;
  options ls=255 ps=65
    nofmterr nocenter
    nodate nonumber
    noquotelenmax
    validvarname=upcase
    compress=no
    FORMCHAR='|----|+|---+=|-/\<>*');

libname wpsuser "d:/wpsusr";
libname wpshelp wpd (sashelp);


   proc format;

     value num2mis
      .<-.Z      = 'MIS'
      0          = 'ZRO'
      0<-high    = "POS"
      low-<0     = 'NEG'
      other      = 'POP'
      ;

      value $chr2mis
      'Unknown',' ','UNK','NOT DONE','ND','NA','UNKNOWN','Missing','MISSING','MISS' ='MIS'
      other='POP'
       ;
   run;quit;

/*---- LETTERS ----*/

%let lettersq=
 "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z";
%let letters=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z;
%let letter=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz;

/*---- NUMBERS ----*/

%let numbersq=%str("1","2","3","4","5","6","7","8","9","10");
%let numbers=1 2 3 4 5 6 7 8 9 10;
%let number=12345678910;

/*---- STATES  ----*/

%let states50q="AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME"
,"MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD"
,"TN","TX","UT","VT","VA","WA","WV","WI","WY";

%let states50= %sysfunc(compbl(AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT
NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY)) ;

/*---- MONTHS  ----*/

%let monthsq="JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT", "NOV", "DEC" ;
%let months = JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC;

%let monthsq=%str("JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE","JULY","AUGUST","SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER");
%let months=JANUARY FEBRUARY MARCH APRIL MAY JUNE JULY AUGUST SEPTEMBER OCTOBER NOVEMBER DECEMBER;                                

/*---- DAYS    ----*/

%let daysq="Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday";
%let days=Monday Tuesday Wednesday Thursday Friday Saturday Sunday;

%let daysabvq="Mon","Tue","Wed","Thu","Fri","Sat","Sun";
%let daysabv=Mon Tue Wed Thu Fri Sat Sun;


/*---- STATES LONG NAMES 50  ----*/                                       
                                                                          
%let stateslnq=%sysfunc(compbl(%str(                                      
 "Alabama"        ,"Alaska"         ,"Arizona"        ,"Arkansas"         
,"California"     ,"Colorado"       ,"Connecticut"    ,"Delaware"         
,"Florida"        ,"Georgia"        ,"Hawaii"         ,"Idaho"            
,"Illinois"       ,"Indiana"        ,"Iowa"           ,"Kansas"           
,"Kentucky"       ,"Louisiana"      ,"Maine"          ,"Maryland"         
,"Massachusetts"  ,"Michigan"       ,"Minnesota"      ,"Mississippi"      
,"Missouri"       ,"Montana"        ,"Nebraska"       ,"Nevada"           
,"New Hampshire"  ,"New Jersey"     ,"New Mexico"     ,"New York"         
,"North Carolina" ,"North Dakota"   ,"Ohio"           ,"Oklahoma"         
,"Oregon"         ,"Pennsylvania"   ,"Rhode Island"   ,"South Carolina"   
,"South Dakota"   ,"Tennessee"      ,"Texas"          ,"Utah"             
,"Vermont"        ,"Virginia"       ,"Washington"     ,"West Virginia"    
,"Wisconsin"      ,"Wyoming")));                                          


* empty text file;
data _null_;                                     
        file "c:/temp/null.txt" lrecl=1 recfm=f; 
        put '1A'x;  /*EOF*/                      
       run;quit;                                 

/*--- 1 observation 1 variable with  one NULL value ---*/

data _null_;
  retain _NULL_ .;
run;quit;

/*
    libname sd1 sas7bdat "d:/sd1";
    proc datasets lib=sd1
      nolist nodetails;
      delete dataframe;
    run;quit;
      proc r;
       submit;
       df <- readRDS("d:/rds/dataframe.rds")
       head(df)
       endsubmit;
       import data=sd1.dataframe r=df;
      ;quit;
      proc print data=sd1.dataframe(obs=5);
      run;quit;
 */

/*----
options set=PYTHONHOME "D:\python310";
proc python;

submit;
from tkinter import Tk, Button

# Create the main window
root = Tk()
root.geometry("200x100")  # Set window size

# Create a Quit button that closes the window
quit_button = Button(root, text="Quit", command=root.destroy)
quit_button.pack(pady=20)

# Run the Tkinter event loop
root.mainloop()
endsubmit;
run;quit;
----*/













         