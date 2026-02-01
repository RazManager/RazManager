namespace RazManager.IO.Services.ChronoLog
{
    public enum OxigenRxCarReset
    {
        carPowerSupplyHasntChanged,
        carHasJustBeenPoweredUpOrReset // (info available for 2 seconds)
    }

    public enum OxigenRxControllerCarLink
    {
        controllerLinkWithItsPairedCarHasntChanged,
        controllerHasJustGotTheLinkWithItsPairedCar // (info available for2 seconds) (e.g.:link dropped and restarted)
    }

    public enum OxigenRxControllerBatteryLevel { ok, low }

    public enum OxigenRxTrackCall
    {
        no,
        yes // (info available for 2 seconds)
    }

    public enum OxigenRxArrowUpButton { buttonNotPressed, buttonPressed }

    public enum OxigenRxArrowDownButton { buttonNotPressed, buttonPressed }

    public enum OxigenRxRoundButton { buttonNotPressed, buttonPressed }

    public enum OxigenRxCarOnTrack
    {
        carIsNotOnTheTrack,
        carIsOnTheTrack // Info available only if the paired controller is powered up
    }

    public enum OxigenShortLap { noShortLap, shortLap }

    public enum OxigenRxCarPitLane { carIsNotInThePitLane, carIsInThePitLane }

    public enum OxigenRxDeviceSoftwareReleaseOwner { controllerSoftwareRelease, carSoftwareRelease }
}
