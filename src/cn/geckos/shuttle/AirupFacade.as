package cn.geckos.shuttle
{
import cn.geckos.shuttle.controllers.StartupCommand;

import org.puremvc.as3.patterns.facade.Facade;
import org.puremvc.as3.patterns.observer.Notification;

public class AirupFacade extends Facade
{
    public static const STARTUP:String = 'startup';
    
    
    private static var instance:AirupFacade;
    
    public static function getInstance():AirupFacade
    {
        if( !instance ) {
            instance = new AirupFacade();
        }
        return instance;
    }
    
    
    override protected function initializeController():void
    {
        super.initializeController();
        
        registerCommand(STARTUP, StartupCommand);
    }
    
    public function startup(app:Shuttle):void
    {
        notifyObservers( new Notification(STARTUP, app) );
    }
    
}
}