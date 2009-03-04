package cn.geckos.airup.property
{
import flash.display.DisplayObject;
import flash.events.Event;

public class BasePropertyEditor implements IPropertyEditor
{
    protected var model:IPropertyModel;
    protected var display:DisplayObject;
    
    public function BasePropertyEditor(display:DisplayObject)
    {
        this.display = display;
    }
    
    public function get display():DisplayObject
    {
        return display;
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