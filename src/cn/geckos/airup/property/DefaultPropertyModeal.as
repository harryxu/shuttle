package cn.geckos.airup.property
{
public class DefaultPropertyModeal implements IPropertyModel
{
    protected var propertyName:String;
    protected var owner:Object;
    
    public function DefaultPropertyModeal(owner:Object, propertyName:String)
    {
        this.propertyName = propertyName;
        this.owner = owner;
    }

    public function set value(value:*)
    {
        owner[propertyName] = value;
    }
        
    public function get value():*
    {
        return owner[propertyName];
    }
        
}
}