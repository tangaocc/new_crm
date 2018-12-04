package cn.tencent.crm.util;

import java.util.Date;

import org.aspectj.lang.JoinPoint;
import org.springframework.beans.factory.annotation.Autowired;

import cn.tencent.crm.domain.SystemLog;
import cn.tencent.crm.service.ISystemLogService;

/**
 * 系统日志工具
 *
 */
public class SystemLogUtils {
	@Autowired
	private ISystemLogService logService;

	public void setLogService(ISystemLogService logService) {
		
		System.out.println("进入日志方法===========即进入日志方法");
		this.logService = logService;
	}
	//写日志
	public void writeLog(JoinPoint joinPoint) {
		
		Object serviceObj = joinPoint.getTarget();
		//判断当前是否是日志
		if(serviceObj instanceof ISystemLogService){
			return;
		}
		
		
		//获取当前类的字节码文件
		Class seviceClz = joinPoint.getTarget().getClass();
		//获取方法名称
		String methodName = joinPoint.getSignature().getName();
		
		//创建日志对象
		SystemLog systemLog = new SystemLog();
		//封装日志属性
		systemLog.setOpUser(UserContext.getUser());
		systemLog.setOpTime(new Date());
		String	function =seviceClz.getName()+":"+methodName;
		//保存日志
		systemLog.setFunction(function);
		logService.add(systemLog);
		
		
		
		
	}
}