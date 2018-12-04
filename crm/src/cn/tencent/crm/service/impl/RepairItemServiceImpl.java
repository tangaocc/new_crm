package cn.tencent.crm.service.impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.tencent.crm.domain.Repair;
import cn.tencent.crm.domain.RepairItem;
import cn.tencent.crm.mapper.RepairItemMapper;
import cn.tencent.crm.service.IRepairItemService;


/**
 *保修单详细
 *
 */
@Service
public class RepairItemServiceImpl extends BaseServiceImpl<RepairItem> implements IRepairItemService{
	@Autowired
	private RepairItemMapper repairItemMapper;

	@Override
	public void saveItems(Repair repair) {
		List<RepairItem> items = repair.getItems();
		for (RepairItem repairItem : items) {
			repairItem.setRepair(repair);
			repairItemMapper.save(repairItem);
		}
	}
}
