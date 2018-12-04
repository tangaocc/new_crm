package cn.tencent.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.tencent.crm.domain.Contract;
import cn.tencent.crm.domain.ContractItem;
import cn.tencent.crm.domain.Repair;
import cn.tencent.crm.mapper.ContractItemMapper;
import cn.tencent.crm.service.IContractService;
import cn.tencent.crm.service.IRepairService;
@Service
public class ContractServiceImpl extends BaseServiceImpl<Contract> implements IContractService{
	
	@Autowired
	private ContractItemMapper contractItemMapper;
	@Autowired
	private IRepairService repairService;
	@Override
	public List<ContractItem> getItems(Long id) {
		return contractItemMapper.getItemsById(id);
	}
	@Override
	//修改合同
	public void update(Contract contract) {
		super.update(contract);
		//先删除合同
		contractItemMapper.remove(contract.getId());
		//拿到所有明细
		List<ContractItem> details = contract.getDetails();
		for (ContractItem contractItem : details) {
			contractItem.setScale(2L);
			contractItem.setContract(contract);
			contractItemMapper.save(contractItem);
		}
	}
	/**
	 * 生成保修单
	 */
	@Override
	public void newRepair(Contract contract) {
		Repair repair = new Repair();
		repair.setRepairTime(contract.getSignTime());
		repair.setContract(contract);
		repair.setCustomer(contract.getCustomer());
		repairService.add(repair);
	}
}
