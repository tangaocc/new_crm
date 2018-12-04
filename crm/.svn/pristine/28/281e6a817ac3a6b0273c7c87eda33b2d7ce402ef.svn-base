package cn.tencent.crm.mapper;

import java.util.List;

import cn.tencent.crm.domain.SystemMenu;

public interface SystemMenuMapper extends BaseMapper<SystemMenu>{
	/**
	 * 通过登陆用户查询他所拥有权限的菜单
	 * @param empId 登录用户的id     queryMenuByEmpId
	 * @returnfindMenuByLoginUserId
	 */
  List<SystemMenu> findMenuByLoginUserId(Long empId);
}
