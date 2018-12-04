package cn.tencent.crm.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.tencent.crm.annotation.OwnPermission;
import cn.tencent.crm.domain.Department;

import cn.tencent.crm.domain.Order;
import cn.tencent.crm.query.OrderQuery;
import cn.tencent.crm.service.IOrderService;
import cn.tencent.crm.util.AjaxResult;
import cn.tencent.crm.util.PageList;

@Controller
@RequestMapping("/order")
public class OrderController {
	@Autowired
	private IOrderService orderService;
	
	@RequestMapping("/index")
	@OwnPermission("订单管理")
	public String index(){
		return "order/index";
	}
	
/*	@RequestMapping("/list")
	@ResponseBody
	public PageList<Order> list(OrderQuery query) {
		return orderService.loadDataByQuery(query);
	}*/
	@RequestMapping("/list")
	@ResponseBody
	@OwnPermission("订单列表")
	public PageList<Order> list(OrderQuery query) {
		System.out.println(query);
		return orderService.queryPageData(query);

	}
	@RequestMapping("/delete")
	@ResponseBody
	@OwnPermission("订单删除")
	public AjaxResult delete(Long id) {
		try {
			orderService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
			return new AjaxResult("操作失败"+e.getMessage());
		}
	}
	@RequestMapping("/save")
	@ResponseBody
	@OwnPermission("订单保存")
	public AjaxResult save(Order order) {
		try {
			//ID不为空就更新
			if(order.getId()!=null){
				orderService.update(order);
			}else{
				//为空添加
				orderService.add(order);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("操作失败!" + e.getMessage());
		}
	}
	@RequestMapping("/newContract")
	@ResponseBody
	public AjaxResult newContract(Long id){
		try {
			orderService.newContract(id);
			return new AjaxResult();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new AjaxResult("生成合同失败"+e.getMessage());
		}
	}
	@RequestMapping("/changeState")
	@ResponseBody
	public AjaxResult changeState(Long id){
		try {
			orderService.changeState(id);
			return new AjaxResult();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new AjaxResult("改变状态失败"+e.getMessage());
		}
	}
}
