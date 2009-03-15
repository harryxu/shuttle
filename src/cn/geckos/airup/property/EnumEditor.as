package cn.geckos.airup.property
{
import flash.events.Event;

import mx.controls.RadioButtonGroup;
import mx.controls.listClasses.ListBase;
import mx.core.UIComponent;
    
public class EnumEditor extends BasePropertyEditor
{
    public function EnumEditor(display:Object)
    {
        super(display);
        
        UIComponent(display).addEventListener(Event.CHANGE, applyHandler);
    }
    
    override public function applyProperty():void
    {
        if( display is RadioButtonGroup ) {
	        model.value = RadioButtonGroup(display).selectedValue;
        }
        else if( display is ListBase ) {
            model.value = ListBase(display).selectedItem.value;
        }
    }
    
    override public function bindTo(model:IPropertyModel):void
    {
        super.bindTo(model);
        
        if( display is RadioButtonGroup ) {
	        RadioButtonGroup(display).selectedValue = model.value;
        }
    }
        
}
}