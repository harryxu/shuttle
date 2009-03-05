package cn.geckos.airup.property
{
    
public interface IPropertyEditor
{
    
    function get display():Object;
    
    function applyProperty():void;
    
    function bindTo(model:IPropertyModel):void;
        
}
}