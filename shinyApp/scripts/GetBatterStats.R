# This function returns Batting Avg and Slg % from the PlayOutcome column
GetStats = function(Data){
  Single = sum(Data == "Single")
  Double = sum(Data == "Double")
  Triple = sum(Data == "Triple")
  HomeRun = sum(Data == "HomeRun")
  Sacrifice = sum(Data == "Sacrifice")
  Out = sum(Data == "Out")
  PA = length(Data)
  Avg = (Single + Double + Triple + HomeRun)/(PA - Sacrifice)
  Slg = (Single + 2*Double + 3*Triple + 1*HomeRun)/(PA)
  Stats = c(Avg,Slg)
  return(Stats)
  
    
}



