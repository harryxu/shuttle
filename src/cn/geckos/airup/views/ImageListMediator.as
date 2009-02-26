package cn.geckos.airup.views
{
import cn.geckos.airup.Notices;
import cn.geckos.airup.models.vo.ImageVO;
import cn.geckos.airup.views.components.ImageListBox;

import flash.events.FileListEvent;
import flash.events.MouseEvent;
import flash.filesystem.File;
import flash.net.FileFilter;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.mediator.Mediator;

public class ImageListMediator extends Mediator
{
    
    public static const NAME:String = 'ImageListMediator';
    
    /**
     * 允许选择的图片文件格式
     */
    private static var imageTypeFilter:Array = [
        new FileFilter("Images(*.jpg;*.gif;*.png)", "*.jpg;*.gif;*.png"),
    ];
    
    /**
     * 用来选择图片文件的File对象 
     */    
    private var _file:File;
    
    
    public function get component():ImageListBox
    {
        return viewComponent as ImageListBox;
    }
    
    /**
     * Constructor 
     * @param mediatorName
     * @param viewComponent
     * 
     */
    public function ImageListMediator(mediatorName:String=null, viewComponent:Object=null)
    {
        super(mediatorName, viewComponent);
        
        component.addImgBtn.addEventListener(MouseEvent.CLICK, addImgBtnClickHandler);
    }
    
    private function getFile():File
    {
        if( !_file ) {
            _file = new File();
            _file.addEventListener(FileListEvent.SELECT_MULTIPLE, fileSelectMultipleHandler);
        }
        return _file;
    }
    
    
    private function addImgBtnClickHandler(event:MouseEvent):void
    {
        getFile().browseForOpenMultiple('Select images for upload.', imageTypeFilter);
    }
    
    private function fileSelectMultipleHandler(event:FileListEvent):void
    {
        var files:Array = event.files;
        
        for each( var file:File in files ) 
        {
            var fileExist:Boolean;
            for each( var vo:ImageVO in component.listData )
            {
                if( file.nativePath == File(vo.file).nativePath ) {
                    fileExist = true;
                }
            }
            
            if( !fileExist ) {
	            component.listData.addItem(new ImageVO(file));
            }
            
        }
    }
    
    
    override public function listNotificationInterests():Array
    {
        return [
            Notices.CHECK_FLICKR_TOKEN_OK,
        ];
    }
    
    override public function handleNotification(notification:INotification):void
    {
        switch( notification.getName() )
        {
            case Notices.CHECK_FLICKR_TOKEN_OK:
                component.enabled = true;
                break;
        }
    }
        
}
}