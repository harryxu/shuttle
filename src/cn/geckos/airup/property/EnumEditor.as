package cn.geckos.airup.property
{
import flash.events.Event;

import mx.controls.RadioButtonGroup;
    
public class EnumEditor extends BasePropertyEditor
{
    public function EnumEditor(display:Object)
    {
        super(display);
        
        RadioButtonGroup(display).addEventListener(Event.CHANGE, applyHandler);
    }
    
    override public function applyProperty():void
    {
        model.value = RadioButtonGroup(display).selectedValue;
    }
    
    override public function bindTo(model:IPropertyModel):void
    {
        super.bindTo(model);
        
        RadioButtonGroup(display).selectedValue = model.value;
    }
        
}
}