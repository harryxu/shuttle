package cn.geckos.shuttle.property
{
import flash.events.Event;

public class BasePropertyEditor implements IPropertyEditor
{
    protected var model:IPropertyModel;
    protected var _display:Object;
    
    public function BasePropertyEditor(display:Object)
    {
        _display = display;
    }
    
    public function get display():Object
    {
        return _display;
    }
        
    public function applyProperty():void
    {
        // implements by subclass
    }
        
    public function bindTo(model:IPropertyModel):void
    {
        this.model = model;
    }
    
    protected function applyHandler(event:Event):void
    {
        applyProperty();
    }
        
}
}
