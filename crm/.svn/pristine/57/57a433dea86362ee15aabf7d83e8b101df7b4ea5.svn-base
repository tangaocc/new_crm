package cn.tencent.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.tencent.crm.domain.Contract;
import cn.tencent.crm.domain.ContractItem;
import cn.tencent.crm.mapper.ContractItemMapper;
import cn.tencent.crm.service.IContractItemService;
@Service
public class ContractItemServiceImpl extends BaseServiceImpl<ContractItem> implements IContractItemService{
	@Autowired
	private ContractItemMapper mapper;
	@Override
	public void saveItem(Contract contract) {
		//拿到合同明细
		List<ContractItem> details = contract.getDetails();
		System.out.println("进入了！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！");
		for (ContractItem contractItem : details) {
			contractItem.setScale(contractItem.getScale());
			contractItem.setContract(contract);
			mapper.save(contractItem);
		}
	}

}
