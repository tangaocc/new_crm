package cn.tencent.crm.service.impl;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipInputStream;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.repository.DeploymentBuilder;
import org.activiti.engine.repository.DeploymentQuery;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import cn.tencent.crm.service.IWorkFlowService;
import cn.tencent.crm.util.CommUtil;
import cn.tencent.crm.util.UserContext;


@Service
public class WorkServiceImpl implements IWorkFlowService {
	@Autowired
	private RepositoryService repositoryService;
	@Autowired
	private RuntimeService runtimeService;
	@Autowired
	private TaskService taskService;
	
	
	@Override
	public void newDeploy(String name, InputStream processFileInputStream) {
		ZipInputStream zis = null;
		zis = new ZipInputStream(processFileInputStream);
		//获取服务-RopsitoryService
		//做部署
		   //创建配置对象
		try {
			DeploymentBuilder builder = repositoryService.createDeployment();
			builder.name(name)
					.addZipInputStream(zis);
			
			//部署
			builder.deploy();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if (zis != null) {
				try {
					zis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (processFileInputStream != null) {
				try {
					processFileInputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
	}

	
	
	@Override
	public List<Map<String,Object>> listProcessDefinitions() {
		//创建查询对象
		ProcessDefinitionQuery query = repositoryService
				.createProcessDefinitionQuery();
		//设置查询条件-排序(相同流程放到一起,按版本号倒叙排)
		query.orderByProcessDefinitionKey().desc()
		     .orderByProcessDefinitionVersion().desc();
		//做查询
		List<ProcessDefinition> list = query.list();
		
		//转换步骤
		//1)申明要返回类型
		List<Map<String,Object>> result = new ArrayList<>();
		//2)进行转换
		for (ProcessDefinition processDefinition : list) {
			//一个processDefinition就对应一个Map
			result.add(processDefinition2Map(processDefinition));
		}
		//3)返回
		return result;
	}
	private Map<String, Object> processDefinition2Map(ProcessDefinition processDefinition) {
		/*
		//1)申明要返回类型
		 Map<String, Object> result = new HashMap<>();
		//2)进行转换
		 result.put("id", processDefinition.getId());
		//3)返回
		return result;*/
		//工具类转换
		Map<String, Object> obj2map = CommUtil.obj2map(processDefinition, 
				new String[]{"id","name","key"
				,"version","deploymentId","resourceName"
				,"diagramResourceName","description"});
		/*
		 * 
		 * 直接用方法判断有没有挂机再传map改状态
		 */
		
		//boolean b = repositoryService.isProcessDefinitionSuspended(processDefinition.getId());//String processDefinitionId
		boolean b = processDefinition.isSuspended();
		if(b==true){
			obj2map.put("pstate", -1);
			
		}else{
			obj2map.put("pstate", 0);
			
		}
		return obj2map;
		
	}
	


	//查看试图
	@Override
	public InputStream viewProcessDiagram(String deploymentId, String diagramResourceName) {
		InputStream resourceAsStream = repositoryService.getResourceAsStream(deploymentId, diagramResourceName);
		return resourceAsStream;
	
	}



	@Override
	public void deleteById(String deploymentId) {
		repositoryService.deleteDeployment(deploymentId);
		
	}
	//挂起
	@Override
	public void suspendProcessDefinitionByKey(String processDefinitionKey,Integer pstate) {
		pstate = -1;
		repositoryService.suspendProcessDefinitionByKey(processDefinitionKey);
			
			
		}
	//激活
	@Override
	public void activateProcessDefinitionByKey(String processDefinitionKey, Integer pstate) {
		pstate = 0;
		repositoryService.activateProcessDefinitionByKey(processDefinitionKey);
		
	}
	

	//开启流程
	@Override
	public void startProcess(String processDefinitionKey, Map<String, Object> variables) {
		ProcessInstance processInstance = runtimeService.startProcessInstanceByKey(processDefinitionKey, variables);
		//processInstance.isSuspended();判断是否是挂起的API
	}


	//查任务时，把三个值一起返回formKey/busniessObjId/busniessObjType
	@Override
	public List<Map<String, Object>> listpersonalTasks(String assignee) {
		//创建查询对象
		TaskQuery taskQuery = taskService.createTaskQuery();
	
		//设置查询条件-排序(相同流程放到一起,按版本号倒叙排)
		taskQuery.taskAssignee(assignee)
				 .orderByProcessDefinitionId().desc()
				 .orderByTaskCreateTime().desc();
		//做查询
		List<Task> list = taskQuery.list();
		
		//转换步骤
		//1)申明要返回类型
		List<Map<String,Object>> result = new ArrayList<>();
		//2)进行转换
		for (Task task : list) {
			//一个processDefinition就对应一个Map
			result.add(task2Map(task));
		}
		//3)返回
		return result;
		
		
		
	}
	private Map<String, Object> task2Map(Task task) {
		//一个Task就是一个Map
		Map<String, Object> obj2map = CommUtil.obj2map(task, new String[]{"id","name",
				"assignee","createTime","description"});
		//为了做动态表单,需要将formKey,bisinessObjType,bisinessObjId这三个参数一起返回
		obj2map.put("formKey", getFormKey(task));		
		obj2map.put("businessObjType", getBusinessObjType(task));		
		obj2map.put("businessObjId", getBusinessObjId(task));		
		obj2map.put("taskId", task.getId());		
		
		
		return obj2map;
	}
	//获取FormKey
		private String getFormKey(Task task) {
			//方案1:通过task直接获取FormKey-兼容性问题,低版本没有5.13级以前的都没有
			String formKey = task.getFormKey();
			//方案2:使用FormService的getTaskFormKey方法获取即可
			/*
			formKey = formService
					.getTaskFormKey(task.getProcessDefinitionId(), task.getTaskDefinitionKey());*/
			//方案3::使用FormService的getTaskFormData获取TaskFormData,
			//TaskFormData里面就有获取formKey和FormProperties的方法  :适用于第一种方案
			/*
			formKey = formService.getTaskFormData(task.getId()).getFormKey();*/
			return formKey;
		}
		//获取业务对象类型-从流程变量获取即可
		private String getBusinessObjType(Task task) {
			//Customer LeaveBill
			String businessObjType = taskService.getVariable(task.getId(), "businessObjType", String.class);
			businessObjType = businessObjType.substring(0, 1).toLowerCase()+businessObjType.substring(1);
			return businessObjType;
		}
		//获取业务对象Id-从流程变量获取即可
		private Long getBusinessObjId(Task task) {
			return taskService.getVariable(task.getId(), "businessObjId", Long.class);
		}



		@Override
		public void completeTask(String taskId,Boolean flag) {
			taskService.setVariable(taskId, "flag", flag);
			Boolean variable = taskService.getVariable(taskId,"flag",Boolean.class);
			
			taskService.complete(taskId);
			
		}

		
		
		
		@Override
		public ProcessDefinition getProcessDefinitionByTaskId(String taskId) {
			// 1. 得到task
			Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
			// 2. 通过task对象的pdid获取流程定义对象
			ProcessDefinition pd = repositoryService.getProcessDefinition(task.getProcessDefinitionId());
			return pd;
		}
		
		@Override
		public Map<String, Object> getCurrentActivityCoordinates(String taskId) {
			Map<String, Object> coordinates = new HashMap<String, Object>();
			// 1. 获取到当前活动的ID
			Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
			ProcessInstance pi = runtimeService.createProcessInstanceQuery().processInstanceId(task.getProcessInstanceId()).singleResult();
			String currentActivitiId = pi.getActivityId();
			// 2. 获取到流程定义
			ProcessDefinitionEntity pd = (ProcessDefinitionEntity) repositoryService.getProcessDefinition(task.getProcessDefinitionId());
			// 3. 使用流程定义通过currentActivitiId得到活动对象
			ActivityImpl activity =  pd.findActivity(currentActivitiId);
			// 4. 获取活动的坐标
			coordinates.put("X", activity.getX());
			coordinates.put("Y", activity.getY());
			coordinates.put("Width", activity.getWidth());
			coordinates.put("Height", activity.getHeight());
			return coordinates;
		}

		@Override
		public void submitTask(String taskId,String outcome,String comment) {
			Map<String, Object> vars = new HashMap<>();
			vars.put("outcome", outcome);
			// 由于流程用户上下文对象是线程独立的，所以要在需要的位置设置，要保证设置和获取操作在同一个线程中
			Authentication.setAuthenticatedUserId(UserContext.getUser().getRealName());
			// 添加批注信息
			taskService.addComment(taskId, null, comment);
			// 完成任务
			taskService.complete(taskId,vars);
		}
		/*
		 * 通过活动对象获取线的名字
		 */
		@Override
		public List<String> getOutGoingTransNames(String taskId) {
			List<String> transNames = new ArrayList<>();
			// 1.获取流程定义
			Task task = this.taskService.createTaskQuery().taskId(taskId).singleResult();
			ProcessDefinitionEntity pd = (ProcessDefinitionEntity) repositoryService.getProcessDefinition(task.getProcessDefinitionId());
			// 2.获取流程实例
			ProcessInstance pi =runtimeService.createProcessInstanceQuery().processInstanceId(task.getProcessInstanceId()).singleResult(); 
			// 3.通过流程实例查找当前活动的ID
			String activitiId = pi.getActivityId();
			// 4.通过活动的ID在流程定义中找到对应的活动对象
			ActivityImpl activity = pd.findActivity(activitiId);
			// 5.通过活动对象找当前活动的所有出口
			 List<PvmTransition> transitions =  activity.getOutgoingTransitions();
			// 6.提取所有出口的名称，封装成集合
			 for (PvmTransition trans : transitions) {
				 String transName = (String) trans.getProperty("name");
				 if(StringUtils.isNotBlank(transName)){
					 transNames.add(transName);
				 }
			}
			 if(transNames.size()==0){
				 transNames.add("提交");
			 }
			return transNames;
		}
/*		@Override
		public List<Comment> getProcessComments(String taskId) {
			List<Comment> historyCommnets = new ArrayList<>();
//			 1) 获取流程实例的ID
			Task task = this.taskService.createTaskQuery().taskId(taskId).singleResult();
			ProcessInstance pi =runtimeService.createProcessInstanceQuery().processInstanceId(task.getProcessInstanceId()).singleResult();
//	       2）通过流程实例查询所有的(用户任务类型)历史活动   
			List<HistoricActivityInstance> hais = historyService.createHistoricActivityInstanceQuery().processInstanceId(pi.getId()).activityType("userTask").list();
//	       3）查询每个历史任务的批注
			for (HistoricActivityInstance hai : hais) {
				String historytaskId = hai.getTaskId();
				List<Comment> comments = taskService.getTaskComments(historytaskId);
				// 4）如果当前任务有批注信息，添加到集合中
				if(comments!=null && comments.size()>0){
					historyCommnets.addAll(comments);
				}
			}
//	       5）返回
			 return historyCommnets;
		}	*/
		
		
		
		
		
		
		
		
		
		


		@Override
		public List<String> getTransNames(String taskId) {
			Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
			List<String> variableNames = new ArrayList();
			Map<String, Object> variables = taskService.getVariables(taskId, variableNames);
			
			String processInstanceId = task.getProcessInstanceId();
			
			
			return null;
		}


		
		
		
		
		
		
		

		@Override
		public List<Map<String, Object>> listcommonTasks() {
			//创建查询对象
			TaskQuery taskQuery = taskService.createTaskQuery();
			
			// b 设置查询条件
			String candidateUser = "伦伦";
			//taskQuery.taskCandidateUser(candidateUser);
//			taskQuery.orderByProcessInstanceId().desc();
//			taskQuery.orderByTaskCreateTime().desc();
			
			// 3、调用服务的特定方法做事
		  //  taskService.claim(taskId, userId)
			//设置查询条件-排序(相同流程放到一起,按版本号倒叙排)
			taskQuery
					 .orderByProcessDefinitionId().desc()
					 .orderByTaskCreateTime().desc();
			//做查询
			List<Task> list = taskQuery.list();
			
			//转换步骤
			//1)申明要返回类型
			List<Map<String,Object>> result = new ArrayList<>();
			//2)进行转换
			for (Task task : list) {
				//一个processDefinition就对应一个Map
				result.add(task2Map(task));
			}
			//3)返回
			return result;
		}


	






	
	
	

}
