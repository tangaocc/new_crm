package cn.tencent.crm.annotation.creat;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.springframework.web.bind.annotation.RequestMapping;

import cn.tencent.crm.annotation.OwnPermission;
import cn.tencent.crm.annotation.ScanPackage;
import cn.tencent.crm.domain.Permission;

/**
 * 这个工具类用来拿到被扫描包的所有类的注解,并把数据封装进Permission
 * 
 * @author tangao
 *
 */
public class CreatePermissionUtil {
	
	/**
	 * 传入数据库查询出来的数据,返回与数据库数据不同的对象集合;
	 * @param param
	 * @return
	 */
	public static List<Permission> encapsulationAnnoPermission(List<Permission> dataBaseParam,String packageName) {
		// 定义装Permission的集合;
		List<Permission> allPermission = new ArrayList<>();

		// 用来装数据库中存在的sn的集合;
		List<String> dbSns = new ArrayList<>();
		// 遍历传进来的数组;
		for (Permission permission : dataBaseParam) {
			// 把查询出来的sn装到sn集合中;
			dbSns.add(permission.getSn());
		}

		// 权限名字;
		String name = "";
		// 权限sn
		String sn = "";
		// 权限url;
		String resource = "";
		// 访问路径
		String mappingUrl = "";
		// 方法的mapingUrl;
		String methodMappingUrl = "";
		//权限的状态
		Integer state = 0;

		// 先扫描Contoller包;用工具类ScanPackage;得到该包的所有类的字节码对象;
		Set<Class<?>> allControlerClass = ScanPackage.getClasses(packageName);
		// 遍历得到的所有字节码对象;
		for (Class<?> controllerClass : allControlerClass) {
			// 这是类上的;
			OwnPermission classOwnAnno = controllerClass.getDeclaredAnnotation(OwnPermission.class);
			// 这个RequestMapping是通用的;都需要用它来进行拼接前缀;
			RequestMapping classMvcAnno = controllerClass.getDeclaredAnnotation(RequestMapping.class);
			// 如果类上的不为空,就表示该类都需要权限,但是可以拥有这个权限就可以访问该类的所有方法;
			// 或者说该类的所有方法都需要权限;
			if (classOwnAnno != null && classMvcAnno != null) {
				// 拿到类上注解配置的权限名字;
				name = classOwnAnno.value();
				// 拿到springMVC的@RequestMapping注解的值;取第一个是因为得到的是一个数据,数据放在第一个;
				mappingUrl = classMvcAnno.value()[0];
				// 拼接sn:截取mapping拼接*;
				sn = mappingUrl.substring(1) + ":*";
				// 拼接resource;
				resource = mappingUrl + "/*";
				// 如果数据库中没有此权限才去添加
				if (!dbSns.contains(sn)) {
					Permission permission = new Permission(name, sn, resource,state);
					allPermission.add(permission);
				}
			} else if (classOwnAnno == null) {
				// 类上的自定义注解为null就表示方法上有自定义注解;
				Method[] methods = controllerClass.getDeclaredMethods();
				for (Method method : methods) {
					// 类上的注解定义变量;
					// 拿到方法上的自定义注解;
					OwnPermission methodOwnAnno = method.getDeclaredAnnotation(OwnPermission.class);
					// 拿到springMVC的注解;
					RequestMapping methodMvcAnno = method.getDeclaredAnnotation(RequestMapping.class);
					// 如果类上有自定义注解;
					if (methodOwnAnno != null) {
						// 判断类上是否有springmvc的 注解
						if (classMvcAnno != null) {
							// 拿到类上的mapping映射路径;
							mappingUrl = classMvcAnno.value()[0];
						} else {
							mappingUrl = "";
						}
						// 权限名称;
						name = methodOwnAnno.value();
						/**
						 *  方法的访问路径sn;
						 */
						methodMappingUrl = methodMvcAnno.value()[0];
						if ("".equals(mappingUrl) || mappingUrl == null) {
							// 拼接sn:xx:oo
							sn = "defalut:" + methodMappingUrl.substring(1);
						} else {
							// 拼接sn:xx:oo
							sn = mappingUrl.substring(1) + ":" + methodMappingUrl.substring(1);
						}
						// 拼接resource;/xx/oo
						resource = mappingUrl + methodMappingUrl;

						// 如果数据库中没有此权限才去添加
						if (!dbSns.contains(sn)) {
							Permission permission = new Permission(name, sn, resource,state);
							allPermission.add(permission);
						}
					}
				}
			}
		}

		return allPermission;
	}
	
	/**
	 * 方法重载:这个方法是可以拿到包里面所以标注了注解的对象集合;
	 * @return
	 */
	public static List<Permission> encapsulationAnnoPermission(String packageName) {
		// 定义装Permission的集合;
		List<Permission> allPermission = new ArrayList<>();

		// 权限名字;
		String name = "";
		// 权限sn
		String sn = "";
		// 权限url;
		String resource = "";
		// 访问路径
		String mappingUrl = "";
		// 方法的mapingUrl;
		String methodMappingUrl = "";
		//权限的状态
		Integer state = 0;
				
				
		// 先扫描Contoller包;用工具类ScanPackage;得到该包的所有类的字节码对象;
		Set<Class<?>> allControlerClass = ScanPackage.getClasses(packageName);
		// 遍历得到的所有字节码对象;
		for (Class<?> controllerClass : allControlerClass) {
			// 这是类上的;
			OwnPermission classOwnAnno = controllerClass.getDeclaredAnnotation(OwnPermission.class);
			// 这个RequestMapping是通用的;都需要用它来进行拼接前缀;
			RequestMapping classMvcAnno = controllerClass.getDeclaredAnnotation(RequestMapping.class);
			// 如果类上的不为空,就表示该类都需要权限,但是可以拥有这个权限就可以访问该类的所有方法;
			// 或者说该类的所有方法都需要权限;
			if (classOwnAnno != null && classMvcAnno != null) {
				// 拿到类上注解配置的权限名字;
				name = classOwnAnno.value();
				// 拿到springMVC的@RequestMapping注解的值;取第一个是因为得到的是一个数据,数据放在第一个;
				mappingUrl = classMvcAnno.value()[0];
				// 拼接sn:截取mapping拼接*;
				sn = mappingUrl.substring(1) + ":*";
				// 拼接resource;
				resource = mappingUrl + "/*";
				// 如果数据库中没有此权限才去添加
				Permission permission = new Permission(name, sn, resource,state);
				allPermission.add(permission);
			} else if (classOwnAnno == null) {
				// 类上的自定义注解为null就表示方法上有自定义注解;
				Method[] methods = controllerClass.getDeclaredMethods();
				for (Method method : methods) {
					// 类上的注解定义变量;
					// 拿到方法上的自定义注解;
					OwnPermission methodOwnAnno = method.getDeclaredAnnotation(OwnPermission.class);
					// 拿到springMVC的注解;
					RequestMapping methodMvcAnno = method.getDeclaredAnnotation(RequestMapping.class);
					// 如果类上有自定义注解;
					if (methodOwnAnno != null) {
						// 判断类上是否有springmvc的 注解
						if (classMvcAnno != null) {
							// 拿到类上的mapping映射路径;
							mappingUrl = classMvcAnno.value()[0];
						} else {
							mappingUrl = "";
						}
						// 权限名称;
						name = methodOwnAnno.value();
						// 方法的访问路径;
						methodMappingUrl = methodMvcAnno.value()[0];
						if ("".equals(mappingUrl) || mappingUrl == null) {
							// 拼接sn:xx:oo
							sn = "defalut:" + methodMappingUrl.substring(1);
						} else {
							// 拼接sn:xx:oo
							sn = mappingUrl.substring(1) + ":" + methodMappingUrl.substring(1);
						}
						/**
						 *  拼接resource;/xx/oo
						 */
						resource = mappingUrl + methodMappingUrl;

						// 如果数据库中没有此权限才去添加
						Permission permission = new Permission(name, sn, resource,state);
						allPermission.add(permission);
					}
				}
			}
		}

		return allPermission;
	}
	
	public static void main(String[] args) {
		List<Permission> permission = CreatePermissionUtil.encapsulationAnnoPermission("cn.tencent.crm.web.controller");
		
		
		for (Permission permission2 : permission) {
			System.out.println(permission2);
			
			
		}
	}
}
