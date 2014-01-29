kippo-bash
==========

Analysis of kippo logs - text files

This is a bash script to analyze kippo text based logs. It needs neither MySQL nor Apache like the popular web based tools for generating these statistics.

1. If you want to generate graphs gnuplot is required.


    sudo apt-get install gnuplot

2. Set the right path for the kippo logs in the script

3. Execute kippo-bash.sh


    $ ./kippo-bash.sh 
    [####################] (100%) - analysis completed.
     
    Total
      - attempts: 116885
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
