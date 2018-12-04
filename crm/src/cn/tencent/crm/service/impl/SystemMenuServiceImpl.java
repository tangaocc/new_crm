package cn.tencent.crm.service.impl;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.tencent.crm.cache.MenuCache;
import cn.tencent.crm.domain.SystemMenu;
import cn.tencent.crm.mapper.SystemMenuMapper;
import cn.tencent.crm.service.ISystemMenuService;

@Service
public class SystemMenuServiceImpl extends BaseServiceImpl<SystemMenu> implements ISystemMenuService{
	
	@Autowired
	private SystemMenuMapper menuMapper;
	@Autowired
	private MenuCache menuCache;
	
	
	

	/*@Override
	public List<SystemMenu> findMenuByLoginUserId(Long loginUserId) {
		// TODO Auto-generated method stub
		return null;
	}*/
	
	/**
	 * 根据登录用户的id获取菜单;
	 */
	@Override
	public List<SystemMenu> findMenuByLoginUserId(Long loginUserId) {
		List<SystemMenu> menus = menuCache.loadMenus();
		if (menus != null && menus.size()>0) {
			System.out.println("cache..........");
			//如果有缓存直接返回
			return menus;
		}else {
			System.out.println("db..........");
			//从数据库中查询，放入缓存在返回
			//从当前
			 List<SystemMenu> menuByDb = menuMapper.findMenuByLoginUserId(loginUserId);
			 menuCache.saveMenuCache(menuByDb);
			 
			 return menuByDb;
		}
	}

}

