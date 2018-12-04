package cn.tencent.crm.cache.Impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.alibaba.fastjson.JSONArray;

import cn.tencent.crm.cache.MenuCache;
import cn.tencent.crm.domain.SystemMenu;
import cn.tencent.crm.util.RedisUtil;
@Repository
public class MenuCacheImpl implements MenuCache{

	private String MENU_IN_REDIS = "MENU_IN_REDIS";

	@Override
	public List<SystemMenu> loadMenus() {
		//从redis中获取json字符串
		String jsonString = RedisUtil.get(MENU_IN_REDIS);
		//转换为java对象进行返回
		List<SystemMenu> parseArray = JSONArray.parseArray(jsonString, SystemMenu.class);
		return parseArray;
	}

	@Override
	public void saveMenuCache(List<SystemMenu> menuByDb) {
		//转换为json字符串存放
		String jsonString = JSONArray.toJSONString(menuByDb);
		//要存储-jedis，导入jar，写一个工具类，使用工具类操作即可
		RedisUtil.set(MENU_IN_REDIS , jsonString);
		
		
	}

}
