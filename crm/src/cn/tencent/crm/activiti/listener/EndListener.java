package cn.tencent.crm.activiti.listener;

import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.ExecutionListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cn.tencent.crm.domain.Customer;
import cn.tencent.crm.service.ICustomerService;


@Component
public class EndListener implements ExecutionListener {

	@Autowired
	private ICustomerService customerService;
	@Override
	public void notify(DelegateExecution execution) throws Exception {
		
		//从流程变量中获取businessObjId
		Long businessObjId = execution
				.getVariable("businessObjId", Long.class);
		//通过id获取Customer
		Customer customer = customerService.getById(businessObjId);
		//修改状态
		customer.setState(0);
		//更新会去
		customerService.update(customer);
	}

}
