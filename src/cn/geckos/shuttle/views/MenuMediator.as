package cn.geckos.shuttle.views
{
import cn.geckos.shuttle.views.components.AboutWindow;

import flash.display.NativeMenu;
import flash.display.NativeMenuItem;
import flash.events.Event;

import mx.core.IFlexDisplayObject;
import mx.core.WindowedApplication;
import mx.managers.PopUpManager;

import org.puremvc.as3.patterns.mediator.Mediator;

public class MenuMediator extends Mediator
{
    public static const NAME:String = 'MenuMediator';
    
    public function get app():WindowedApplication
    {
        return this.viewComponent as WindowedApplication;
    }
    
    public function MenuMediator(mediatorName:String=null, viewComponent:Object=null)
    {
        super(mediatorName, viewComponent);
        
        initMenu();
    }
    
    
    protected function initMenu():void
    {
        // root
        var root:NativeMenu = new NativeMenu();
        app.nativeWindow.menu = root;
        
        // File
        var fileItem:NativeMenuItem = new NativeMenuItem('File');
        fileItem.submenu = new NativeMenu();
        
        root.addItem(fileItem);
        
        // Help
        var helpItem:NativeMenuItem = new NativeMenuItem('Help');
        helpItem.submenu = new NativeMenu();
            var about:NativeMenuItem = new NativeMenuItem('About Shuttle');
            about.addEventListener(Event.SELECT, helpSelectHandler);
            helpItem.submenu.addItem(about);
            
        root.addItem(helpItem);
        
    }
    
    
    private function helpSelectHandler(event:Event):void
    {
        var display:IFlexDisplayObject = new AboutWindow();
        PopUpManager.addPopUp(display, app, true);
        PopUpManager.centerPopUp(display);
    }
        
}
}