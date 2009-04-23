package cn.geckos.shuttle.property
{
import flash.display.DisplayObject;
import flash.events.FocusEvent;
import flash.text.TextField;

import mx.controls.TextInput;
import mx.core.UIComponent;
import mx.events.FlexEvent;

public class StringEditor extends BasePropertyEditor
{
    public function StringEditor(display:DisplayObject)
    {
        super(display);
        
        if( display is UIComponent ) {
            UIComponent(display).addEventListener(FocusEvent.FOCUS_OUT, applyHandler);
        }
        else if( display is TextField ) {
            TextField(display).addEventListener(FocusEvent.FOCUS_OUT, applyHandler);
        }
        
        if( display is TextInput ) {
            TextInput(display).addEventListener(FlexEvent.ENTER, applyHandler);
        }
    }
    
    override public function applyProperty():void
    {
        model.value = display.text;
    }
    
    override public function bindTo(model:IPropertyModel):void
    {
        super.bindTo(model);
        
        display.text = String(model.value||'');
    }
    
    
        
}
}
