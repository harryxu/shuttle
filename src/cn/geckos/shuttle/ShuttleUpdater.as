package cn.geckos.shuttle
{
import air.update.ApplicationUpdaterUI;

import flash.filesystem.File;
    
public final class ShuttleUpdater
{
    
    private static var updaterUI:ApplicationUpdaterUI;
    
    public static function get currentVersion():String
    {
        initialize();
        return updaterUI.currentVersion;
    }
	
	public static function initialize():void
	{
	    if (!updaterUI)
	    {
	        updaterUI = new ApplicationUpdaterUI();
	        updaterUI.configurationFile = new File('app:/updateConfig.xml');
		    updaterUI.initialize();
	    }
	}
	
	public static function checkNow():void
	{
	    initialize();
	    updaterUI.isCheckForUpdateVisible = true;
	    updaterUI.checkNow();
	}
	
	
	
    

}
}