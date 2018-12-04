package cn.tencent.crm.service;

import java.util.List;

import cn.tencent.crm.domain.SystemMenu;



/**
 *子接口
 *
 */
public interface ISystemMenuService extends IBaseService<SystemMenu>{
	/**
	 * 根据登录用户拿到对应的菜单;
	 */
	List<SystemMenu> findMenuByLoginUserId(Long loginUserId);
}
