kippo-bash
==========

Analysis of kippo logs - text files

This is a bash script to analyze kippo text based logs. It needs neither MySQL nor Apache like the popular web based tools for generating these statistics.

Prerequisites
-------------
If you want to generate graphs gnuplot is required.


        sudo apt-get install gnuplot


Configuration
--------------
Set the right path for the kippo logs in the script


Execution
---------
Execute kippo-bash.sh


        ./kippo-bash.sh 
        [####################] (100%) - analysis completed.
         
        Total
        - attempts: 116885
          + succeeded : 487
          + failed :  116398         

        Total unique 
        - usernames: 1644 
        - passwords: 24498
        - combinations: 84596
        - IPs:       184
         
        Menu
        1) Show complete stats	3) Store lists
        2) Generate graphs	4) Quit
        Pick an option: 


![My image](https://raw.github.com/rwmanos/kippo-bash/master/TOPusernames.png)

Known issues
------------
If the username contains the special character slash '/', whatever is after this character is considered to be part of the password.


License
-------
This is free and unencumbered software released into the public domain.
