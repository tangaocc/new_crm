/*function customerFormatters(v,r,i){
	//return v==0?"潜在客户":"<font style='color:red'>正式客户</font>";
	
	if(v==0){
		return "<span class='badge color-green' style='font-weight:bold;'>正式客户</span>";
	}else if(v==1){
		return "<span class='badge color-orange' style='font-weight:bold;'>第一次接触</span>";
	}else if(v==2){
		return "<span class='badge color-orange' style='font-weight:bold;'>第二次接触</span>";
	}else if(v==3){
		return "<span class='badge color-orange' style='font-weight:bold;'>第三次接触</span>";
	}else if(v==4){
		return "<span class='badge color-orange' style='font-weight:bold;'>第四次接触</span>";
	}else if(v==11){
		return "<span class='badge color-blue' style='font-weight:bold;'>报备中ing</span>";
	}else if(v==12){
		return "<span class='badge color-green' style='font-weight:bold;'>报备通过！</span>";
	}else if(v==666){
		return "<span class='badge color-orange' style='font-weight:bold;'>潜在客户</span>";
	}else if(v==-1){
		return "<span class='badge color-orange' style='font-weight:bold;'>潜在客户</span>";
	}
		//return "<span class='badge color-red' style='font-weight:bold;'>正式客户</span>";
		
	
}*/
/**
 *  value：字段值。
	row：行记录数据。
    index: 行索引。 
 * 
 */
function customerFormatter(v,r,i){
	if (v) {
		return v.name;
	}
}
function stateFormatter(v,r,i){
	//v:就是字段值：0  -1
	return  v==0?"<font color='green'>正常</font>":"<font color='red'>停用</font>";
}
function traceResultFormatter(v,r,i){
	if (v==-1) {
		return "<font color='red'>差</font>";
	}else if (v==0) {
		return "<font color='blue'>中</font>";
	}else {
		return "<font color='green'>优</font>";
	}
}

function customerStateFormatter(v,r,i){
	//v:就是字段值：0  1
	if(v==-1){
		return "<font color='blue'>潜在客户</font>";
	}else if(v==0){
		return "<font color='green'>正式客户</font>";
	}else if(v==1){
		return "<font color='orange'>第一次跟进客户</font>";
	}else if(v==2){
		return "<font color='orange'>第二次跟进客户</font>";
	}else if(v==11){
		return "<span class='badge color-blue' style='font-weight:bold;'>报备中ing</span>";
	}else if(v==12){
		return "<span class='badge color-green' style='font-weight:bold;'>报备通过！</span>";
	}else {
		return "<font color='red'>无法跟进客户</font>";
	}
}	

function dataFormatter(v,r,i){
	
	if (v) {
		
		return  v.name||v.requence||v.intro||v.sn;
	}
}
function genderFormatter(v, r, i) {
//	return value ==0 ? "未知" : value ==1 ? "男" : value ==-1 ? "女";
	
	if(v ==-1){
		return  "<font color='green'>女</font>";
	}else if(v ==1){
		return  "<font color='green'>男</font>";
	}
	return  "<font color='purple'>嘿嘿嘿</font>";
}

/**
 * 对象的格式化
 * @param v
 * @param r
 * @param i
 * @returns
 */
function objFormatter(v,r,i){
	//当v是Employee的时候：就存在realName值
	//当v是Department的时候：就存在name值
	//  ||或
	//return v?v.name||v.realName:"";
	if (v) {
		return v.name||v.realName||v.title||v.sn ;
	}
}
function potentialCustomerFormatter(v,r,i){
	if (v) {
		return v.name;
	}
}

/*
 * 展示名字  数组     如role页面展示拥有的多个权限
 */
function arrayFormatter(v,r,i) {
	//把p.name拼接起来，用逗号分离
	res="";
	$.each(v,function(index,p){
		if (index==v.length-1) {
			
			res = res + p.name;
		}else{
			res = res + p.name +",";
			
		}
		
	})
	return res;
	
	
}



// 5、对页面所有按钮，统一监听
$("a[data-cmd]").click(function(){
	   //5.1 获取cmd以便于区分是哪个超链接
	   var cmd = $(this).data("cmd");//add
	   //5.2 完成对应方法调用
	   /*方案1：判断分别执行-垃圾
	   if(cmd="add")
	   {
	  	 cmdObj.add();
	   }
	   if(cmd="edit")
	   {
	  	 cmdObj.edit();
	   }*/
	   //方案2：动态调用
	   //判断定义了cmd，并且没有被禁用
	   if (cmd && !$(this).hasClass("l-btn-disabled")) 
	   {
	  	 cmdObj[cmd]();
	   }
});



//扩展序列化方法
$.fn.serializeForm = function() {
	var paramObj = {};
	
	////{'q': '1','state': 0}序列化他的格式
	//[{name: "q", value: "1"},{name: "state", value: "0"}]
	var paramArray = $(this).serializeArray();
	$.each(paramArray,function(index,obj){
		var attrName = obj.name;
		var attrValue = obj.value;
		paramObj[attrName] = attrValue;
	})
	return paramObj;
	
}

