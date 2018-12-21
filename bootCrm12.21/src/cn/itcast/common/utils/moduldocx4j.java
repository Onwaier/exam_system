package cn.itcast.common.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.JAXBElement;
import org.apache.commons.lang3.StringUtils;
import org.docx4j.XmlUtils;
import org.docx4j.dml.wordprocessingDrawing.Inline;
import org.docx4j.openpackaging.exceptions.Docx4JException;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.docx4j.openpackaging.parts.WordprocessingML.BinaryPartAbstractImage;
import org.docx4j.openpackaging.parts.WordprocessingML.MainDocumentPart;
import org.docx4j.wml.BooleanDefaultTrue;
import org.docx4j.wml.Color;
import org.docx4j.wml.ContentAccessor;
import org.docx4j.wml.Drawing;
import org.docx4j.wml.HpsMeasure;
import org.docx4j.wml.Jc;
import org.docx4j.wml.JcEnumeration;
import org.docx4j.wml.ObjectFactory;
import org.docx4j.wml.P;
import org.docx4j.wml.PPr;
import org.docx4j.wml.R;
import org.docx4j.wml.RFonts;
import org.docx4j.wml.RPr;
import org.docx4j.wml.STHint;
import org.docx4j.wml.STLineSpacingRule;
import org.docx4j.wml.Text;
import org.docx4j.wml.U;
import org.docx4j.wml.UnderlineEnumeration;

import cn.itcast.core.bean.Question;
import org.docx4j.wml.PPrBase.Spacing;

public class moduldocx4j{
	
	public static ResultSet rs;
	public static WordprocessingMLPackage getTemplate(String name) throws Docx4JException, FileNotFoundException {
			WordprocessingMLPackage template = WordprocessingMLPackage.load(new FileInputStream(new File(name)));
			return template;
		}
		
	
	private static List<Object> getAllElementFromObject(Object obj, Class<?> toSearch) {
	    
		//JAXB����İ�װ�������������һ���ض�����������ָ��Ԫ���Լ������еĺ��ӣ����磬�����������ȡ�ĵ������еı�񡢱�������е����Լ��������ƵĲ����� 
		List<Object> result = new ArrayList<Object>();
		if (obj instanceof JAXBElement) obj = ((JAXBElement<?>) obj).getValue();
		if (obj.getClass().equals(toSearch))
			result.add(obj);
		else if (obj instanceof ContentAccessor) {
			List<?> children = ((ContentAccessor) obj).getContent();
			for (Object child : children) {
				result.addAll(getAllElementFromObject(child, toSearch));
			}
		}
		return result;
	}
	
	
	
	private void replacePlaceholder(WordprocessingMLPackage template, String name, String placeholder ) {
	
		//��ǰ�洴����ģ���ĵ������һ���Զ���ռλ������ʹ��SJ_EX1��Ϊռλ�������ǽ�Ҫ��name�������滻���ֵ��
		//��docx4j�л������ı�Ԫ����org.docx4j.wml.Text������ʾ���滻����򵥵�ռλ��
		List<Object> texts = getAllElementFromObject(template.getMainDocumentPart(), Text.class);
		for (Object text : texts) {
			Text textElement = (Text) text;
			if (textElement.getValue().equals(placeholder)) {
				textElement.setValue(name);
			}
		}
	}
	
	
	private static void writeDocxToStream(WordprocessingMLPackage template, String target) throws IOException, Docx4JException {
	
		File f = new File(target);
	
		template.save(f);
	
	}
	
	
	public static void replaceParagraph(String placeholder, String textToAdd, WordprocessingMLPackage template, ContentAccessor addTo) {
	
	//	�����Ҫ����ļ�����
	//
	//	��ģ�����ҵ�Ҫ�滻�Ķ���
	//	�������ı���ֳɵ�������
	//	ÿһ�л���ģ���еĶ��䴴��һ���µĶ���
	//	�Ƴ�ԭ���Ķ���
		// 1. get the paragraph
		List<Object> paragraphs = getAllElementFromObject(template.getMainDocumentPart(), P.class);
		P toReplace = null;
		for (Object p : paragraphs) {
			List<Object> texts = getAllElementFromObject(p, Text.class);
			for (Object t : texts) {
				Text content = (Text) t;
				if (content.getValue().equals(placeholder)) {
					toReplace = (P) p;
					break;
				}
			}
		}
		// we now have the paragraph that contains our placeholder: toReplace
		// 2. split into seperate lines
		String as[] = StringUtils.splitPreserveAllTokens(textToAdd, '\n');
		for (int i = 0; i < as.length; i++) {
			String ptext = as[i];
			// 3. copy the found paragraph to keep styling correct
			P copy = (P) XmlUtils.deepCopy(toReplace);
			// replace the text elements from the copy
			List<?> texts = getAllElementFromObject(copy, Text.class);
			if (texts.size() > 0) {
				Text textToReplace = (Text) texts.get(0);
				textToReplace.setValue(ptext);
			}
			// add the paragraph to the document
			addTo.getContent().add(copy);
		}
		// 4. remove the original one
		((ContentAccessor)toReplace.getParent()).getContent().remove(toReplace);
	}
	
	/**
     *  Docx4jӵ��һ�����ֽ����鴴��ͼƬ�����Ĺ��߷���, �������ӵ������İ���. Ϊ���ܽ�ͼƬ���
     *  ��һ��������, ������Ҫ��ͼƬת������������. ��Ҳ��һ������, ������Ҫ�ļ�����ʾ, �滻�ı�, 
     *  ����id��ʶ����һ����Ƕ�뻹�����ӵ���ָʾ��Ϊ����.
     *  һ��id�����ĵ��л�ͼ���󲻿ɼ�������, ��һ��id����ͼƬ�����ɼ��Ļ�������. ������ǽ�����
     *  ������ӵ������в���������ӵ��������ĵ�����.
     *
     *  @param wordMLPackage Ҫ���ͼƬ�İ�
     *  @param bytes         ͼƬ��Ӧ���ֽ�����
     *  @throws Exception    ���ҵ�createImageInline�����׳�һ���쳣(û�и��������쳣����)
     */

    private static void addImageToPackage(WordprocessingMLPackage wordMLPackage,
                            byte[] bytes) throws Exception {
        BinaryPartAbstractImage imagePart = BinaryPartAbstractImage.createImagePart(wordMLPackage, bytes);
        int docPrId = 1;
        int cNvPrId = 2;
        Inline inline = imagePart.createImageInline("Filename hint","Alternative text", docPrId, cNvPrId, false);
        P paragraph = addInlineImageToParagraph(inline);
        wordMLPackage.getMainDocumentPart().addObject(paragraph);
    }
    
    /**
     *  ����һ�����󹤳�����������һ�������һ�������п�R.
     *  Ȼ�󽫿����п���ӵ�������. ����������һ��ͼ����������ӵ������п�R��. ������ǽ�����
     *  ������ӵ�ͼ���в����ض������.
     *
     * @param   inline ����ͼƬ����������.
     * @return  ����ͼƬ�Ķ���
     */
    private static P addInlineImageToParagraph(Inline inline) {

        // �����������һ��������
        ObjectFactory factory = new ObjectFactory();
        P paragraph = factory.createP();
        R run = factory.createR();
        paragraph.getContent().add(run);
        Drawing drawing = factory.createDrawing();
        run.getContent().add(drawing);
        drawing.getAnchorOrInline().add(inline);
        return paragraph;
    }

 

    /**
     * ��ͼƬ���ļ�����ת�����ֽ�����.
     * 
     * @param file  ��Ҫת�����ļ�
     * @return      ����ͼƬ�ֽ����ݵ��ֽ�����
     * @throws FileNotFoundException
     * @throws IOException
     */
    private static byte[] convertImageToByteArray(File file)
            throws FileNotFoundException, IOException {
    	
        InputStream is = new FileInputStream(file );
        long length = file.length();
        // ����ʹ��long���ʹ�������, ��Ҫ��int����.
        if (length > Integer.MAX_VALUE) {
            System.out.println("File too large!!");
        }
        byte[] bytes = new byte[(int)length];
        int offset = 0;
        int numRead = 0;
        while (offset < bytes.length && (numRead=is.read(bytes, offset, bytes.length-offset)) >= 0) {
            offset += numRead;
        }
        // ȷ�����е��ֽڶ�û��ȡ
        if (offset < bytes.length) {
            System.out.println("Could not completely read file " +file.getName());
        }
        is.close();
        return bytes;

    }
    
    /** 
     * @param jcEnumeration 
     *            ���뷽ʽ 
     * @param isSpace 
     *            �Ƿ����ö�ǰ�κ�ֵ 
     * @param before 
     *            ��ǰ���� 
     * @param after 
     *            �κ���� 
     * @param beforeLines 
     *            ��ǰ���� 
     * @param afterLines 
     *            �κ����� 
     * @param isLine 
     *            �Ƿ������о� 
     * @param lineValue 
     *            �о�ֵ 
     * @param sTLineSpacingRule 
     *            �Զ�auto �̶�exact ��С atLeast 
     */  
    public static void setParagraphSpacing(ObjectFactory factory, P p,  

            JcEnumeration jcEnumeration, boolean isSpace, String before,  
            String after, String beforeLines, String afterLines,  
            boolean isLine, String lineValue,  
            STLineSpacingRule sTLineSpacingRule) {  
        PPr pPr = p.getPPr();  
        if (pPr == null) {  
            pPr = factory.createPPr();  
        }  
        Jc jc = pPr.getJc();  
        if (jc == null) {  
            jc = new Jc();  
        }  
        jc.setVal(jcEnumeration);  
        pPr.setJc(jc);  
  
        Spacing spacing = new Spacing();  
        if (isSpace) {  
            if (before != null) {  
                // ��ǰ����  
                spacing.setBefore(new BigInteger(before));  
            }  
            if (after != null) {  
                // �κ����  
                spacing.setAfter(new BigInteger(after));  
            }  
            if (beforeLines != null) {  
                // ��ǰ����  
                spacing.setBeforeLines(new BigInteger(beforeLines));  
            }  
            if (afterLines != null) {  
                // �κ�����  
                spacing.setAfterLines(new BigInteger(afterLines));  
            }  
        }  
        if (isLine) {  
            if (lineValue != null) {  
                spacing.setLine(new BigInteger(lineValue));  
            }  
            spacing.setLineRule(sTLineSpacingRule);  
        }  
        pPr.setSpacing(spacing);  
        p.setPPr(pPr);  
    }  

    /** 
     * �������� 
     *  
     * @param isBlod 
     *            ���� 
     * @param isUnderLine 
     *            �»��� 
     * @param isItalic 
     *            б�� 
     * @param isStrike 
     *            ɾ���� 
     */  
    public static RPr getRPr(ObjectFactory factory, String fontFamily,  
            String colorVal, String fontSize, STHint sTHint, boolean isBlod,  
            boolean isUnderLine, boolean isItalic, boolean isStrike) {  
        RPr rPr = factory.createRPr();  
        RFonts rf = new RFonts();  
        rf.setHint(sTHint);  
        rf.setAscii(fontFamily);  
        rf.setHAnsi(fontFamily);  
        rPr.setRFonts(rf);  
  
        BooleanDefaultTrue bdt = factory.createBooleanDefaultTrue();  
        rPr.setBCs(bdt);  
        if (isBlod) {  
            rPr.setB(bdt);  
        }  
        if (isItalic) {  
            rPr.setI(bdt);  
        }  
        if (isStrike) {  
            rPr.setStrike(bdt);  
        }  
        if (isUnderLine) {  
            U underline = new U();  
            underline.setVal(UnderlineEnumeration.SINGLE);  
            rPr.setU(underline);  
        }  
        Color color = new Color();  
        color.setVal(colorVal);  
        rPr.setColor(color);  
  
        HpsMeasure sz = new HpsMeasure();  
        sz.setVal(new BigInteger(fontSize));  
        rPr.setSz(sz);  
        rPr.setSzCs(sz);  
        return rPr;  
    }  
	
    //�����Ծ���Ϣ����
    public static void examTitle(WordprocessingMLPackage template,String str,boolean ty) {
    	ObjectFactory factory = new ObjectFactory();
		P paragraph = factory.createP(); 
		RPr fontRPr = getRPr(factory, "����", "000000", "24", STHint.EAST_ASIA,  true, false, false, false); 
		Text txt = factory.createText();
		R run = factory.createR();
		if(ty)
		{
			setParagraphSpacing(factory, paragraph, JcEnumeration.CENTER, true,  
                "0", "0", null, null, true, "240", STLineSpacingRule.AUTO);  
        txt = factory.createText(); 
        txt = factory.createText();  
        txt.setValue(str);  
        run = factory.createR();
        fontRPr = getRPr(factory, "����", "000000", "28", STHint.EAST_ASIA,  
                true, false, false, false); 
		}
		else
		{
			setParagraphSpacing(factory, paragraph, JcEnumeration.LEFT, true,  
	                "0", "0", null, null, true, "240", STLineSpacingRule.AUTO);  
	        txt = factory.createText(); 
	        txt = factory.createText();  
	        txt.setValue(str);  
	        run = factory.createR();
	        fontRPr = getRPr(factory, "����", "000000", "24", STHint.EAST_ASIA,  
	                true, false, false, false); 
		}
         
        run = factory.createR();  
        run.getContent().add(txt);  
        run.setRPr(fontRPr);  
        paragraph.getContent().add(run);  
        MainDocumentPart t =template.getMainDocumentPart();
		t.addObject(paragraph);
    }
    
  //��Ŀ����
    private String[] quType = new String[4];
	
    public static void paper(String[] quType) throws Exception {
//	public static void main(String[] args) throws Exception
//	{
			//��Ŀ����
		   //String[] quType = new String[4];
		   quType[0]= "һ������⣨ÿ��2�֣���30�֣�";
		   quType[1]="����ѡ���⣨��ѡ���ѡ��ÿ��3�֣���15�֣�";
		   quType[2]="��������⣨ý��10�֣���30�֣�";
		   quType[3]="�ġ�����⣨25�֣�";
		  
		   //ÿ����������
		   int[] numbers = new int[quType.length];
		   for(int i=0;i<numbers.length;i++)
			   numbers[i] = 3;//ÿ��������Ŀ����
		   
		   //ÿ������
//		   Question[] xuan = new Question[numbers[0]];
//		   Question[] jian = new Question[numbers[1]];
//		   Question[] ming = new Question[numbers[2]];
//		   Question[] tian = new Question[numbers[3]];
//		   getData(xuan,jian,ming,tian,numbers);
			//��ȡģ��
			String placeholder = "SJ_EX1";
			String toAdd = "�人���̴�ѧ�������ѧ�빤��ѧԺ";
			WordprocessingMLPackage template = null;
			try {
				template = getTemplate("d:/HelloWord7.docx");
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Docx4JException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			replaceParagraph(placeholder, toAdd, template, template.getMainDocumentPart());
			
			//�����Ծ���Ϣ
			examTitle(template,"2008-2009ѧ���2ѧ�ڿ������⣨B����",true);
			examTitle(template,"�γ�����  �����ϵ�ṹ        �ον�ʦǩ��   ����",false);
			examTitle(template,"�����ʦǩ��  ����             �����ʦǩ��",false);
			examTitle(template,"���Է�ʽ   �������գ���        ����רҵ     �����",false);
			examTitle(template,"����ʱ��   �� 120 ������",false);
			File file1 = new File("d:/extable.png");//�÷ֱ��
	        byte[] bytes1 = null;
			try {
				bytes1 = convertImageToByteArray(file1);
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        addImageToPackage(template, bytes1);
	        
			//�����ݿ�����Ŀ
	        List quel = null;
			quel = query();
	        int i=0,n=0;
	        boolean im=true;//�Ƿ���ͼ
	        String pat="^[A-z]:\\\\.*?$";//�ж��Ƿ�Ϊ·����������ʽ
	        for(;i<quType.length;i++)
	        {
	        	template.getMainDocumentPart().addStyledParagraphOfText("Subtitle", quType[i]);
	        	for(int j=0;j<numbers[i];j++)
	        	{
	        		
	        		if(((Question) quel.get(n)).getType().equals("��ѡ��"))
	        		{
	        			template.getMainDocumentPart().addStyledParagraphOfText("Normal",Integer.toString(j+1) +"��"+ ((Question) quel.get(n)).getSubject());
	        			
	        			if((((Question) quel.get(n)).getOptionA()).matches(pat))//������ʽ�ж��Ƿ�ΪͼƬ·��
	        			{
	        				template.getMainDocumentPart().addStyledParagraphOfText("Normal","A��");
	        				//���ͼƬ
	        				File file = new File(((Question) quel.get(n)).getOptionA());
	        		        byte[] bytes = convertImageToByteArray(file);
	        		        addImageToPackage(template, bytes);
	        			}
	        			else
	        			    template.getMainDocumentPart().addStyledParagraphOfText("Normal",((Question) quel.get(n)).getOptionA());
	        			
	        			if(((Question) quel.get(n)).getOptionB().matches(pat))
	        			{
	        				template.getMainDocumentPart().addStyledParagraphOfText("Normal","B��");
	        				//���ͼƬ
	        				File file = new File(((Question) quel.get(n)).getOptionB());
	        		        byte[] bytes = convertImageToByteArray(file);
	        		        addImageToPackage(template, bytes);
	        			}
	        			else
	        				template.getMainDocumentPart().addStyledParagraphOfText("Normal",((Question) quel.get(n)).getOptionB());
	        			
	        			template.getMainDocumentPart().addStyledParagraphOfText("Normal",((Question) quel.get(n)).getOptionC());
	        			template.getMainDocumentPart().addStyledParagraphOfText("Normal",((Question) quel.get(n)).getOptionD());

	        		}
//	        			
	        	else 
        			template.getMainDocumentPart().addStyledParagraphOfText("Normal",Integer.toString(j+1) +"��"+ ((Question) quel.get(n)).getSubject());
	        		n++;
	        	}
	        }
	        
			writeDocxToStream(template, "d:/target.docx");
			
		}
	
	
	
	
	
	 //��ѯ����
    @SuppressWarnings("rawtypes")
	public static List query()  {
    	//conDao cc= conDao();
    	Connection conn=null;
    	List QuestionsList = new ArrayList();
        Question ques = null;
        String sql="";
        sql = "SELECT qid,subject,type,optionA,optionB,optionC,optionD FROM Question WHERE courseName='�������'";
        Statement stmt;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        String type="";
        String answer="";
        try {
            while (rs.next()) {
                ques = new Question();
                ques.setQid(rs.getLong(1));
                ques.setSubject(rs.getString(2));
                ques.setType(rs.getString(3));
                ques.setOptionA(rs.getString(4));
                
                //System.out.println(rs.getString(3));
                
                ques.setOptionB(rs.getString(5));
                ques.setOptionC(rs.getString(6));
                ques.setOptionD(rs.getString(7));
//                if(type.equals("��ѡ��")){
//                	String[] ans=rs.getString(11).split(",");
//                	QuestionsForm1.setAnswerArr(ans);
//                }else{
//                	QuestionsForm1.setAnswer(rs.getString(11));
//                }
//                QuestionsForm1.setNote(rs.getString(12));
                QuestionsList.add(ques);
            }
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return QuestionsList;
    }
	
	

}
