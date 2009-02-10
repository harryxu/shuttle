package cn.geckos.airup.controllers
{
import cn.geckos.airup.Notices;
import cn.geckos.airup.managers.AccountsManager;
import cn.geckos.airup.models.FlickrServiceProxy;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

public class AuthDefaultAccountCommand extends SimpleCommand
{
    override public function execute(notification:INotification):void
    {
        var account:XML = AccountsManager.getInstance().getDefaultAccount();
        
        if( !account ) {
            sendNotification(Notices.NO_DEFAULT_ACCOUNT);
        }
        else {
            var proxy:FlickrServiceProxy = facade.retrieveProxy(FlickrServiceProxy.NAME) as FlickrServiceProxy;
            proxy.auth(account.id.toString());
        }
        
    }
}
}