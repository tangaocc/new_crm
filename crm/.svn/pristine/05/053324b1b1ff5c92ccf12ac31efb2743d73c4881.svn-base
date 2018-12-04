package cn.tencent.crm.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.tencent.crm.domain.Contract;
import cn.tencent.crm.domain.ContractItem;
import cn.tencent.crm.domain.Order;
import cn.tencent.crm.query.OrderQuery;
import cn.tencent.crm.service.IContractItemService;
import cn.tencent.crm.service.impl.ContractItemServiceImpl;
import cn.tencent.crm.util.AjaxResult;
import cn.tencent.crm.util.PageList;

@Controller
@RequestMapping("/contractItem")
public class ContractItemController {
	
	@Autowired
	private IContractItemService contractItemService;
	
	@RequestMapping("/index")
	public String index(){
		return "contractItem/index";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public PageList<ContractItem> list(OrderQuery query) {
		return contractItemService.queryPageData(query);
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public AjaxResult delete(Long id){
		try {
			contractItemService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
			return new AjaxResult("操作失败"+e.getMessage());
		}
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public AjaxResult save(ContractItem contractItem){
		try {
			contractItemService.add(contractItem);
			return new AjaxResult();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new AjaxResult("操作失败"+e.getMessage());
		}
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public AjaxResult update(ContractItem contractItem){
		try {
			contractItemService.update(contractItem);
			return new AjaxResult();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new AjaxResult("操作失败"+e.getMessage());
		}
	}
	
}
