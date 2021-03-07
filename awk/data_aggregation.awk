BEGIN{   
    FS=","
    low=9999999999
    high=0
    avgE=0
    avgW=0
}

NR > 1 {
    avgE = avgE + ($3+0)
    avgW = avgW + ($4+0)
    if ($3 < 0+low)
        low = $3
    if ($3 > 0+high)
        high = $3
}

END{
    print"Average earnings: " avgE / (NR-1)
    print"Average withholding: " avgW / (NR-1)
    print"Lowest earnings " low
    print"Highest earnings " high 
}