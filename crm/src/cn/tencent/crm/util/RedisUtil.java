package cn.tencent.crm.util;


import java.io.IOException;
import java.util.Properties;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public class RedisUtil {
	// 连接池是单例
	private static JedisPool INSTANCE;
		
	static{
		Properties p = new Properties();
		
		try {
			p.load(RedisUtil.class.getResourceAsStream("/redis.properties"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 1 创建连接池配置对象
		JedisPoolConfig config = new JedisPoolConfig(); 
		//2 进行配置
		// 2 进行配置
				int maxIdle = Integer.parseInt(p.getProperty("redis.maxIdle"));
				int maxTotal = Integer.parseInt(p.getProperty("redis.maxTotal"));
				Long timeOut = Long.parseLong(p.getProperty("redis.timeout"));
				
				config.setMaxIdle(maxIdle);// 最小连接数
				config.setMaxTotal(maxTotal);// 最大连接数
				config.setMaxWaitMillis(timeOut);// 最大等待时间
				config.setTestOnBorrow(true);// 获取连接时测试连接是否畅通
				
				// 3 通过连接池配置对象创建连接池对象
				String host = p.getProperty("redis.host");
				int port = Integer.parseInt(p.getProperty("redis.port"));
				String pwd = p.getProperty("redis.pwd");
				INSTANCE = new JedisPool(config, host, port, timeOut.intValue(), pwd);
			
		
		
	}	
		
	//获取连接
		public static Jedis getInstance() {
			return INSTANCE.getResource();
		}
		//释放连接
		public static void close(Jedis jedis) {
			if (jedis != null) {
				jedis.close();
			}
		}
		
		public static void main(String[] args) {
			Jedis jedis = getInstance();
			System.out.println(jedis.set("name", "zs"));
			System.out.println(jedis.get("name"));
			close(jedis);
		}

		
		/**
		 * 设置string的value
		 * @param key
		 * @param value
		 */
		public static void set(String key,String value) {
			Jedis jedis = null;
			try {
				jedis = getInstance();
				jedis.set(key, value);
			} catch (Exception e) {
				e.printStackTrace();
			}
			finally {
				close(jedis);
			}
		}
		
		/**
		 * 获取stringvalue
		 * @param key
		 * @return
		 */
		public static String get(String key) {
			Jedis jedis = null;
			try {
				jedis = getInstance();
				return jedis.get(key);
			} catch (Exception e) {
				e.printStackTrace();
			}
			finally {
				close(jedis);
			}
			return null;
		}
		
		
		
		
		
		
		
}
