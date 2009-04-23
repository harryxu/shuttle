package cn.geckos.shuttle.property
{
public class PropertyManager
{
    private var editors:Object = {};
    
    public function PropertyManager()
    {
    }
    
    public function getEditor(id:String):IPropertyEditor
    {
        return editors[id] as IPropertyEditor;
    }
    
    public function setEditor(editor:IPropertyEditor, 
                              id:String, 
                              model:IPropertyModel=null):void
    {
        editors[id] = editor;
        if( model ) {
            editor.bindTo(model);
        }
    }

}
}
