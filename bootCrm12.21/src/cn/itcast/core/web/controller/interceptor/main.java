package cn.itcast.core.web.controller.interceptor;

import java.io.File;
import java.io.IOException;
import java.util.Scanner;

public class main {
	public static void main(String[] args) throws IOException 
	{ 
//		String t=Thread.currentThread().getContextClassLoader().getResource("").getPath(); 
//		 int num=t.indexOf(".metadata");
////		 String path=t.substring(1,num).replace('/', '\\')+"bootCrm12.21\\WebContent\\imags";
//		System.out.println("Hello\n" + t);
//		
		File directory = new File("");// 参数为空
        String courseFile = directory.getCanonicalPath();
        System.out.println(courseFile + "\\WebContent\\image\\questionImg");
		
//		Scanner in = new Scanner(System.in);
//		String s = in.nextLine();
//		String[] pic = s.split("@");
//		System.out.println(pic[pic.length-1]);
//		String path = "C:\Users\梁俊\Desktop\exam_system\bootCrm12.21\WebContent\images\questionImg\add.jpg";
		
        
//        ${pageContext.request.contextPath }
	} 
	
}
