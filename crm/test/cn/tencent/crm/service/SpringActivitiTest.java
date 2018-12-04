package cn.tencent.crm.service;

import static org.junit.Assert.*;

import java.util.List;

import org.activiti.engine.RepositoryService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;




public class SpringActivitiTest extends BaseTest {

	@Autowired
	private RepositoryService repositoryService;
	
	@Test
	public void test() throws Exception {
		System.out.println(repositoryService);
	} 
	

}
