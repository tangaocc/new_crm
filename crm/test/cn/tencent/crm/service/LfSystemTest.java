package cn.tencent.crm.service;

 


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.tencent.crm.domain.SystemDictionary;
import cn.tencent.crm.mapper.SystemDictionaryMapper;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class LfSystemTest {

	@Autowired
	private SystemDictionaryMapper systemdictionary;

	@Autowired
	private ISystemDictionaryService systemDictionaryService;
	
	/*
	 * @Autowired private ISystemDictionaryService systemdictionaryservice;
	 */
	@Test
	public void test() throws Exception {
		//增加测试
		SystemDictionary byId = new  SystemDictionary();
	//	SystemDictionary id = systemdictionary.loadById(10L);	
		//	SystemDictionary byId = systemDictionaryService.getById(9L);
		//System.out.println(byId);
 		byId.setIntro("测试信息333");
 		byId.setName("测试名字33");
 		byId.setSn("2");
	//	systemDictionaryService.update(byId);
 		//byId.setState(1);
		 
 		systemDictionaryService.add(byId);
 
		//查询全部测试
		 /*
			List<SystemDictionary> loadAll = systemdictionary.loadAll();
				for (SystemDictionary systemDictionary : loadAll) {
					System.out.println(systemDictionary);
				}
		*/
		//删除测试
		//systemdictionary.remove(11L);		
		//查询一个测试
		//修改测试
		//systemdictionary.update(id);
		
//		System.out.println(id);
	}

}
