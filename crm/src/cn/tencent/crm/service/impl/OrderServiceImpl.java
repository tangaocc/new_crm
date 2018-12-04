package cn.tencent.crm.service.impl;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.tencent.crm.domain.Contract;
import cn.tencent.crm.domain.ContractItem;
import cn.tencent.crm.domain.Order;
import cn.tencent.crm.mapper.OrderMapper;
import cn.tencent.crm.service.IContractItemService;
import cn.tencent.crm.service.IContractService;
import cn.tencent.crm.service.IOrderService;
@Service
public class OrderServiceImpl extends BaseServiceImpl<Order> implements IOrderService{
	@Autowired
	private OrderMapper orderMapper;
	@Autowired
	private IContractService contractService;
	@Autowired
	private IContractItemService icontractItemService;
	/**
	 * 生成合同与合同明细
	 */
	@Override
	public void newContract(Long id) {
		//生成合同
		Order order = orderMapper.loadById(id);
		Contract contract = new Contract();
		contract.setCustomer(order.getCustomer());
		contract.setSignTime(order.getSignTime());
		contract.setSeller(order.getSeller());
		contract.setSum(order.getSum());
		contract.setSn(new Date());
		contract.setIntro("已生成合同");
		//System.out.println("啊啊啊啊啊啊啊啊啊啊啊");
		contractService.add(contract);
		
		//生成合同明细
		ContractItem item = new ContractItem();
		item.setContract(contract);
		item.setIsPayment(true);
		item.setMoney(order.getSum());
		item.setPayTime(order.getSignTime());
		item.setScale(1L);
		icontractItemService.add(item);
		System.out.println("安全区群群群群群群群群群群群群群群");
		//关联合同和订单
		order.setContract(contract);
		System.out.println("啊啊啊啊啊啊啊啊啊啊啊");
		update(order);
		//生成合同时保修单同时生成
		contractService.newRepair(contract);

	}
	/**
	 * 改变订单是否生成合同状态
	 */
	@Override
	public void changeState(Long id) {
		orderMapper.changeState(id);
		
	}

}
