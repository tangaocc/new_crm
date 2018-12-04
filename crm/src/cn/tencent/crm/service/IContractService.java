package cn.tencent.crm.service;

import java.util.List;

import cn.tencent.crm.domain.Contract;
import cn.tencent.crm.domain.ContractItem;

public interface IContractService extends IBaseService<Contract>{

	List<ContractItem> getItems(Long id);

	void newRepair(Contract contract);

}
