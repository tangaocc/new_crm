package cn.tencent.crm.service;

import java.util.List;

import cn.tencent.crm.domain.Customer;
import cn.tencent.crm.query.CustomerQuery;
import cn.tencent.crm.util.PageList;

public interface ICustomerService extends IBaseService<Customer>{

	void changeState(Customer customer);
	
	List<Long> getCusSourceId();
//客户管理的开启流程
	void startProcess(Long businessObjId);

	List<String> getTransNames(String taskId); 
	

}
