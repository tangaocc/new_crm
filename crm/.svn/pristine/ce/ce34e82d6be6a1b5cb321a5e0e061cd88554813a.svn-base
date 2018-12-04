package cn.tencent.crm.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.tencent.crm.annotation.OwnPermission;
import cn.tencent.crm.domain.Contract;
import cn.tencent.crm.domain.ContractItem;
import cn.tencent.crm.query.ContractQuery;
import cn.tencent.crm.service.IContractItemService;
import cn.tencent.crm.service.IContractService;
import cn.tencent.crm.util.AjaxResult;
import cn.tencent.crm.util.PageList;

@Controller
@RequestMapping("/contract")
public class ContractController {
	
	@Autowired
	private IContractService contractService;
	@Autowired
	private IContractItemService contractItemService;
	
	@RequestMapping("/index")
	@OwnPermission("合同管理")
	public String index(){
		return "contract/index";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	@OwnPermission("合同列表")
	public PageList<Contract> list(ContractQuery query){
		return contractService.queryPageData(query);
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public AjaxResult delete(Long id){
		try {
			contractService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
			return new AjaxResult("操作失败"+e.getMessage());
		}
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public AjaxResult save(Contract contract) {
		try {
			//ID不为空就更新
			if(contract.getId()!=null){
				contractService.update(contract);
			}else{
				System.out.println("进入保存！！！！！！！！！！！！！！！！！！！！！！！！！！！");
				//为空添加
				contractService.add(contract);
				contractItemService.saveItem(contract);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("操作失败!" + e.getMessage());
		}

	}
	
	
	
	//获取合同明细
	@RequestMapping("/getItems")
	@ResponseBody
	public List<ContractItem> getItems(Long id){
		return contractService.getItems(id);
	}
}
