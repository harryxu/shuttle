package cn.geckos.shuttle.property
{
import flash.display.DisplayObject;
import flash.events.Event;

import mx.controls.CheckBox;

public class BooleanEditor extends BasePropertyEditor
{
    public function BooleanEditor(display:DisplayObject)
    {
        super(display);
        CheckBox(display).addEventListener(Event.CHANGE, applyHandler);
    }
    
    override public function applyProperty():void
    {
        model.value = CheckBox(display).selected;
    }
    
    override public function bindTo(model:IPropertyModel):void
    {
        super.bindTo(model);
        
        CheckBox(display).selected = Boolean(model.value);
    }
        
}
}
