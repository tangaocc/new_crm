package cn.tencent.crm.service;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

import org.activiti.engine.repository.ProcessDefinition;

public interface IWorkFlowService {
	//部署新流程
	void newDeploy(String name,InputStream processFileInputStream);
//流程定义列表
	List<Map<String, Object>> listProcessDefinitions();

	InputStream viewProcessDiagram(String deploymentId, String diagramResourceName);

	
//删除流程
	void deleteById(String id);
//开启流程
	void startProcess(String processDefinitionKey, Map<String, Object> variables);
	//挂起
	void suspendProcessDefinitionByKey(String processDefinitionKey, Integer pstate);
	//激活
	void activateProcessDefinitionByKey(String processDefinitionKey, Integer pstate);

	//代办任务的LIST
	List<Map<String, Object>> listpersonalTasks(String assignee);
	
	void completeTask(String taskId, Boolean flag);
	
	
	List<String> getTransNames(String taskId);
	
	List<Map<String, Object>> listcommonTasks();
	Map<String, Object> getCurrentActivityCoordinates(String taskId);
	ProcessDefinition getProcessDefinitionByTaskId(String taskId);
	void submitTask(String taskId, String outcome, String comment);
	List<String> getOutGoingTransNames(String taskId);
}
