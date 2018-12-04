package cn.tencent.crm.util;

import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;

public class MD5Util {
	//盐值
	public  static final String SALT ="crm";
	
	private static final int hashIterations=1000;
	
	public static  String encrypt(String context){
		//加密算法
		String algorithmName="MD5";
		//加密盐值
		ByteSource salt = ByteSource.Util.bytes(SALT);
		SimpleHash simpleHash = new SimpleHash(algorithmName, context, salt, hashIterations);
		return simpleHash.toString();
	} 
	
}
