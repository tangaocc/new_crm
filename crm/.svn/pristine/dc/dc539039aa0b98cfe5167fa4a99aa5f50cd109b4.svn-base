package cn.tencent.crm.shiro.filter;

import java.io.IOException;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authz.PermissionsAuthorizationFilter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.util.StringUtils;
import org.apache.shiro.web.util.WebUtils;
public class TencentPermissionsAuthorizationFilter extends PermissionsAuthorizationFilter {
	
	@Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws IOException {
		Subject subject = getSubject(request, response);
		if (subject.getPrincipal() == null) {
			saveRequestAndRedirectToLogin(request, response);
		}else{
			//如果
			HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        	HttpServletResponse httpServletResponse = (HttpServletResponse) response;
			//拿到对应的请求头;
        	String header = httpServletRequest.getHeader("X-Requested-With");
        	//判断界面ajax请求
        	/**
        	 * 如果没有权限，要区别Ajax请求
        	 */
        	if(StringUtils.hasText(header) &&"XMLHttpRequest".equals(header)){
        		//如果没有权限，要区别Ajax请求
        		httpServletResponse.setContentType("text/json;charset=utf-8");
        		httpServletResponse.getWriter().write("{\"success\":false,\"message\":\"对不起,您没有操作权限!\"}");
        	}else{
        		//拿到无权限的请求地址;
        		String unauthorizedUrl = getUnauthorizedUrl();
        		//SHIRO-142 - ensure that redirect _or_ error code occurs - both cannot happen due to response commit:
        		if (StringUtils.hasText(unauthorizedUrl)) {
        			WebUtils.issueRedirect(request, response, unauthorizedUrl);
        		} else {
        			WebUtils.toHttp(response).sendError(HttpServletResponse.SC_UNAUTHORIZED);
        		}
        		
        	}
        	
        }
        return false;
		
	}
	
	
}
