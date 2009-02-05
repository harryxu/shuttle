package cn.geckos.airup.controllers
{
import cn.geckos.airup.models.FlickrAuthProxy;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

public class GetFlickrAuthTokenCommand extends SimpleCommand
{
    override public function execute(notification:INotification):void
    {
        FlickrAuthProxy(facade.retrieveProxy(FlickrAuthProxy.NAME)).getToken();
    }
}
}