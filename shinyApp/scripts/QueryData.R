# This function queries the Batted Ball Dataset according to the users input
QueryData = function(SpinRateMin,SpinRateMax,LaunchAngleMin,LaunchAngleMax,SelectedBatter){
                       
                Data = BattedBallData_[BattedBallData_$HIT_SPIN_RATE >= SpinRateMin & BattedBallData_$HIT_SPIN_RATE <= SpinRateMax &
                       BattedBallData_$LAUNCH_ANGLE >= LaunchAngleMin & BattedBallData_$LAUNCH_ANGLE <= LaunchAngleMax &
                       BattedBallData_$BATTER == SelectedBatter,]


  

}



     
