package cn.geckos.shuttle.controllers
{
import cn.geckos.shuttle.managers.AccountsManager;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

public class DeleteAccountCommand extends SimpleCommand
{
    override public function execute(notification:INotification):void
    {
        var user:Object = notification.getBody();
        AccountsManager.getInstance().deleteAccount(user.id, user.service);
    }
        
}
}
