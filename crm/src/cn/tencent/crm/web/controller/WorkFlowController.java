package cn.tencent.crm.web.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.repository.ProcessDefinition;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import cn.tencent.crm.service.IWorkFlowService;
import cn.tencent.crm.util.AjaxResult;
import cn.tencent.crm.util.UserContext;

@Controller
@RequestMapping("/workFlow")
public class WorkFlowController {
	@Autowired
	private IWorkFlowService workFlowService;
	//跳转到流程规则管理界面
	@RequestMapping("/processDefinition/index")
	public String processDefinitionIndex() {
		return "workFlow/processDefinition";
	}
	
	//新部署
		/*
		 * 参数:
		 *   String name 部署名称
		 *   MultipartFile processFile,部署文件,在Springmvc接收上传文件用MultipartFile
		 * 返回值:
		 *   AjaxResult的转换结果{sucess:true,message:""}
		 * @return
		 */
	
	@RequestMapping("/newDeploy")
	@ResponseBody
	public AjaxResult newDeploy(String name,MultipartFile processFile){
		
		try {
			workFlowService.newDeploy(name,processFile.getInputStream());
			return new AjaxResult();
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new AjaxResult("部署流程失败"+e.getMessage());
		}
		
		
		
		
	}
	@RequestMapping("/processDefinition/list")
	@ResponseBody
	public List<Map<String,Object>> listProcessDefinitions(){
		
		
		return workFlowService.listProcessDefinitions();
		
	}
	
	//既不是响应页面，也不是响应ajaxresult，而是通过流方式进行响应。
		//以response.getOutputStream
	@RequestMapping("/viewProcessDiagram")
	public void viewProcessDiagram(String deploymentId, String diagramResourceName, HttpServletResponse response) {
		// 获取流
		try {
			InputStream is = workFlowService.viewProcessDiagram(deploymentId, diagramResourceName);
			// 响应流
			IOUtils.copy(is, response.getOutputStream());
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	@RequestMapping("/processDefinition/delete")
	@ResponseBody
	public AjaxResult delete(String deploymentId){
		System.out.println(deploymentId);
		try {
			workFlowService.deleteById(deploymentId);
			return new AjaxResult();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new AjaxResult("删除流程失败！"+e.getMessage());
		}
	}
	
	
	
	@RequestMapping("/processDefinition/suspend")
	@ResponseBody
	public AjaxResult suspend(String processDefinitionKey,Integer pstate){
		
		try {
			workFlowService.suspendProcessDefinitionByKey(processDefinitionKey,pstate);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("挂起流程失败！"+e.getMessage());
		}
	}
	///processDefinition/activate
	@RequestMapping("/processDefinition/activate")
	@ResponseBody
	public AjaxResult activate(String processDefinitionKey,Integer pstate){
		
		try {
			workFlowService.activateProcessDefinitionByKey(processDefinitionKey,pstate);
			return new AjaxResult();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new AjaxResult("挂起流程失败！"+e.getMessage());
		}
	}
	
	//workFlow/personalTask/index
	//跳转到代办任务管理界面
		/**
		 * 参数:
		 *   无
		 * 返回值:
		 *   页面视图
		 * @return
		 */
		@RequestMapping("/personalTask/index")
		public String personalTaskIndex() {
			return "workFlow/personalTask";
		}
		
		
		
		@RequestMapping("/personalTask/list") 
		@ResponseBody
		public List<Map<String,Object>> listpersonalTasks(){
			//获取Session里面登录用户realName方案
			//方案1:直接在Service里面通过UserContext,不能使用,UserContext依赖于web层Session,也就是Service简介依赖web环境,以后不再web环境就不能使用.
			//方案2:在Controller中获取到传入
			String assignee = UserContext.getUser().getRealName();
			System.out.println(assignee);
			return workFlowService.listpersonalTasks(assignee);
			
		}
		@RequestMapping("/commonTask/list") 
		@ResponseBody
		public List<Map<String,Object>> listcommonTasks(){
			
			return workFlowService.listcommonTasks();
			
		}
		
		
		/*loadForm*/
		//对formKey的地址进行forward跳转
		@RequestMapping("/loadForm")
		public String loadForm(String formKey) {
			
			//默认会加前缀和后缀
			//return formKey;
			return "forward:"+formKey;
		}
		
		
		//办理任务
		@RequestMapping("/completeTask")
		@ResponseBody
		public AjaxResult completeTask(String taskId,Boolean flag) {
			
			try {
				workFlowService.completeTask(taskId,flag);
				return new AjaxResult();
			} catch (Exception e) {
				e.printStackTrace();
				return new AjaxResult("完成任务失败！"+e.getMessage());
			}
		}
		
		
		
		/**
		 * 查看当前流程图
		 * @RequestMapping("/viewProcessDiagram")
	public void viewProcessDiagram(String deploymentId, String diagramResourceName, HttpServletResponse response) {
		// 获取流
		try {
			InputStream is = workFlowService.viewProcessDiagram(deploymentId, diagramResourceName);
			// 响应流
			IOUtils.copy(is, response.getOutputStream());
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
		 */
		@RequestMapping("/viewCurrentImage")
		@ResponseBody
		public Map<String,Object> viewCurrentImage(String taskId , String diagramResourceName, HttpServletResponse response){
			ProcessDefinition pd = this.workFlowService.getProcessDefinitionByTaskId(taskId);
			List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
			Map<String,Object> map = new HashMap<String, Object>();
			// 1. 获取流程部署ID
			map.put("deploymentId", pd.getDeploymentId());
			// 2. 获取流程图片的名称
			map.put("imageName", pd.getDiagramResourceName());
			
			// 3.获取当前活动的坐标
			Map<String,Object> currentActivityCoordinates = this.workFlowService.getCurrentActivityCoordinates(taskId);
			map.put("acs", currentActivityCoordinates);
			list.add(currentActivityCoordinates);
			list.add(map);
			//System.out.println(currentActivityCoordinates);
			
			InputStream is = workFlowService.viewProcessDiagram(pd.getDeploymentId(), pd.getDiagramResourceName());
			// 响应流
			try {
				IOUtils.copy(is, response.getOutputStream());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			return null;
		}
		
		//"/workflow/coordXY?taskId="+taskID;
		@RequestMapping("/coordXY")
		@ResponseBody
		public Map<String,Object> coordXY(String taskId , String diagramResourceName, HttpServletResponse response){
//			ProcessDefinition pd = this.workFlowService.getProcessDefinitionByTaskId(taskId);
//			List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
//			Map<String,Object> map = new HashMap<String, Object>();
			
			
			// 3.获取当前活动的坐标
			Map<String,Object> currentActivityCoordinates = this.workFlowService.getCurrentActivityCoordinates(taskId);
//			map.put("acs", currentActivityCoordinates);
//			list.add(currentActivityCoordinates);
//			list.add(map);
			System.out.println(currentActivityCoordinates);
			return currentActivityCoordinates;
		
		
		}
		
}
