package cn.tencent.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.tencent.crm.domain.Repair;
import cn.tencent.crm.domain.RepairItem;
import cn.tencent.crm.mapper.RepairItemMapper;
import cn.tencent.crm.service.IRepairService;
@Service
public class RepairServiceImpl extends BaseServiceImpl<Repair> implements IRepairService{
	@Autowired
	private RepairItemMapper repairItemMapper;
	@Override
	public List<RepairItem> getItemsById(Long id) {
		// TODO Auto-generated method stub
		return repairItemMapper.findItemsByRepairId(id);
	}
	@Override
	//修改保修单明细
	public void update(Repair repair) {
		super.update(repair);
		//先删除保修单
		repairItemMapper.remove(repair.getId());
		//拿到所有明细
		List<RepairItem> details = repair.getItems();
		for (RepairItem repairItem : details) {
			repairItem.setRepair(repair);
			repairItemMapper.save(repairItem);
		}
	}
}
