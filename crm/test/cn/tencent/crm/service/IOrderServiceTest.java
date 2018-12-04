package cn.tencent.crm.service;


import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.tencent.crm.domain.Customer;
import cn.tencent.crm.domain.Order;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class IOrderServiceTest {
	@Autowired
	private IOrderService orderService;
	
	@Test
	public void testGetAll() {
		List<Order> list = orderService.getAll();
		System.out.println(list);
	}
	@Test
	public void testDelete(){
		orderService.delete(1L);
	}
	@Test
	public void testAdd(){
		Order order = new Order();
		order.setSn(new Date());
		order.setCustomer(new Customer());
		orderService.add(order);
		
	}
	@Test
	public void testupdate(){
		Order order = orderService.getById(3L);
		order.setSum(1156165156L);
		orderService.update(order);
	}
	@Test
	public void testGetById() {
		Order order = orderService.getById(2L);
		System.out.println(order);
	}
}
