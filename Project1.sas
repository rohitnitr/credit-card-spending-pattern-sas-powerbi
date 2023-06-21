/* Importing the data from Excel files */
PROC IMPORT DATAFILE='/home/u63390954/sasuser.v94/acqusition.xlsx'
     OUT=customer_acquisition_clean
     DBMS=XLSX REPLACE;
     GETNAMES=YES;
RUN;






/* Calculate the mean age of customers */
PROC SQL;
     SELECT MEAN(Age) INTO :mean_age FROM customer_acquisition_clean WHERE Age >= 18;
QUIT;

/* Replace the values of age less than 18 with the calculated mean age */
DATA customer_acquisition_clean;
     SET customer_acquisition_clean;
     IF Age < 18 THEN Age = &mean_age.;
    

RUN;


/* Importing the data from spend.xlsx */
PROC IMPORT DATAFILE='/home/u63390954/sasuser.v94/spend.xlsx'
     OUT=spend_clean
     DBMS=XLSX REPLACE;
     GETNAMES=YES;
RUN;
/* Convert the Month column to SAS date format */
DATA spend_clean;
    SET spend_clean;
    Month_date = INPUT(Month, ddMONyy.);
    FORMAT Month_date date9.;
RUN;


/* Importing the data from repayment.xlsx */
PROC IMPORT DATAFILE='/home/u63390954/sasuser.v94/repayment.xlsx'
     OUT=repayment_clean
     DBMS=XLSX REPLACE;
     GETNAMES=YES;
     
 DATA repayment_clean;
    SET repayment_clean;
    Month_date = INPUT(Month, ddMONyy.);
    FORMAT Month_date date9.;
RUN;






















/* Create a new table to store the results for 2004 */
data customer_spend_2004;
   set customer_acquisition_clean (keep=Customer);
   Monthly_spend_Jan_2004 = 0;
   Monthly_spend_Feb_2004 = 0;
   Monthly_spend_Mar_2004 = 0;
   Monthly_spend_Apr_2004 = 0;
   Monthly_spend_May_2004 = 0;
   Monthly_spend_Jun_2004 = 0;
   Monthly_spend_Jul_2004 = 0;
   Monthly_spend_Aug_2004 = 0;
   Monthly_spend_Sep_2004 = 0;
   Monthly_spend_Oct_2004 = 0;
   Monthly_spend_Nov_2004 = 0;
   Monthly_spend_Dec_2004 = 0;
run;

/* Calculate the sum of spend amounts for each customer for each month in 2004 */
proc sql;
   update customer_spend_2004
   set Monthly_spend_Jan_2004 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01JAN2004'd), 0),
       Monthly_spend_Feb_2004 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01FEB2004'd), 0),
       Monthly_spend_Mar_2004 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01MAR2004'd), 0),
       Monthly_spend_Apr_2004 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01APR2004'd), 0),
       Monthly_spend_May_2004 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01MAY2004'd), 0),
       Monthly_spend_Jun_2004 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01JUN2004'd), 0),
       Monthly_spend_Jul_2004 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01JUL2004'd), 0),
       Monthly_spend_Aug_2004 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01AUG2004'd), 0),
       Monthly_spend_Sep_2004 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01SEP2004'd), 0),
       Monthly_spend_Oct_2004 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01OCT2004'd), 0),
       Monthly_spend_Nov_2004 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01NOV2004'd), 0),
       Monthly_spend_Dec_2004 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01DEC2004'd), 0);
quit;

/* Print the final table for 2004 */
proc print data=customer_spend_2004;
run;


/* Create a new table to store the results for 2004 */
data customer_repayment_2004;
   set customer_acquisition_clean (keep=Customer);
   Monthly_repayment_Jan_2004 = 0;
   Monthly_repayment_Feb_2004 = 0;
   Monthly_repayment_Mar_2004 = 0;
   Monthly_repayment_Apr_2004 = 0;
   Monthly_repayment_May_2004 = 0;
   Monthly_repayment_Jun_2004 = 0;
   Monthly_repayment_Jul_2004 = 0;
   Monthly_repayment_Aug_2004 = 0;
   Monthly_repayment_Sep_2004 = 0;
   Monthly_repayment_Oct_2004 = 0;
   Monthly_repayment_Nov_2004 = 0;
   Monthly_repayment_Dec_2004 = 0;
run;

/* Calculate the sum of repayment amounts for each customer for each month in 2004 */
proc sql;
   update customer_repayment_2004
   set Monthly_repayment_Jan_2004 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01JAN2004'd), 0),
       Monthly_repayment_Feb_2004 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01FEB2004'd), 0),
       Monthly_repayment_Mar_2004 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01MAR2004'd), 0),
       Monthly_repayment_Apr_2004 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01APR2004'd), 0),
       Monthly_repayment_May_2004 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01MAY2004'd), 0),
       Monthly_repayment_Jun_2004 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01JUN2004'd), 0),
       Monthly_repayment_Jul_2004 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01JUL2004'd), 0),
       Monthly_repayment_Aug_2004 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01AUG2004'd), 0),
       Monthly_repayment_Sep_2004 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01SEP2004'd), 0),
       Monthly_repayment_Oct_2004 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01OCT2004'd), 0),
       Monthly_repayment_Nov_2004 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01NOV2004'd), 0),
       Monthly_repayment_Dec_2004 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2004.Customer
                           and INTNX('MONTH', Month_date, 0) = '01DEC2004'd), 0);
quit;

/* Print the final table for 2004 */
proc print data=customer_repayment_2004;
run;





























/* Create a new table to store the results with penalties and credits */
data customer_penalty_credit_2004;
   set customer_acquisition_clean (keep=Customer Age City Limit);
   set customer_spend_2004 (keep=Customer Monthly_spend_:);
   set customer_repayment_2004 (keep=Customer Monthly_repayment_:);
   
   /* Initialize penalty and credit variables */
   Penalty_Jan_2004 = 0;
   Penalty_Feb_2004 = 0;
   Penalty_Mar_2004 = 0;
   Penalty_Apr_2004 = 0;
   Penalty_May_2004 = 0;
   Penalty_Jun_2004 = 0;
   Penalty_Jul_2004 = 0;
   Penalty_Aug_2004 = 0;
   Penalty_Sep_2004 = 0;
   Penalty_Oct_2004 = 0;
   Penalty_Nov_2004 = 0;
   Penalty_Dec_2004 = 0;
   
   Credit_Jan_2004 = 0;
   Credit_Feb_2004 = 0;
   Credit_Mar_2004 = 0;
   Credit_Apr_2004 = 0;
   Credit_May_2004 = 0;
   Credit_Jun_2004 = 0;
   Credit_Jul_2004 = 0;
   Credit_Aug_2004 = 0;
   Credit_Sep_2004 = 0;
   Credit_Oct_2004 = 0;
   Credit_Nov_2004 = 0;
   Credit_Dec_2004 = 0;
   
   /* Calculate penalties for exceeding spend limit */
   if Monthly_spend_Jan_2004 > Limit then do;
      Penalty_Jan_2004 = 0.02 * Limit;
   end;
   if Monthly_spend_Feb_2004 > Limit then do;
      Penalty_Feb_2004 = 0.02 * Limit;
   end;
   if Monthly_spend_Mar_2004 > Limit then do;
      Penalty_Mar_2004 = 0.02 * Limit;
   end;
   if Monthly_spend_Apr_2004 > Limit then do;
      Penalty_Apr_2004 = 0.02 * Limit;
   end;
   if Monthly_spend_May_2004 > Limit then do;
      Penalty_May_2004 = 0.02 * Limit;
   end;
   if Monthly_spend_Jun_2004 > Limit then do;
      Penalty_Jun_2004 = 0.02 * Limit;
   end;
   if Monthly_spend_Jul_2004 > Limit then do;
      Penalty_Jul_2004 = 0.02 * Limit;
   end;
   if Monthly_spend_Aug_2004 > Limit then do;
      Penalty_Aug_2004 = 0.02 * Limit;
   end;
   if Monthly_spend_Sep_2004 > Limit then do;
      Penalty_Sep_2004 = 0.02 * Limit;
   end;
   if Monthly_spend_Oct_2004 > Limit then do;
      Penalty_Oct_2004 = 0.02 * Limit;
   end;
   if Monthly_spend_Nov_2004 > Limit then do;
      Penalty_Nov_2004 = 0.02 * Limit;
   end;
   if Monthly_spend_Dec_2004 > Limit then do;
      Penalty_Dec_2004 = 0.02 * Limit;
   end;
   
   /* Calculate credits for repayments exceeding spend */
   if Monthly_repayment_Jan_2004 > Monthly_spend_Jan_2004 then do;
      Credit_Jan_2004 = 0.02 * Limit;
   end;
   if Monthly_repayment_Feb_2004 > Monthly_spend_Feb_2004 then do;
      Credit_Feb_2004 = 0.02 * Limit;
   end;
   if Monthly_repayment_Mar_2004 > Monthly_spend_Mar_2004 then do;
      Credit_Mar_2004 = 0.02 * Limit;
   end;
   if Monthly_repayment_Apr_2004 > Monthly_spend_Apr_2004 then do;
      Credit_Apr_2004 = 0.02 * Limit;
   end;
   if Monthly_repayment_May_2004 > Monthly_spend_May_2004 then do;
      Credit_May_2004 = 0.02 * Limit;
   end;
   if Monthly_repayment_Jun_2004 > Monthly_spend_Jun_2004 then do;
      Credit_Jun_2004 = 0.02 * Limit;
   end;
   if Monthly_repayment_Jul_2004 > Monthly_spend_Jul_2004 then do;
      Credit_Jul_2004 = 0.02 * Limit;
   end;
   if Monthly_repayment_Aug_2004 > Monthly_spend_Aug_2004 then do;
      Credit_Aug_2004 = 0.02 * Limit;
   end;
   if Monthly_repayment_Sep_2004 > Monthly_spend_Sep_2004 then do;
      Credit_Sep_2004 = 0.02 * Limit;
   end;
   if Monthly_repayment_Oct_2004 > Monthly_spend_Oct_2004 then do;
      Credit_Oct_2004 = 0.02 * Limit;
   end;
   if Monthly_repayment_Nov_2004 > Monthly_spend_Nov_2004 then do;
      Credit_Nov_2004 = 0.02 * Limit;
   end;
   if Monthly_repayment_Dec_2004 > Monthly_spend_Dec_2004 then do;
      Credit_Dec_2004 = 0.02 * Limit;
   end;
   
run;

/* Print the final table with penalties and credits for 2004 */
proc print data=customer_penalty_credit_2004;
run;




/* Create a new table to store the results for 2005 */
data customer_spend_2005;
   set customer_acquisition_clean (keep=Customer);
   Monthly_Spend_Jan_2005 = 0;
   Monthly_Spend_Feb_2005 = 0;
   Monthly_Spend_Mar_2005 = 0;
   Monthly_Spend_Apr_2005 = 0;
   Monthly_Spend_May_2005 = 0;
   Monthly_Spend_Jun_2005 = 0;
   Monthly_Spend_Jul_2005 = 0;
   Monthly_Spend_Aug_2005 = 0;
   Monthly_Spend_Sep_2005 = 0;
   Monthly_Spend_Oct_2005 = 0;
   Monthly_Spend_Nov_2005 = 0;
   Monthly_Spend_Dec_2005 = 0;
run;

/* Calculate the sum of spend amounts for each customer for each month in 2005 */
proc sql;
   update customer_spend_2005
   set Monthly_Spend_Jan_2005 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01JAN2005'd), 0),
       Monthly_Spend_Feb_2005 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01FEB2005'd), 0),
       Monthly_Spend_Mar_2005 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01MAR2005'd), 0),
       Monthly_Spend_Apr_2005 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01APR2005'd), 0),
       Monthly_Spend_May_2005 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01MAY2005'd), 0),
       Monthly_Spend_Jun_2005 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01JUN2005'd), 0),
       Monthly_Spend_Jul_2005 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01JUL2005'd), 0),
       Monthly_Spend_Aug_2005 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01AUG2005'd), 0),
       Monthly_Spend_Sep_2005 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01SEP2005'd), 0),
       Monthly_Spend_Oct_2005 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01OCT2005'd), 0),
       Monthly_Spend_Nov_2005 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01NOV2005'd), 0),
       Monthly_Spend_Dec_2005 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01DEC2005'd), 0);
quit;

/* Print the final table for 2005 */
proc print data=customer_spend_2005;
run;



/* Create a new table to store the results for 2005 */
data customer_repayment_2005;
   set customer_acquisition_clean (keep=Customer);
   Monthly_repayment_Jan_2005 = 0;
   Monthly_repayment_Feb_2005 = 0;
   Monthly_repayment_Mar_2005 = 0;
   Monthly_repayment_Apr_2005 = 0;
   Monthly_repayment_May_2005 = 0;
   Monthly_repayment_Jun_2005 = 0;
   Monthly_repayment_Jul_2005 = 0;
   Monthly_repayment_Aug_2005 = 0;
   Monthly_repayment_Sep_2005 = 0;
   Monthly_repayment_Oct_2005 = 0;
   Monthly_repayment_Nov_2005 = 0;
   Monthly_repayment_Dec_2005 = 0;
run;

/* Calculate the sum of repayment amounts for each customer for each month in 2005 */
proc sql;
   update customer_repayment_2005
   set Monthly_repayment_Jan_2005 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01JAN2005'd), 0),
       Monthly_repayment_Feb_2005 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01FEB2005'd), 0),
       Monthly_repayment_Mar_2005 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01MAR2005'd), 0),
       Monthly_repayment_Apr_2005 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01APR2005'd), 0),
       Monthly_repayment_May_2005 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01MAY2005'd), 0),
       Monthly_repayment_Jun_2005 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01JUN2005'd), 0),
       Monthly_repayment_Jul_2005 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01JUL2005'd), 0),
       Monthly_repayment_Aug_2005 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01AUG2005'd), 0),
       Monthly_repayment_Sep_2005 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01SEP2005'd), 0),
       Monthly_repayment_Oct_2005 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01OCT2005'd), 0),
       Monthly_repayment_Nov_2005 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01NOV2005'd), 0),
       Monthly_repayment_Dec_2005 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2005.Customer
                           and INTNX('MONTH', Month_date, 0) = '01DEC2005'd), 0);
quit;

/* Print the final table for 2005 */
proc print data=customer_repayment_2005;
run;
























/* Create a new table for the year 2005 to store the results with penalties and credits */
data customer_penalty_credit_2005;
   set customer_acquisition_clean (keep=Customer Age City Limit);
   set customer_spend_2005 (keep=Customer Monthly_spend_:);
   set customer_repayment_2005 (keep=Customer Monthly_repayment_:);
   
   /* Initialize penalty and credit variables */
   Penalty_Jan_2005 = 0;
   Penalty_Feb_2005 = 0;
   Penalty_Mar_2005 = 0;
   Penalty_Apr_2005 = 0;
   Penalty_May_2005 = 0;
   Penalty_Jun_2005 = 0;
   Penalty_Jul_2005 = 0;
   Penalty_Aug_2005 = 0;
   Penalty_Sep_2005 = 0;
   Penalty_Oct_2005 = 0;
   Penalty_Nov_2005 = 0;
   Penalty_Dec_2005 = 0;
   
   Credit_Jan_2005 = 0;
   Credit_Feb_2005 = 0;
   Credit_Mar_2005 = 0;
   Credit_Apr_2005 = 0;
   Credit_May_2005 = 0;
   Credit_Jun_2005 = 0;
   Credit_Jul_2005 = 0;
   Credit_Aug_2005 = 0;
   Credit_Sep_2005 = 0;
   Credit_Oct_2005 = 0;
   Credit_Nov_2005 = 0;
   Credit_Dec_2005 = 0;
   
   /* Calculate penalties for exceeding spend limit */
   if Monthly_spend_Jan_2005 > Limit then do;
      Penalty_Jan_2005 = 0.02 * Limit;
   end;
   if Monthly_spend_Feb_2005 > Limit then do;
      Penalty_Feb_2005 = 0.02 * Limit;
   end;
   if Monthly_spend_Mar_2005 > Limit then do;
      Penalty_Mar_2005 = 0.02 * Limit;
   end;
   if Monthly_spend_Apr_2005 > Limit then do;
      Penalty_Apr_2005 = 0.02 * Limit;
   end;
   if Monthly_spend_May_2005 > Limit then do;
      Penalty_May_2005 = 0.02 * Limit;
   end;
   if Monthly_spend_Jun_2005 > Limit then do;
      Penalty_Jun_2005 = 0.02 * Limit;
   end;
   if Monthly_spend_Jul_2005 > Limit then do;
      Penalty_Jul_2005 = 0.02 * Limit;
   end;
   if Monthly_spend_Aug_2005 > Limit then do;
      Penalty_Aug_2005 = 0.02 * Limit;
   end;
   if Monthly_spend_Sep_2005 > Limit then do;
      Penalty_Sep_2005 = 0.02 * Limit;
   end;
   if Monthly_spend_Oct_2005 > Limit then do;
      Penalty_Oct_2005 = 0.02 * Limit;
   end;
   if Monthly_spend_Nov_2005 > Limit then do;
      Penalty_Nov_2005 = 0.02 * Limit;
   end;
   if Monthly_spend_Dec_2005 > Limit then do;
      Penalty_Dec_2005 = 0.02 * Limit;
   end;
   
   /* Calculate credits for repayments exceeding spend */
   if Monthly_repayment_Jan_2005 > Monthly_spend_Jan_2005 then do;
      Credit_Jan_2005 = 0.02 * Limit;
   end;
   if Monthly_repayment_Feb_2005 > Monthly_spend_Feb_2005 then do;
      Credit_Feb_2005 = 0.02 * Limit;
   end;
   if Monthly_repayment_Mar_2005 > Monthly_spend_Mar_2005 then do;
      Credit_Mar_2005 = 0.02 * Limit;
   end;
   if Monthly_repayment_Apr_2005 > Monthly_spend_Apr_2005 then do;
      Credit_Apr_2005 = 0.02 * Limit;
   end;
   if Monthly_repayment_May_2005 > Monthly_spend_May_2005 then do;
      Credit_May_2005 = 0.02 * Limit;
   end;
   if Monthly_repayment_Jun_2005 > Monthly_spend_Jun_2005 then do;
      Credit_Jun_2005 = 0.02 * Limit;
   end;
   if Monthly_repayment_Jul_2005 > Monthly_spend_Jul_2005 then do;
      Credit_Jul_2005 = 0.02 * Limit;
   end;
   if Monthly_repayment_Aug_2005 > Monthly_spend_Aug_2005 then do;
      Credit_Aug_2005 = 0.02 * Limit;
   end;
   if Monthly_repayment_Sep_2005 > Monthly_spend_Sep_2005 then do;
      Credit_Sep_2005 = 0.02 * Limit;
   end;
   if Monthly_repayment_Oct_2005 > Monthly_spend_Oct_2005 then do;
      Credit_Oct_2005 = 0.02 * Limit;
   end;
   if Monthly_repayment_Nov_2005 > Monthly_spend_Nov_2005 then do;
      Credit_Nov_2005 = 0.02 * Limit;
   end;
   if Monthly_repayment_Dec_2005 > Monthly_spend_Dec_2005 then do;
      Credit_Dec_2005 = 0.02 * Limit;
   end;
   
run;

/* Print the final table with penalties and credits for 2005 */
proc print data=customer_penalty_credit_2005;
run;




/* Create a new table to store the results for 2006 */
data customer_spend_2006;
   set customer_acquisition_clean (keep=Customer);
   Monthly_Spend_Jan_2006 = 0;
   Monthly_Spend_Feb_2006 = 0;
   Monthly_Spend_Mar_2006 = 0;
   Monthly_Spend_Apr_2006 = 0;
   Monthly_Spend_May_2006 = 0;
   Monthly_Spend_Jun_2006 = 0;
   Monthly_Spend_Jul_2006 = 0;
   Monthly_Spend_Aug_2006 = 0;
   Monthly_Spend_Sep_2006 = 0;
   Monthly_Spend_Oct_2006 = 0;
   Monthly_Spend_Nov_2006 = 0;
   Monthly_Spend_Dec_2006 = 0;
run;

/* Calculate the sum of spend amounts for each customer for each month in 2006 */
proc sql;
   update customer_spend_2006
   set Monthly_Spend_Jan_2006 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01JAN2006'd), 0),
       Monthly_Spend_Feb_2006 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01FEB2006'd), 0),
       Monthly_Spend_Mar_2006 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01MAR2006'd), 0),
       Monthly_Spend_Apr_2006 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01APR2006'd), 0),
       Monthly_Spend_May_2006 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01MAY2006'd), 0),
       Monthly_Spend_Jun_2006 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01JUN2006'd), 0),
       Monthly_Spend_Jul_2006 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01JUL2006'd), 0),
       Monthly_Spend_Aug_2006 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01AUG2006'd), 0),
       Monthly_Spend_Sep_2006 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01SEP2006'd), 0),
       Monthly_Spend_Oct_2006 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01OCT2006'd), 0),
       Monthly_Spend_Nov_2006 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01NOV2006'd), 0),
       Monthly_Spend_Dec_2006 = coalesce((select sum(Amount)
                        from spend_clean
                        where Customer = customer_spend_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01DEC2006'd), 0);
quit;

/* Print the final table for 2006 */
proc print data=customer_spend_2006;
run;



/* Create a new table to store the results for 2006 */
data customer_repayment_2006;
   set customer_acquisition_clean (keep=Customer);
   Monthly_Repayment_Jan_2006 = 0;
   Monthly_Repayment_Feb_2006 = 0;
   Monthly_Repayment_Mar_2006 = 0;
   Monthly_Repayment_Apr_2006 = 0;
   Monthly_Repayment_May_2006 = 0;
   Monthly_Repayment_Jun_2006 = 0;
   Monthly_Repayment_Jul_2006 = 0;
   Monthly_Repayment_Aug_2006 = 0;
   Monthly_Repayment_Sep_2006 = 0;
   Monthly_Repayment_Oct_2006 = 0;
   Monthly_Repayment_Nov_2006 = 0;
   Monthly_Repayment_Dec_2006 = 0;
run;

/* Calculate the sum of repayment amounts for each customer for each month in 2006 */
proc sql;
   update customer_repayment_2006
   set Monthly_Repayment_Jan_2006 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01JAN2006'd), 0),
       Monthly_Repayment_Feb_2006 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01FEB2006'd), 0),
       Monthly_Repayment_Mar_2006 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01MAR2006'd), 0),
       Monthly_Repayment_Apr_2006 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01APR2006'd), 0),
       Monthly_Repayment_May_2006 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01MAY2006'd), 0),
       Monthly_Repayment_Jun_2006 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01JUN2006'd), 0),
       Monthly_Repayment_Jul_2006 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01JUL2006'd), 0),
       Monthly_Repayment_Aug_2006 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01AUG2006'd), 0),
       Monthly_Repayment_Sep_2006 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01SEP2006'd), 0),
       Monthly_Repayment_Oct_2006 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01OCT2006'd), 0),
       Monthly_Repayment_Nov_2006 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01NOV2006'd), 0),
       Monthly_Repayment_Dec_2006 = coalesce((select sum(Repay)
                        from repayment_clean
                        where Customer = customer_repayment_2006.Customer
                           and INTNX('MONTH', Month_date, 0) = '01DEC2006'd), 0);
quit;

/* Print the final table for 2006 */
proc print data=customer_repayment_2006;
run;





















/* Create a new table for the year 2006 to store the results with penalties and credits */
data customer_penalty_credit_2006;
   set customer_acquisition_clean (keep=Customer Age City Limit);
   set customer_spend_2006 (keep=Customer Monthly_spend_:);
   set customer_repayment_2006 (keep=Customer Monthly_repayment_:);
   
   /* Initialize penalty and credit variables */
   Penalty_Jan_2006 = 0;
   Penalty_Feb_2006 = 0;
   Penalty_Mar_2006 = 0;
   Penalty_Apr_2006 = 0;
   Penalty_May_2006 = 0;
   Penalty_Jun_2006 = 0;
   Penalty_Jul_2006 = 0;
   Penalty_Aug_2006 = 0;
   Penalty_Sep_2006 = 0;
   Penalty_Oct_2006 = 0;
   Penalty_Nov_2006 = 0;
   Penalty_Dec_2006 = 0;
   
   Credit_Jan_2006 = 0;
   Credit_Feb_2006 = 0;
   Credit_Mar_2006 = 0;
   Credit_Apr_2006 = 0;
   Credit_May_2006 = 0;
   Credit_Jun_2006 = 0;
   Credit_Jul_2006 = 0;
   Credit_Aug_2006 = 0;
   Credit_Sep_2006 = 0;
   Credit_Oct_2006 = 0;
   Credit_Nov_2006 = 0;
   Credit_Dec_2006 = 0;
   
   /* Calculate penalties for exceeding spend limit */
   if Monthly_spend_Jan_2006 > Limit then do;
      Penalty_Jan_2006 = 0.02 * Limit;
   end;
   if Monthly_spend_Feb_2006 > Limit then do;
      Penalty_Feb_2006 = 0.02 * Limit;
   end;
   if Monthly_spend_Mar_2006 > Limit then do;
      Penalty_Mar_2006 = 0.02 * Limit;
   end;
   if Monthly_spend_Apr_2006 > Limit then do;
      Penalty_Apr_2006 = 0.02 * Limit;
   end;
   if Monthly_spend_May_2006 > Limit then do;
      Penalty_May_2006 = 0.02 * Limit;
   end;
   if Monthly_spend_Jun_2006 > Limit then do;
      Penalty_Jun_2006 = 0.02 * Limit;
   end;
   if Monthly_spend_Jul_2006 > Limit then do;
      Penalty_Jul_2006 = 0.02 * Limit;
   end;
   if Monthly_spend_Aug_2006 > Limit then do;
      Penalty_Aug_2006 = 0.02 * Limit;
   end;
   if Monthly_spend_Sep_2006 > Limit then do;
      Penalty_Sep_2006 = 0.02 * Limit;
   end;
   if Monthly_spend_Oct_2006 > Limit then do;
      Penalty_Oct_2006 = 0.02 * Limit;
   end;
   if Monthly_spend_Nov_2006 > Limit then do;
      Penalty_Nov_2006 = 0.02 * Limit;
   end;
   if Monthly_spend_Dec_2006 > Limit then do;
      Penalty_Dec_2006 = 0.02 * Limit;
   end;
   
   /* Calculate credits for repayments exceeding spend */
   if Monthly_repayment_Jan_2006 > Monthly_spend_Jan_2006 then do;
      Credit_Jan_2006 = 0.02 * Limit;
   end;
   if Monthly_repayment_Feb_2006 > Monthly_spend_Feb_2006 then do;
      Credit_Feb_2006 = 0.02 * Limit;
   end;
   if Monthly_repayment_Mar_2006 > Monthly_spend_Mar_2006 then do;
      Credit_Mar_2006 = 0.02 * Limit;
   end;
   if Monthly_repayment_Apr_2006 > Monthly_spend_Apr_2006 then do;
      Credit_Apr_2006 = 0.02 * Limit;
   end;
   if Monthly_repayment_May_2006 > Monthly_spend_May_2006 then do;
      Credit_May_2006 = 0.02 * Limit;
   end;
   if Monthly_repayment_Jun_2006 > Monthly_spend_Jun_2006 then do;
      Credit_Jun_2006 = 0.02 * Limit;
   end;
   if Monthly_repayment_Jul_2006 > Monthly_spend_Jul_2006 then do;
      Credit_Jul_2006 = 0.02 * Limit;
   end;
   if Monthly_repayment_Aug_2006 > Monthly_spend_Aug_2006 then do;
      Credit_Aug_2006 = 0.02 * Limit;
   end;
   if Monthly_repayment_Sep_2006 > Monthly_spend_Sep_2006 then do;
      Credit_Sep_2006 = 0.02 * Limit;
   end;
   if Monthly_repayment_Oct_2006 > Monthly_spend_Oct_2006 then do;
      Credit_Oct_2006 = 0.02 * Limit;
   end;
   if Monthly_repayment_Nov_2006 > Monthly_spend_Nov_2006 then do;
      Credit_Nov_2006 = 0.02 * Limit;
   end;
   if Monthly_repayment_Dec_2006 > Monthly_spend_Dec_2006 then do;
      Credit_Dec_2006 = 0.02 * Limit;
   end;
   
run;

/* Print the final table with penalties and credits for 2006 */
proc print data=customer_penalty_credit_2006;
run;





proc sql;
   create table total_repayment_of_customer as
   select Customer, sum(Repay) as Total_repayment
   from repayment_clean
   group by Customer;
quit;

proc sort data=customer_acquisition_clean;
   by Customer;
run;

data total_repayment_of_customer;
   merge total_repayment_of_customer(in=dataset1)
         customer_acquisition_clean(in=dataset2 keep=Customer);
   by Customer;
   if dataset1 and dataset2;
run;



proc sort data=total_repayment_of_customer;
   by descending Total_repayment;
run;

data top_10_customer;
   set total_repayment_of_customer (obs=10);
run;

proc print data=top_10_customer noobs;
   var Customer Total_repayment;
run;



proc sql;
   create table Type_wise_spending as
   select Type, sum(Amount) as Total_Amount_Spend
   from spend_clean
   group by Type;
quit;




data categorize_spending;
   set Type_wise_spending (keep = Type Total_Amount_Spend);
   if Type in ('CAR', 'AIR TICKET', 'BIKE', 'AUTO', 'BUS TICKET', 'TRAIN TICKET') then Category = 'Travel';
   else if Type in ('RENTAL', 'FOOD', 'SHOPPING') then Category = 'Lifestyle';
   else if Type in ('CLOTHES', 'SANDALS', 'JEWELLERY') then Category = 'Fashion';
   else if Type in ('CAMERA', 'MOVIE TICKET', 'PETRO') then Category = 'Others';
   else Category = 'Unknown';
run;


proc sql;
   Create table Category_wise_spending as
   select Category, sum(Total_Amount_Spend) as Total_Amount_Spend
   from categorize_spending
   group by Category;
quit;
proc sort data=Category_wise_spending;
   by descending Total_Amount_Spend;
run;




proc sql;
   create table total_spend_of_customer as
   select Customer, sum(Amount) as Total_spend
   from spend_clean
   group by Customer;
quit;




proc sort data=customer_acquisition_clean;
   by Customer;
run;

data total_spend_of_customer;
   merge total_spend_of_customer(in=dataset1)
         customer_acquisition_clean(in=dataset2 keep=Customer Segment Age);
   by Customer;
   if dataset1 and dataset2;
run;





proc sql;
   create table segment_wise_spend as
   select Segment, sum(Total_spend) as Total_spend
   from total_spend_of_customer
   group by Segment;
quit;




proc sort data=segment_wise_spend;
   by descending Total_spend;
run;






proc sql;
   create table age_group_spend as
   select case
              when Age between 18 and 24 then '18 to 24'
              when Age between 25 and 34 then '25 to 34'
              when Age between 35 and 44 then '35 to 44'
              when Age between 45 and 54 then '45 to 54'
              when Age between 55 and 64 then '55 to 64'
              else '65 or over'
          end as Age_group,
          sum(Total_spend) as Total_amount_spend
   from total_spend_of_customer
   group by Age_group;
quit;


proc sort data=age_group_spend;
   by descending Total_amount_spend;
run;



proc sort data=age_group_spend;
   by descending Total_amount_spend;
run;


proc sort data=total_repayment_of_customer;
   by Customer;
run;

data total_spend_repayment;
   merge total_spend_of_customer(in=in1)
         total_repayment_of_customer(in=in2);
   by Customer;
   if in1 and in2;
run;










/* Calculate the sum of columns in customer_penalty_credit_2004 dataset */
proc means data=customer_penalty_credit_2004 sum;
var Penalty_Jan_2004--Penalty_Dec_2004 Credit_Jan_2004--Credit_Dec_2004;
output out=monthly_penalty_credit_2004 sum=;
run;


data monthly_penalty_credit_2004(drop=_TYPE_ _FREQ_);
   set monthly_penalty_credit_2004;
run;


data bank_profit_in_2004;
  set monthly_penalty_credit_2004;
   
   Month = "Jan";
   Penalty = Penalty_Jan_2004;
   Cashback = Credit_Jan_2004;
   Profit = Penalty_Jan_2004 - Credit_Jan_2004;
   output;

   Month = "Feb";
   Penalty = Penalty_Feb_2004;
   Cashback = Credit_Feb_2004;
   Profit = Penalty_Feb_2004 - Credit_Feb_2004;
   output;

   Month = "Mar";
   Penalty = Penalty_Mar_2004;
   Cashback = Credit_Mar_2004;
   Profit = Penalty_Mar_2004 - Credit_Mar_2004;
   output;

   Month = "Apr";
   Penalty = Penalty_Apr_2004;
   Cashback = Credit_Apr_2004;
   Profit = Penalty_Apr_2004 - Credit_Apr_2004;
   output;

   Month = "May";
   Penalty = Penalty_May_2004;
   Cashback = Credit_May_2004;
   Profit = Penalty_May_2004 - Credit_May_2004;
   output;

   Month = "Jun";
   Penalty = Penalty_Jun_2004;
   Cashback = Credit_Jun_2004;
   Profit = Penalty_Jun_2004 - Credit_Jun_2004;
   output;

   Month = "Jul";
   Penalty = Penalty_Jul_2004;
   Cashback = Credit_Jul_2004;
   Profit = Penalty_Jul_2004 - Credit_Jul_2004;
   output;

   Month = "Aug";
   Penalty = Penalty_Aug_2004;
   Cashback = Credit_Aug_2004;
   Profit = Penalty_Aug_2004 - Credit_Aug_2004;
   output;

   Month = "Sep";
   Penalty = Penalty_Sep_2004;
   Cashback = Credit_Sep_2004;
   Profit = Penalty_Sep_2004 - Credit_Sep_2004;
   output;

   Month = "Oct";
   Penalty = Penalty_Oct_2004;
   Cashback = Credit_Oct_2004;
   Profit = Penalty_Oct_2004 - Credit_Oct_2004;
   output;

   Month = "Nov";
   Penalty = Penalty_Nov_2004;
   Cashback = Credit_Nov_2004;
   Profit = Penalty_Nov_2004 - Credit_Nov_2004;
   output;

   Month = "Dec";
   Penalty = Penalty_Dec_2004;
   Cashback = Credit_Dec_2004;
   Profit = Penalty_Dec_2004 - Credit_Dec_2004;
   output;

run;

data bank_profit_in_2004(drop = 
    Penalty_Jan_2004 
    Penalty_Feb_2004 
    Penalty_Mar_2004 
    Penalty_Apr_2004 
    Penalty_May_2004 
    Penalty_Jun_2004 
    Penalty_Jul_2004 
    Penalty_Aug_2004 
    Penalty_Sep_2004 
    Penalty_Oct_2004 
    Penalty_Nov_2004 
    Penalty_Dec_2004 
    Credit_Jan_2004 
    Credit_Feb_2004 
    Credit_Mar_2004 
    Credit_Apr_2004 
    Credit_May_2004 
    Credit_Jun_2004 
    Credit_Jul_2004 
    Credit_Aug_2004 
    Credit_Sep_2004 
    Credit_Oct_2004 
    Credit_Nov_2004 
    Credit_Dec_2004);
   
   set bank_profit_in_2004;
run;













/* Calculate the sum of columns in customer_penalty_credit_2005 dataset */
proc means data=customer_penalty_credit_2005 sum;
   var Penalty_Jan_2005--Penalty_Dec_2005 Credit_Jan_2005--Credit_Dec_2005;
   output out=monthly_penalty_credit_2005 sum=;
run;

data monthly_penalty_credit_2005(drop=_TYPE_ _FREQ_);
   set monthly_penalty_credit_2005;
run;

data bank_profit_in_2005;
   set monthly_penalty_credit_2005;
   
   Month = "Jan";
   Penalty = Penalty_Jan_2005;
   Cashback = Credit_Jan_2005;
   Profit = Penalty_Jan_2005 - Credit_Jan_2005;
   output;

   Month = "Feb";
   Penalty = Penalty_Feb_2005;
   Cashback = Credit_Feb_2005;
   Profit = Penalty_Feb_2005 - Credit_Feb_2005;
   output;

   Month = "Mar";
   Penalty = Penalty_Mar_2005;
   Cashback = Credit_Mar_2005;
   Profit = Penalty_Mar_2005 - Credit_Mar_2005;
   output;

   Month = "Apr";
   Penalty = Penalty_Apr_2005;
   Cashback = Credit_Apr_2005;
   Profit = Penalty_Apr_2005 - Credit_Apr_2005;
   output;

   Month = "May";
   Penalty = Penalty_May_2005;
   Cashback = Credit_May_2005;
   Profit = Penalty_May_2005 - Credit_May_2005;
   output;

   Month = "Jun";
   Penalty = Penalty_Jun_2005;
   Cashback = Credit_Jun_2005;
   Profit = Penalty_Jun_2005 - Credit_Jun_2005;
   output;

   Month = "Jul";
   Penalty = Penalty_Jul_2005;
   Cashback = Credit_Jul_2005;
   Profit = Penalty_Jul_2005 - Credit_Jul_2005;
   output;

   Month = "Aug";
   Penalty = Penalty_Aug_2005;
   Cashback = Credit_Aug_2005;
   Profit = Penalty_Aug_2005 - Credit_Aug_2005;
   output;

   Month = "Sep";
   Penalty = Penalty_Sep_2005;
   Cashback = Credit_Sep_2005;
   Profit = Penalty_Sep_2005 - Credit_Sep_2005;
   output;

   Month = "Oct";
   Penalty = Penalty_Oct_2005;
   Cashback = Credit_Oct_2005;
   Profit = Penalty_Oct_2005 - Credit_Oct_2005;
   output;

   Month = "Nov";
   Penalty = Penalty_Nov_2005;
   Cashback = Credit_Nov_2005;
   Profit = Penalty_Nov_2005 - Credit_Nov_2005;
   output;

   Month = "Dec";
   Penalty = Penalty_Dec_2005;
   Cashback = Credit_Dec_2005;
   Profit = Penalty_Dec_2005 - Credit_Dec_2005;
   output;

run;

data bank_profit_in_2005(drop = 
    Penalty_Jan_2005 
    Penalty_Feb_2005 
    Penalty_Mar_2005 
    Penalty_Apr_2005 
    Penalty_May_2005 
    Penalty_Jun_2005 
    Penalty_Jul_2005 
    Penalty_Aug_2005 
    Penalty_Sep_2005 
    Penalty_Oct_2005 
    Penalty_Nov_2005 
    Penalty_Dec_2005 
    Credit_Jan_2005 
    Credit_Feb_2005 
    Credit_Mar_2005 
    Credit_Apr_2005 
    Credit_May_2005 
    Credit_Jun_2005 
    Credit_Jul_2005 
    Credit_Aug_2005 
    Credit_Sep_2005 
    Credit_Oct_2005 
    Credit_Nov_2005 
    Credit_Dec_2005);
   
   set bank_profit_in_2005;
run;




/* Calculate the sum of columns in customer_penalty_credit_2006 dataset */
proc means data=customer_penalty_credit_2006 sum;
   var Penalty_Jan_2006--Penalty_Dec_2006 Credit_Jan_2006--Credit_Dec_2006;
   output out=monthly_penalty_credit_2006 sum=;
run;

data monthly_penalty_credit_2006(drop=_TYPE_ _FREQ_);
   set monthly_penalty_credit_2006;
run;

data bank_profit_in_2006;
   set monthly_penalty_credit_2006;
   
   Month = "Jan";
   Penalty = Penalty_Jan_2006;
   Cashback = Credit_Jan_2006;
   Profit = Penalty_Jan_2006 - Credit_Jan_2006;
   output;

   Month = "Feb";
   Penalty = Penalty_Feb_2006;
   Cashback = Credit_Feb_2006;
   Profit = Penalty_Feb_2006 - Credit_Feb_2006;
   output;

   Month = "Mar";
   Penalty = Penalty_Mar_2006;
   Cashback = Credit_Mar_2006;
   Profit = Penalty_Mar_2006 - Credit_Mar_2006;
   output;

   Month = "Apr";
   Penalty = Penalty_Apr_2006;
   Cashback = Credit_Apr_2006;
   Profit = Penalty_Apr_2006 - Credit_Apr_2006;
   output;

   Month = "May";
   Penalty = Penalty_May_2006;
   Cashback = Credit_May_2006;
   Profit = Penalty_May_2006 - Credit_May_2006;
   output;

   Month = "Jun";
   Penalty = Penalty_Jun_2006;
   Cashback = Credit_Jun_2006;
   Profit = Penalty_Jun_2006 - Credit_Jun_2006;
   output;

   Month = "Jul";
   Penalty = Penalty_Jul_2006;
   Cashback = Credit_Jul_2006;
   Profit = Penalty_Jul_2006 - Credit_Jul_2006;
   output;

   Month = "Aug";
   Penalty = Penalty_Aug_2006;
   Cashback = Credit_Aug_2006;
   Profit = Penalty_Aug_2006 - Credit_Aug_2006;
   output;

   Month = "Sep";
   Penalty = Penalty_Sep_2006;
   Cashback = Credit_Sep_2006;
   Profit = Penalty_Sep_2006 - Credit_Sep_2006;
   output;

   Month = "Oct";
   Penalty = Penalty_Oct_2006;
   Cashback = Credit_Oct_2006;
   Profit = Penalty_Oct_2006 - Credit_Oct_2006;
   output;

   Month = "Nov";
   Penalty = Penalty_Nov_2006;
   Cashback = Credit_Nov_2006;
   Profit = Penalty_Nov_2006 - Credit_Nov_2006;
   output;

   Month = "Dec";
   Penalty = Penalty_Dec_2006;
   Cashback = Credit_Dec_2006;
   Profit = Penalty_Dec_2006 - Credit_Dec_2006;
   output;

run;

data bank_profit_in_2006(drop = 
    Penalty_Jan_2006 
    Penalty_Feb_2006 
    Penalty_Mar_2006 
    Penalty_Apr_2006 
    Penalty_May_2006 
    Penalty_Jun_2006 
    Penalty_Jul_2006 
    Penalty_Aug_2006 
    Penalty_Sep_2006 
    Penalty_Oct_2006 
    Penalty_Nov_2006 
    Penalty_Dec_2006 
    Credit_Jan_2006 
    Credit_Feb_2006 
    Credit_Mar_2006 
    Credit_Apr_2006 
    Credit_May_2006 
    Credit_Jun_2006 
    Credit_Jul_2006 
    Credit_Aug_2006 
    Credit_Sep_2006 
    Credit_Oct_2006 
    Credit_Nov_2006 
    Credit_Dec_2006);
   
   set bank_profit_in_2006;
run;






































data interest_cashback_2004;
   set customer_acquisition_clean (keep=Customer Limit);
   set customer_spend_2004 (keep=Customer Monthly_spend_:);
   set customer_repayment_2004 (keep=Customer Monthly_repayment_:);
   
   Jan_due_2004 = Monthly_spend_Jan_2004 - Monthly_repayment_Jan_2004;
   Feb_due_2004 = Monthly_spend_Feb_2004 - Monthly_repayment_Feb_2004;
   Mar_due_2004 = Monthly_spend_Mar_2004 - Monthly_repayment_Mar_2004;
   Apr_due_2004 = Monthly_spend_Apr_2004 - Monthly_repayment_Apr_2004;
   May_due_2004 = Monthly_spend_May_2004 - Monthly_repayment_May_2004;
   Jun_due_2004 = Monthly_spend_Jun_2004 - Monthly_repayment_Jun_2004;
   Jul_due_2004 = Monthly_spend_Jul_2004 - Monthly_repayment_Jul_2004;
   Aug_due_2004 = Monthly_spend_Aug_2004 - Monthly_repayment_Aug_2004;
   Sep_due_2004 = Monthly_spend_Sep_2004 - Monthly_repayment_Sep_2004;
   Oct_due_2004 = Monthly_spend_Oct_2004 - Monthly_repayment_Oct_2004;
   Nov_due_2004 = Monthly_spend_Nov_2004 - Monthly_repayment_Nov_2004;
   Dec_due_2004 = Monthly_spend_Dec_2004 - Monthly_repayment_Dec_2004;

   
   /* Initialize penalty and credit variables */
  Interest_Jan_2004 = 0;
   Interest_Feb_2004 = 0;
   Interest_Mar_2004 = 0;
   Interest_Apr_2004 = 0;
   Interest_May_2004 = 0;
   Interest_Jun_2004 = 0;
   Interest_Jul_2004 = 0;
   Interest_Aug_2004 = 0;
   Interest_Sep_2004 = 0;
   Interest_Oct_2004 = 0;
   Interest_Nov_2004 = 0;
   Interest_Dec_2004 = 0;
   
   Cashback_Jan_2004 = 0;
   Cashback_Feb_2004 = 0;
   Cashback_Mar_2004 = 0;
   Cashback_Apr_2004 = 0;
   Cashback_May_2004 = 0;
   Cashback_Jun_2004 = 0;
   Cashback_Jul_2004 = 0;
   Cashback_Aug_2004 = 0;
   Cashback_Sep_2004 = 0;
   Cashback_Oct_2004 = 0;
   Cashback_Nov_2004 = 0;
   Cashback_Dec_2004 = 0;
   
 if Jan_due_2004 > 0 then do;
      Interest_Jan_2004 = 0.029 * Jan_due_2004;
   end;
   if Feb_due_2004 > 0 then do;
      Interest_Feb_2004 = 0.029 * Feb_due_2004;
   end;
   if Mar_due_2004 > 0  then do;
      Interest_Mar_2004 = 0.029 * Mar_due_2004;
   end;
   if Apr_due_2004 > 0  then do;
      Interest_Apr_2004 = 0.029 * Apr_due_2004;
   end;
   if May_due_2004 > 0  then do;
      Interest_May_2004 = 0.029 * May_due_2004;
   end;
   if Jun_due_2004 > 0  then do;
      Interest_Jun_2004 = 0.029 * Jun_due_2004;
   end;
   if Jul_due_2004 > 0  then do;
      Interest_Jul_2004 = 0.029 * Jul_due_2004;
   end;
   if Aug_due_2004 > 0  then do;
      Interest_Aug_2004 = 0.029 * Aug_due_2004;
   end;
   if Sep_due_2004 > 0  then do;
      Interest_Sep_2004 = 0.029 * Sep_due_2004;
   end;
   if Oct_due_2004 > 0  then do;
      Interest_Oct_2004 = 0.029 * Oct_due_2004;
   end;
 
   if Nov_due_2004 > 0  then do;
      Interest_Nov_2004 = 0.029 * Nov_due_2004;
   end;
   if Dec_due_2004 > 0  then do;
      Interest_Dec_2004 = 0.029 * Dec_due_2004;
   end;
   
   if Jan_due_2004 < 0 then do;
      Cashback_Jan_2004 = 0.02 * Limit;
   end;
   if Feb_due_2004 < 0 then do;
      Cashback_Feb_2004 = 0.02 * Limit;
   end;
   if Mar_due_2004 < 0 then do;
      Cashback_Mar_2004 = 0.02 * Limit;
   end;
   if Apr_due_2004 < 0 then do;
      Cashback_Apr_2004 = 0.02 * Limit;
   end;
   if May_due_2004 < 0 then do;
      Cashback_May_2004 = 0.02 * Limit;
   end;
   if Jun_due_2004 < 0 then do;
      Cashback_Jun_2004 = 0.02 * Limit;
   end;
   if Jul_due_2004 < 0 then do;
      Cashback_Jul_2004 = 0.02 * Limit;
   end;
   if Aug_due_2004 < 0 then do;
      Cashback_Aug_2004 = 0.02 * Limit;
   end;
   if Sep_due_2004 < 0 then do;
      Cashback_Sep_2004 = 0.02 * Limit;
   end;
   if Oct_due_2004 < 0 then do;
      Cashback_Oct_2004 = 0.02 * Limit;
   end;
   if Nov_due_2004 < 0 then do;
      Cashback_Nov_2004 = 0.02 * Limit;
   end;
   if Dec_due_2004 < 0 then do;
      Cashback_Dec_2004 = 0.02 * Limit;
   end;
   
run;
/* Print the final table with penalties and credits for 2004 */
proc print data=interest_cashback_2004;
run;



 
data interest_cashback_2004(drop = Monthly_spend_: Monthly_repayment: Limit);
    
    
    
   
   set interest_cashback_2004;
run;

























data interest_cashback_2005;
   set customer_acquisition_clean (keep=Customer Limit);
   set customer_spend_2005 (keep=Customer Monthly_spend_:);
   set customer_repayment_2005 (keep=Customer Monthly_repayment_:);
   
   Jan_due_2005 = Monthly_spend_Jan_2005 - Monthly_repayment_Jan_2005;
   Feb_due_2005 = Monthly_spend_Feb_2005 - Monthly_repayment_Feb_2005;
   Mar_due_2005 = Monthly_spend_Mar_2005 - Monthly_repayment_Mar_2005;
   Apr_due_2005 = Monthly_spend_Apr_2005 - Monthly_repayment_Apr_2005;
   May_due_2005 = Monthly_spend_May_2005 - Monthly_repayment_May_2005;
   Jun_due_2005 = Monthly_spend_Jun_2005 - Monthly_repayment_Jun_2005;
   Jul_due_2005 = Monthly_spend_Jul_2005 - Monthly_repayment_Jul_2005;
   Aug_due_2005 = Monthly_spend_Aug_2005 - Monthly_repayment_Aug_2005;
   Sep_due_2005 = Monthly_spend_Sep_2005 - Monthly_repayment_Sep_2005;
   Oct_due_2005 = Monthly_spend_Oct_2005 - Monthly_repayment_Oct_2005;
   Nov_due_2005 = Monthly_spend_Nov_2005 - Monthly_repayment_Nov_2005;
   Dec_due_2005 = Monthly_spend_Dec_2005 - Monthly_repayment_Dec_2005;

   /* Initialize interest and cashback variables */
   Interest_Jan_2005 = 0;
   Interest_Feb_2005 = 0;
   Interest_Mar_2005 = 0;
   Interest_Apr_2005 = 0;
   Interest_May_2005 = 0;
   Interest_Jun_2005 = 0;
   Interest_Jul_2005 = 0;
   Interest_Aug_2005 = 0;
   Interest_Sep_2005 = 0;
   Interest_Oct_2005 = 0;
   Interest_Nov_2005 = 0;
   Interest_Dec_2005 = 0;
   
   Cashback_Jan_2005 = 0;
   Cashback_Feb_2005 = 0;
   Cashback_Mar_2005 = 0;
   Cashback_Apr_2005 = 0;
   Cashback_May_2005 = 0;
   Cashback_Jun_2005 = 0;
   Cashback_Jul_2005 = 0;
   Cashback_Aug_2005 = 0;
   Cashback_Sep_2005 = 0;
   Cashback_Oct_2005 = 0;
   Cashback_Nov_2005 = 0;
   Cashback_Dec_2005 = 0;
   
   if Jan_due_2005 > 0 then do;
      Interest_Jan_2005 = 0.029 * Jan_due_2005;
   end;
   if Feb_due_2005 > 0 then do;
      Interest_Feb_2005 = 0.029 * Feb_due_2005;
   end;
   if Mar_due_2005 > 0 then do;
      Interest_Mar_2005 = 0.029 * Mar_due_2005;
   end;
   if Apr_due_2005 > 0 then do;
      Interest_Apr_2005 = 0.029 * Apr_due_2005;
   end;
   if May_due_2005 > 0 then do;
      Interest_May_2005 = 0.029 * May_due_2005;
   end;
   if Jun_due_2005 > 0 then do;
      Interest_Jun_2005 = 0.029 * Jun_due_2005;
   end;
   if Jul_due_2005 > 0 then do;
      Interest_Jul_2005 = 0.029 * Jul_due_2005;
   end;
   if Aug_due_2005 > 0 then do;
      Interest_Aug_2005 = 0.029 * Aug_due_2005;
   end;
   if Sep_due_2005 > 0 then do;
      Interest_Sep_2005 = 0.029 * Sep_due_2005;
   end;
   if Oct_due_2005 > 0 then do;
      Interest_Oct_2005 = 0.029 * Oct_due_2005;
   end;
   if Nov_due_2005 > 0 then do;
      Interest_Nov_2005 = 0.029 * Nov_due_2005;
   end;
   if Dec_due_2005 > 0 then do;
      Interest_Dec_2005 = 0.029 * Dec_due_2005;
   end;
   
   if Jan_due_2005 < 0 then do;
      Cashback_Jan_2005 = 0.02 * Limit;
   end;
   if Feb_due_2005 < 0 then do;
      Cashback_Feb_2005 = 0.02 * Limit;
   end;
   if Mar_due_2005 < 0 then do;
      Cashback_Mar_2005 = 0.02 * Limit;
   end;
   if Apr_due_2005 < 0 then do;
      Cashback_Apr_2005 = 0.02 * Limit;
   end;
   if May_due_2005 < 0 then do;
      Cashback_May_2005 = 0.02 * Limit;
   end;
   if Jun_due_2005 < 0 then do;
      Cashback_Jun_2005 = 0.02 * Limit;
   end;
   if Jul_due_2005 < 0 then do;
      Cashback_Jul_2005 = 0.02 * Limit;
   end;
   if Aug_due_2005 < 0 then do;
      Cashback_Aug_2005 = 0.02 * Limit;
   end;
   if Sep_due_2005 < 0 then do;
      Cashback_Sep_2005 = 0.02 * Limit;
   end;
   if Oct_due_2005 < 0 then do;
      Cashback_Oct_2005 = 0.02 * Limit;
   end;
   if Nov_due_2005 < 0 then do;
      Cashback_Nov_2005 = 0.02 * Limit;
   end;
   if Dec_due_2005 < 0 then do;
      Cashback_Dec_2005 = 0.02 * Limit;
   end;
   
   drop Monthly_spend_: Monthly_repayment_: Limit;
run;

/* Print the final table with penalties and credits for 2005 */
proc print data=interest_cashback_2005;
run;










data interest_cashback_2006(drop = Monthly_spend_: Monthly_repayment_: Limit);
   set customer_acquisition_clean (keep=Customer Limit);
   set customer_spend_2006 (keep=Customer Monthly_spend_:);
   set customer_repayment_2006 (keep=Customer Monthly_repayment_:);
   
   Jan_due_2006 = Monthly_spend_Jan_2006 - Monthly_repayment_Jan_2006;
   Feb_due_2006 = Monthly_spend_Feb_2006 - Monthly_repayment_Feb_2006;
   Mar_due_2006 = Monthly_spend_Mar_2006 - Monthly_repayment_Mar_2006;
   Apr_due_2006 = Monthly_spend_Apr_2006 - Monthly_repayment_Apr_2006;
   May_due_2006 = Monthly_spend_May_2006 - Monthly_repayment_May_2006;
   Jun_due_2006 = Monthly_spend_Jun_2006 - Monthly_repayment_Jun_2006;
   Jul_due_2006 = Monthly_spend_Jul_2006 - Monthly_repayment_Jul_2006;
   Aug_due_2006 = Monthly_spend_Aug_2006 - Monthly_repayment_Aug_2006;
   Sep_due_2006 = Monthly_spend_Sep_2006 - Monthly_repayment_Sep_2006;
   Oct_due_2006 = Monthly_spend_Oct_2006 - Monthly_repayment_Oct_2006;
   Nov_due_2006 = Monthly_spend_Nov_2006 - Monthly_repayment_Nov_2006;
   Dec_due_2006 = Monthly_spend_Dec_2006 - Monthly_repayment_Dec_2006;

   /* Initialize interest and cashback variables */
   Interest_Jan_2006 = 0;
   Interest_Feb_2006 = 0;
   Interest_Mar_2006 = 0;
   Interest_Apr_2006 = 0;
   Interest_May_2006 = 0;
   Interest_Jun_2006 = 0;
   Interest_Jul_2006 = 0;
   Interest_Aug_2006 = 0;
   Interest_Sep_2006 = 0;
   Interest_Oct_2006 = 0;
   Interest_Nov_2006 = 0;
   Interest_Dec_2006 = 0;
   
   Cashback_Jan_2006 = 0;
   Cashback_Feb_2006 = 0;
   Cashback_Mar_2006 = 0;
   Cashback_Apr_2006 = 0;
   Cashback_May_2006 = 0;
   Cashback_Jun_2006 = 0;
   Cashback_Jul_2006 = 0;
   Cashback_Aug_2006 = 0;
   Cashback_Sep_2006 = 0;
   Cashback_Oct_2006 = 0;
   Cashback_Nov_2006 = 0;
   Cashback_Dec_2006 = 0;
   
   if Jan_due_2006 > 0 then do;
      Interest_Jan_2006 = 0.029 * Jan_due_2006;
   end;
   if Feb_due_2006 > 0 then do;
      Interest_Feb_2006 = 0.029 * Feb_due_2006;
   end;
   if Mar_due_2006 > 0 then do;
      Interest_Mar_2006 = 0.029 * Mar_due_2006;
   end;
   if Apr_due_2006 > 0 then do;
      Interest_Apr_2006 = 0.029 * Apr_due_2006;
   end;
   if May_due_2006 > 0 then do;
      Interest_May_2006 = 0.029 * May_due_2006;
   end;
   if Jun_due_2006 > 0 then do;
      Interest_Jun_2006 = 0.029 * Jun_due_2006;
   end;
   if Jul_due_2006 > 0 then do;
      Interest_Jul_2006 = 0.029 * Jul_due_2006;
   end;
   if Aug_due_2006 > 0 then do;
      Interest_Aug_2006 = 0.029 * Aug_due_2006;
   end;
   if Sep_due_2006 > 0 then do;
      Interest_Sep_2006 = 0.029 * Sep_due_2006;
   end;
   if Oct_due_2006 > 0 then do;
      Interest_Oct_2006 = 0.029 * Oct_due_2006;
   end;
   if Nov_due_2006 > 0 then do;
      Interest_Nov_2006 = 0.029 * Nov_due_2006;
   end;
   if Dec_due_2006 > 0 then do;
      Interest_Dec_2006 = 0.029 * Dec_due_2006;
   end;
   
   if Jan_due_2006 < 0 then do;
      Cashback_Jan_2006 = 0.02 * Limit;
   end;
   if Feb_due_2006 < 0 then do;
      Cashback_Feb_2006 = 0.02 * Limit;
   end;
   if Mar_due_2006 < 0 then do;
      Cashback_Mar_2006 = 0.02 * Limit;
   end;
   if Apr_due_2006 < 0 then do;
      Cashback_Apr_2006 = 0.02 * Limit;
   end;
   if May_due_2006 < 0 then do;
      Cashback_May_2006 = 0.02 * Limit;
   end;
   if Jun_due_2006 < 0 then do;
      Cashback_Jun_2006 = 0.02 * Limit;
   end;
   if Jul_due_2006 < 0 then do;
      Cashback_Jul_2006 = 0.02 * Limit;
   end;
   if Aug_due_2006 < 0 then do;
      Cashback_Aug_2006 = 0.02 * Limit;
   end;
   if Sep_due_2006 < 0 then do;
      Cashback_Sep_2006 = 0.02 * Limit;
   end;
   if Oct_due_2006 < 0 then do;
      Cashback_Oct_2006 = 0.02 * Limit;
   end;
   if Nov_due_2006 < 0 then do;
      Cashback_Nov_2006 = 0.02 * Limit;
   end;
   if Dec_due_2006 < 0 then do;
      Cashback_Dec_2006 = 0.02 * Limit;
   end;

run;

/* Print the final table with penalties and credits for 2006 */
proc print data=interest_cashback_2006;
run;

