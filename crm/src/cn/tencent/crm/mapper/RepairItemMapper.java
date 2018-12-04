package cn.tencent.crm.mapper;

import java.util.List;

import cn.tencent.crm.domain.RepairItem;


public interface RepairItemMapper extends BaseMapper<RepairItem>{

	List<RepairItem> findItemsByRepairId(Long id);

}
