state("Arma2OA")
{
    int hasControl: 0x07570C, 0x128; // Memory address for player control. 1 = yes, 0 = no
    int missionComplete: 0xAE1318, 0x18; // Memory address for mission complete. 1 = mission complete, remains 1 until new mission.
	//int currentMission1: 0x3D9C7C, 0x4;
	//int currentMission2: 0x51A184, 0x20; //Scuffed workaround for now
}

init
{
    // Initialize any necessary variables or states
}

start
{
    // Start the timer when the player gains control
    return current.hasControl > 0;
}

split
{
    // Trigger a split when mission completes
    // Ensure it doesn't trigger repeatedly if missionComplete stays at 1
    if (current.missionComplete == 1 && old.missionComplete == 0) {
        return true;
    }
    return false;
}