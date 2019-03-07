package cn.itcast.common.utils;

import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.crypto.hash.SimpleHash;

public class TestEncryption {
	
	public static void main(String[] args) {
        String password = "111111";
        //String salt = new SecureRandomNumberGenerator().nextBytes().toString();
        String salt ="clover";
        int times = 1;
        String algorithmName = "md5";
         
        String encodedPassword = new SimpleHash(algorithmName,password,salt,times).toString();
         
        System.out.printf("ԭʼ������ %s , ���ǣ� %s, ��������ǣ� %d, ��������������ǣ�%s ",password,salt,times,encodedPassword);
         
    }
}
