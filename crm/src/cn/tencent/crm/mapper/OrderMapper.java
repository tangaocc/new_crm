package cn.tencent.crm.mapper;

import cn.tencent.crm.domain.Order;

public interface OrderMapper extends BaseMapper<Order>{

	void changeState(Long id);

}
