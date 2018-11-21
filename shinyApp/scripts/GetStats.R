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
  Stats = list(Avg,Slg)
  return(Stats)
  
    
}



'MookieTest= MookieTest$PLAY_OUTCOME
Single = sum(MookieTest == "Single")
Double = sum(MookieTest == "Double")
Triple = sum(MookieTest == "Triple")
HomeRun = sum(MookieTest == "HomeRun")
Sacrifice = sum(MookieTest == "Sacrifice")
Out = sum(MookieTest == "Out")
PA = length(MookieTest)
Avg = (Single + Double + Triple + HomeRun)/(PA - Sacrifice)
Slg = (Single + 2*Double + 3*Triple + 4*HomeRun)/(PA)
Stats = c(Avg,Slg)
