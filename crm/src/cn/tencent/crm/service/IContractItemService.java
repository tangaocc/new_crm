package cn.tencent.crm.service;

import cn.tencent.crm.domain.Contract;
import cn.tencent.crm.domain.ContractItem;

public interface IContractItemService extends IBaseService<ContractItem>{

	void saveItem(Contract contract);

}
