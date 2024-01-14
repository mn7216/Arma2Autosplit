state("Arma2OA")
{
    int hasControl: 0xA7AE10; // Memory address for player control. 1 = yes, 0 = no
    int missionComplete: 0xADC058; // Memory address for mission complete. 1 = mission complete, remains 1 until new mission.
	int isLoading: 0x4C9F30, 0x48; // Memory address for loading state.  1 = loading, 0 = not loading
    //int currentMission1: 0x3D9C7C, 0x4;
	//int currentMission2: 0x51A184, 0x20; //Scuffed workaround for now
}

startup
{
    vars.timerModel = new TimerModel { CurrentState = timer };
    vars.isTimerPaused = false; // Initialize pause state flag
}

update
{
    if (current.isLoading == 1 && !vars.isTimerPaused) {
        vars.timerModel.Pause(); // Pause timer
        vars.isTimerPaused = true;
    }
    else if (current.isLoading == 0 && vars.isTimerPaused) {
        vars.timerModel.Pause(); // Unpause timer
        vars.isTimerPaused = false;
    }
}


isLoading {
  return current.isLoading == 1;
}
start
{
    // Start the timer when the player gains control
    return current.hasControl > 0;
}

split
{
    // Trigger a split upon missionComplete = 1
    if (current.missionComplete == 1 && old.missionComplete == 0) {
        return true;
    }
    return false;
}


