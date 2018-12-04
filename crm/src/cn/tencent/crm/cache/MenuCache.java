package cn.tencent.crm.cache;

import java.util.List;

import cn.tencent.crm.domain.SystemMenu;

public interface MenuCache {
	//加载缓存菜单
	List<SystemMenu> loadMenus();
	//菜单保存入缓存
	void saveMenuCache(List<SystemMenu> menuByDb);
	
}
