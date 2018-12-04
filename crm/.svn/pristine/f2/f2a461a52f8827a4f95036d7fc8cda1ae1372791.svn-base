package cn.tencent.crm.service;

import static org.junit.Assert.*;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.tencent.crm.domain.Contract;
import cn.tencent.crm.domain.Customer;
import cn.tencent.crm.query.BaseQuery;
import cn.tencent.crm.util.PageList;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class IContractServiceTest {
	@Autowired
	private IContractService contractService;
	@Test
	public void testAdd() {
		Customer customer = new Customer();
		customer.setName("梁飞");
		Contract contract = new Contract();
		contract.setCustomer(customer);
		contract.setSignTime(new Date());
		contract.setSum(156156L);
		contractService.add(contract);
	}

	@Test
	public void testDelete() {
		contractService.delete(5L);
	}

	@Test
	public void testUpdate() {
		Contract contract = contractService.getById(4L);
		contract.setSum(15616L);
		contractService.update(contract);
	}

	@Test
	public void testGetById() {
		fail("Not yet implemented");
	}

	@Test
	public void testGetAll() {
		List<Contract> list = contractService.getAll();
		for (Contract contract : list) {
			System.out.println(contract);
		}
	}

	@Test
	public void testQueryPageData() {
		BaseQuery baseQuery = new BaseQuery();
		baseQuery.setPage(5);
		PageList<Contract> list = contractService.queryPageData(baseQuery);
		System.out.println(list);
		
	}

}
