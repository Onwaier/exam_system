package cn.itcast.common.utils;


import com.microsoft.schemas.vml.CTShape;

import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFPictureData;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.xmlbeans.XmlCursor;
import org.apache.xmlbeans.XmlObject;
import org.openxmlformats.schemas.drawingml.x2006.main.CTGraphicalObject;
import org.openxmlformats.schemas.drawingml.x2006.picture.CTPicture;
import org.openxmlformats.schemas.drawingml.x2006.wordprocessingDrawing.CTInline;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTDrawing;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTObject;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTR;
 
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class XWPFUtils {

    //��ȡĳһ�������е�����ͼƬ����
    public static List<String> readImageInParagraph(XWPFParagraph paragraph) {
        //ͼƬ����List
        List<String> imageBundleList = new ArrayList<String>();

        //����������XWPFRun
        List<XWPFRun> runList = paragraph.getRuns();
        for (XWPFRun run : runList) {
            //XWPFRun��POI��xmlԪ�ؽ��������ɵ��Լ������ԣ��޷�ͨ��xml��������Ҫ��ת����CTR
            CTR ctr = run.getCTR();

            //����Ԫ�ؽ��б���
            XmlCursor c = ctr.newCursor();
            //��������õ����е���Ԫ�أ�
            c.selectPath("./*");
            while (c.toNextSelection()) {
                XmlObject o = c.getObject();
                //�����Ԫ����<w:drawing>��������ʽ��ʹ��CTDrawing����ͼƬ
                if (o instanceof CTDrawing) {
                    CTDrawing drawing = (CTDrawing) o;
                    CTInline[] ctInlines = drawing.getInlineArray();
                    for (CTInline ctInline : ctInlines) {
                        CTGraphicalObject graphic = ctInline.getGraphic();
                        //
                        XmlCursor cursor = graphic.getGraphicData().newCursor();
                        cursor.selectPath("./*");
                        while (cursor.toNextSelection()) {
                            XmlObject xmlObject = cursor.getObject();
                            	// �����Ԫ����<pic:pic>��������ʽ
                            if (xmlObject instanceof CTPicture) {
                                org.openxmlformats.schemas.drawingml.x2006.picture.CTPicture picture = (org.openxmlformats.schemas.drawingml.x2006.picture.CTPicture) xmlObject;
                                //�õ�Ԫ�ص�����
                                imageBundleList.add(picture.getBlipFill().getBlip().getEmbed());
                            }
                        }
                    }
                }
                //ʹ��CTObject����ͼƬ
                //<w:object>��ʽ
                if (o instanceof CTObject) {
                    CTObject object = (CTObject) o;
                    System.out.println(object);
                    XmlCursor w = object.newCursor();
                    w.selectPath("./*");
                    while (w.toNextSelection()) {
                        XmlObject xmlObject = w.getObject();
                        if (xmlObject instanceof CTShape) {
                            CTShape shape = (CTShape) xmlObject;
//                            imageBundleList.add(shape.getImagedataArray()[0].getId2());
                        }
                    }
                }
            }
        }
        return imageBundleList;
    }
    
  

}
