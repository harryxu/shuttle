package cn.geckos.shuttle.controllers
{
import cn.geckos.shuttle.Notices;
import cn.geckos.shuttle.managers.AccountsManager;
import cn.geckos.shuttle.models.FlickrServiceProxy;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

public class AuthDefaultAccountCommand extends SimpleCommand
{
    override public function execute(notification:INotification):void
    {
        var account:XML = AccountsManager.getInstance().getDefaultAccount();
        
        if( !account )
        {
            sendNotification(Notices.NO_DEFAULT_ACCOUNT);
        }
        else 
        {
            sendNotification(Notices.BEFORE_AUTH);
            var proxy:FlickrServiceProxy = facade.retrieveProxy(FlickrServiceProxy.NAME) as FlickrServiceProxy;
            proxy.auth(account.@id.toString());
        }
        
    }
}
}
