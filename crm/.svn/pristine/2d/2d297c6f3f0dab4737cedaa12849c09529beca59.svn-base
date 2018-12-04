package cn.tencent.crm.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.tencent.crm.annotation.OwnPermission;
import cn.tencent.crm.domain.Repair;
import cn.tencent.crm.domain.RepairItem;
import cn.tencent.crm.query.RepairQuery;
import cn.tencent.crm.service.IRepairItemService;
import cn.tencent.crm.service.IRepairService;
import cn.tencent.crm.util.AjaxResult;
import cn.tencent.crm.util.PageList;


@Controller
@RequestMapping("/repair")
public class RepairController {

	@Autowired
	private IRepairService repairService;
	
	@Autowired
	private IRepairItemService repairItemService;
	/**
	 * 控制层
	 */
	@RequestMapping("/index")
	@OwnPermission("维修单管理")
	public String index() {
		System.out.println("测试一波...");
		return "repair/index";
	}

	@RequestMapping("/list")
	@ResponseBody
	@OwnPermission("维修单列表")
	public PageList<Repair> list(RepairQuery query) {
		return repairService.queryPageData(query);
	}

	@RequestMapping("/delete")
	@ResponseBody
	@OwnPermission("维修单删除")
	public AjaxResult del(Long id) {
		System.out.println("删除走一波...");
		try {
			repairService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("删除失败!" + e.getMessage());
		}

	}
	
	@RequestMapping("/save")
	@ResponseBody
	@OwnPermission("维修单保存")
	public AjaxResult save(Repair repair) {
		try {
			//ID不为空就更新
			if(repair.getId()!=null){
				repairService.update(repair);
			}else{
				//为空添加
				repairService.add(repair);
				repairItemService.saveItems(repair);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("操作失败!" + e.getMessage());
		}
	}
	//获取对应合同的id的合同明细
	@RequestMapping("/getItems")
	@ResponseBody
	public List<RepairItem> getItems(Long id){
		return repairService.getItemsById(id);
	}
}
