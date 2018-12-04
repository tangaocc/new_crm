package cn.tencent.crm.shiro.reaml;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;



import cn.tencent.crm.domain.Employee;
import cn.tencent.crm.domain.Permission;
import cn.tencent.crm.service.IEmployeeService;
import cn.tencent.crm.service.IPermissionService;
import cn.tencent.crm.util.MD5Util;

public class MyReaml extends AuthorizingRealm {

	@Autowired
	private IEmployeeService employeeService;
	@Autowired
	private IPermissionService permissionService; 
	

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principal) {
		/*Subject currentUser = SecurityUtils.getSubject();
		principal.get
		Employee loginUser = (Employee)currentUser.getPrincipal();
		permissionService.findPermissionByLoginUserId(loginUser.getId());
		//把权限返回给框架让框架进行判断
		//创建授权对象,把授权信息返回给框架授权;
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		//添加授权信息
		info.addStringPermissions(snsList);
		//返回给框架
		return info;*/
		//拿到当前登录用户的用户名
		Employee loginUser = (Employee)principal.getPrimaryPrincipal();
		//拿到当前用户名对应的权限;
		List<Permission> permissions = permissionService.findPermissionByLoginUserId(loginUser.getId());
		//定义一个集合来装权限的sn
		Collection<String> snsList= new ArrayList<String>();
		//遍历权限集合,把权限的sn放到sn集合;
		for (Permission permission : permissions) {
			if(permission!=null){
				snsList.add(permission.getSn());
			}
		}
		//创建授权对象,把授权信息返回给框架授权;
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		//添加授权信息
		info.addStringPermissions(snsList);
		//返回给框架
		return info;
		
		
	}

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		UsernamePasswordToken upt = (UsernamePasswordToken) token;
		String username = upt.getUsername();
		Employee employee = employeeService.login(username);
		if(employee==null){
			throw new UnknownAccountException("用户或密码错误!");			
		}
		if(employee.getState()==-1){
			throw new AuthenticationException("该用户已经被锁定");
		}
		Object principal = employee;//返回认证信息
		//加密过后的密码
		Object hashedCredentials=employee.getPassword();
		ByteSource credentialsSalt=ByteSource.Util.bytes(MD5Util.SALT);
		return new  SimpleAuthenticationInfo(principal , hashedCredentials, credentialsSalt, getName());
	}

}