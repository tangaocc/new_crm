package cn.tencent.crm.util;

/**
 * Ajax请求返回对象，最终会被转换为json 控制好成功失败时  new AjaxResult()   new AjaxResult(String message) 
 * @author Administrator
 *
 */
public class AjaxResult {

	//是否成功
	private Boolean success = true;
	//提示消息
	private String message = "操作成功";
	
	public Boolean getSuccess() {
		return success;
	}
	public void setSuccess(Boolean success) {
		this.success = success;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	@Override
	public String toString() {
		return "AjaxResult [success=" + success + ", message=" + message + "]";
	}
	//失败的,给出失败提示信息。
	public AjaxResult(String message) {
		this.success = false;
		this.message = message;
	}
	//成功，不需要你做任何修改，使用默认值即可
	public AjaxResult() {
		super();
	}
	
	
	
}
