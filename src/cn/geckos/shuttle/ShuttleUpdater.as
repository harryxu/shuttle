package cn.geckos.shuttle
{
import air.update.ApplicationUpdaterUI;
import air.update.events.UpdateEvent;

import flash.filesystem.File;
    
public final class ShuttleUpdater
{
	
	public static function check():void
	{
        var updater:ApplicationUpdaterUI = new ApplicationUpdaterUI();
        updater.configurationFile = new File('app:/updateConfig.xml');
        
        updater.addEventListener(UpdateEvent.CHECK_FOR_UPDATE, checkUpdateHandler);
	    
	    //updater.initialize();
	    updater.checkNow();
	}
	
    public static function checkUpdateHandler(event:UpdateEvent):void
    {
        trace('check update');
    }
	
    public function ShuttleUpdater()
    {
        throw new Error('static class!');
    }
    

}
}