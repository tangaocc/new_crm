package cn.tencent.crm.shiro;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import cn.tencent.crm.domain.Permission;
import cn.tencent.crm.service.IPermissionService;

public class LoginFactoryBean {
	
	@Autowired
	private IPermissionService permissionService;
	
	public Map<String, String> buildFilterChainDefinitionMap() {
		System.out.println("执行方法");
		Map<String, String> result = new LinkedHashMap<>();
		result.put("/login", "anon");
		result.put("/login.jsp", "anon");
		result.put("/login/in", "anon");
		result.put("/logout", "logout");
		result.put("/WEB-INF/jsps/common.jsp", "anon");
		result.put("/resources/**", "anon");
	
		// <!-- 权限 -->
		List<Permission> allPermissions = permissionService.getAll();
       for (Permission permission : allPermissions) {
			if (permission!=null) {
				//result.put(permission.getResource(), "perms["+permission.getSn()+"]");
				result.put(permission.getResource(), "crmFilter["+permission.getSn()+"]");
			}
       }
   		result.put("/**", "authc");
       //System.out.println("打印登陆的LinkedHashMap："+result);
		return result;
	}
	
}
