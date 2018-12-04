package cn.tencent.crm.activiti.listener;

import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cn.tencent.crm.domain.Employee;
import cn.tencent.crm.service.IEmployeeService;


/**
 * 现象：注入IEmployeeService失败，正常来说会导致办理者指定失败。
 * 原因：
 *     虽然我们在Spring中已经管理了一个ManagerSettingListener，但是我们在bpmn里面配置的是全限定名。
 *     它不会从Spring中获取已经管理的哪一个，而是新建了一个，而这一个没有受Spirng管理，自然就不能注入
 *     受Spring管理的bean。
 *     
 * 解决：告诉流程引擎不要自己建了，直接从spring中获取即可，怎么告诉？
 * @author Administrator
 *
 */
@Component
public class ManagerSettingListener implements TaskListener {

	private static final long serialVersionUID = -9208556526465090367L;

	@Autowired
	private IEmployeeService employeeService;
	
	@Override
	public void notify(DelegateTask delegateTask) {
		//获取Seller的realName
		String sellerRealName = delegateTask.getVariable("seller", String.class);
		//System.out.println(sellerRealName);
		//通过RealName获取员工
		//System.out.println(employeeService);
		Employee man = employeeService.findByRealName(sellerRealName);
		//通过员工获取部门
		//通过部门获取部门经理  
		String managerRealName = man.getRealName();
		//以上代码自己做 TODO
		//delegateTask.setAssignee(sellerRealName); //模拟：自己即时申请人又是审批人
		delegateTask.setAssignee(managerRealName); 
		System.out.println("审批办理者："+managerRealName);
		
	
	}

}
