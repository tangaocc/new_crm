package cn.tencent.crm.web.controller;
import java.io.ByteArrayInputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.bpmn.converter.BpmnXMLConverter;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.Model;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

import cn.tencent.crm.util.AjaxResult;

/**
 * 流程模型控制器
 * 
 * @author xx
 */
@Controller
@RequestMapping(value = "/workflow/model")
public class ModelController {

  protected Logger logger = LoggerFactory.getLogger(getClass());

  @Autowired
  private RepositoryService repositoryService;

  /**
   * 模型页面
   */
  @RequestMapping(value = "/index")
  public String model() {
//	  ModelAndView mav = new ModelAndView("workflow/model");
//	  List list = repositoryService.createModelQuery().list();
//	  mav.addObject("list", list);
//	  return mav;
	  return "workFlow/model";
  }
  /**
   * 模型列表
   */
  @RequestMapping(value = "/list")
  @ResponseBody
  public List<Model> modelList() {
    List<Model> list = repositoryService.createModelQuery().list();
    return list;
  }

  /**
   * 创建模型
   */
  @RequestMapping(value = "/create")
  public void create(@RequestParam("name") String name, @RequestParam("key") String key, @RequestParam("description") String description,
          HttpServletRequest request, HttpServletResponse response) {
    try {
      // 创建编辑的节点
      ObjectMapper objectMapper = new ObjectMapper();
      ObjectNode editorNode = objectMapper.createObjectNode();
      editorNode.put("id", "canvas");
      editorNode.put("resourceId", "canvas");
      ObjectNode stencilSetNode = objectMapper.createObjectNode();
      stencilSetNode.put("namespace", "http://b3mn.org/stencilset/bpmn2.0#");
      editorNode.put("stencilset", stencilSetNode);
      
      // 创建模型对象
      Model modelData = repositoryService.newModel();

      
      // 封装模型对象
      ObjectNode modelObjectNode = objectMapper.createObjectNode();
      modelObjectNode.put(ModelDataJsonConstants.MODEL_NAME, name);
      modelObjectNode.put(ModelDataJsonConstants.MODEL_REVISION, 1);
      description = StringUtils.defaultString(description);
      modelObjectNode.put(ModelDataJsonConstants.MODEL_DESCRIPTION, description);
      modelData.setMetaInfo(modelObjectNode.toString());
      modelData.setName(name);
      modelData.setKey(StringUtils.defaultString(key));

      // 保存模型对象
      repositoryService.saveModel(modelData);
      
      // 保存该模型的编辑信息
      repositoryService.addModelEditorSource(modelData.getId(), editorNode.toString().getBytes("utf-8"));

// response.sendRedirect(request.getContextPath() + "/service/editor?id=" + modelData.getId());
      // 使用模型信息，打开Activiti-modeler编辑器
      response.sendRedirect(request.getContextPath() + "/resources/js/wf/modeler.html?modelId=" + modelData.getId());
    } catch (Exception e) {
      logger.error("创建模型失败：", e);
    }
  }

  /**
   * 根据Model部署流程
   */
  @RequestMapping(value = "/deploy/{modelId}")  //deploy/1 
  @ResponseBody
  public AjaxResult deploy(@PathVariable("modelId") String modelId, RedirectAttributes redirectAttributes) {
    try {
      // 获取模型信息
      Model modelData = repositoryService.getModel(modelId);
      // 读取模型的编辑器内容
      ObjectNode modelNode = (ObjectNode) new ObjectMapper().readTree(repositoryService.getModelEditorSource(modelData.getId()));
      byte[] bpmnBytes = null;

      // 解析编辑器的内容，把resultful数据转变为一个bpmn模型对象
      BpmnModel model = new BpmnJsonConverter().convertToBpmnModel(modelNode);
      // 再使用BpmnXML转换器，把内容解析为bpmn结构的xml
      bpmnBytes = new BpmnXMLConverter().convertToXML(model);

      // 以二进制方式，读取部署信息
      String processName = modelData.getName() + ".bpmn20.xml";
      Deployment deployment = repositoryService.createDeployment().name(modelData.getName()).addString(processName, new String(bpmnBytes)).deploy();
      redirectAttributes.addFlashAttribute("message", "部署成功，部署ID=" + deployment.getId());
    } catch (Exception e) {
      logger.error("根据模型部署流程失败：modelId={}", modelId, e);
      return new AjaxResult("根据模型部署流程失败！"+e.getMessage());
    }
    return new AjaxResult();
  }

  /**
   * 导出model的xml文件
   */
 /* @RequestMapping(value = "export/{modelId}")
  public void export(@PathVariable("modelId") String modelId, HttpServletResponse response) {
    try {
      Model modelData = repositoryService.getModel(modelId);
      BpmnJsonConverter jsonConverter = new BpmnJsonConverter();
      JsonNode editorNode = new ObjectMapper().readTree(repositoryService.getModelEditorSource(modelData.getId()));
      BpmnModel bpmnModel = jsonConverter.convertToBpmnModel(editorNode);
      BpmnXMLConverter xmlConverter = new BpmnXMLConverter();
      byte[] bpmnBytes = xmlConverter.convertToXML(bpmnModel);

      ByteArrayInputStream in = new ByteArrayInputStream(bpmnBytes);
      IOUtils.copy(in, response.getOutputStream());
      String filename = bpmnModel.getMainProcess().getId() + ".bpmn20.xml";
      response.setHeader("Content-Disposition", "attachment; filename=" + filename);
      response.flushBuffer();
    } catch (Exception e) {
      logger.error("导出model的xml文件失败：modelId={}", modelId, e);
    }
  }*/

}