package cn.tencent.crm.service.impl;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.tencent.crm.domain.Customer;
import cn.tencent.crm.mapper.CustomerMapper;
import cn.tencent.crm.service.ICustomerService;
import cn.tencent.crm.service.IWorkFlowService;
@Service
public class CustomerServiceImpl extends BaseServiceImpl<Customer> 
implements ICustomerService{
	@Autowired
	private CustomerMapper customerMapper;
	@Autowired
	private IWorkFlowService workFlowService;
	
	
	@Override
	public void changeState(Customer custate) {
		customerMapper.changeState(custate);
	}
	@Override
	public List<Long> getCusSourceId() {
		List<Long> list = customerMapper.getCustomerSourceId();
		return list;
	}
	
	//客户管理的开启流程
	@Override
	public void startProcess(Long businessObjId) {
		//修改state状态
		Customer customer = customerMapper.loadById(businessObjId);
		customer.setState(11);//报备ing的状态
		customerMapper.update(customer);
		
		String processDefinitionKey = customer.getClass().getSimpleName()+"Flow";//约定！！
		Map<String,Object> variables = new HashMap<>();
		if(customer.getSeller()!=null){
			
			variables.put("seller", customer.getSeller().getRealName());
		}
		/*
		 * 
		 */
		//为了以后能够在流程中获取业务对象,需要设置businessObjType和businessObjId这两个流程变量
		variables.put("businessObjType", customer.getClass().getSimpleName());
		variables.put("businessObjId", customer.getId());
		
		//开启流程
		workFlowService.startProcess(processDefinitionKey,variables);
		
		
		
	}
	@Override
	public List<String> getTransNames(String taskId) {
		
		return workFlowService.getOutGoingTransNames(taskId);
	}
	
		
	

}
