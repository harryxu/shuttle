package cn.geckos.shuttle.controllers
{
import cn.geckos.shuttle.models.FlickrServiceProxy;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

public class GetFlickrAuthTokenCommand extends SimpleCommand
{
    override public function execute(notification:INotification):void
    {
        FlickrServiceProxy(facade.retrieveProxy(FlickrServiceProxy.NAME)).getToken();
    }
}
}
