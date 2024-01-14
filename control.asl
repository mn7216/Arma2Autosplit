state("Arma2OA")
{
    int hasControl: 0xA7AE10; // Memory address for player control. 1 = yes, 0 = no
    int missionComplete: 0xADC058; // Memory address for mission complete. 1 = mission complete, remains 1 until new mission.
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