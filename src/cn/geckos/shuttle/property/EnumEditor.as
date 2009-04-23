package cn.geckos.shuttle.property
{
import flash.events.Event;
import flash.events.EventDispatcher;

import mx.controls.ComboBase;
import mx.controls.RadioButtonGroup;
    
public class EnumEditor extends BasePropertyEditor
{
    public function EnumEditor(display:Object)
    {
        super(display);
        
        if( display is EventDispatcher ) {
	        display.addEventListener(Event.CHANGE, applyHandler);
        }
    }
    
    override public function applyProperty():void
    {
        if( display is RadioButtonGroup ) {
	        model.value = RadioButtonGroup(display).selectedValue;
        }
        else if( display is ComboBase ) {
            model.value = ComboBase(display).selectedItem.value;
        }
    }
    
    override public function bindTo(model:IPropertyModel):void
    {
        super.bindTo(model);
        
        if( display is RadioButtonGroup ) {
	        RadioButtonGroup(display).selectedValue = model.value;
        }
        else if( display is ComboBase ) {
            var combo:ComboBase = ComboBase(display);
            var dp:Object = combo.dataProvider;
            for each( var data:Object in dp ) 
            {
                if( data.value == model.value ) {
                    combo.selectedItem = data;
                    return;
                }
            }
        }
    }
        
}
}
