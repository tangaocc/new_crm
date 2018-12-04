package cn.tencent.crm.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 
 * @author 
 * 自定义权限标签
 * @Target:表示使用范围:下面表示可以在方法和类上使用;
 * @Retention:生命周期;
 * @Documented:文档;
 */
@Target({ElementType.METHOD,ElementType.TYPE})//定义注解的作用目标,作用范围字段,枚举的常量/方法  
@Retention(RetentionPolicy.RUNTIME)// 注解会在class字节码文件中存在，在运行时可以通过反射获取到
@Documented//说明该注解将被包含在javadoc中 
public @interface OwnPermission {
	//给个默认注属性,表示的就是注解时不写明属性,就传入到这个默认属性里面;
	String value() default "";
	//权限名字:默认为空
    String name() default "";
    //权限标识:默认为空
    String sn() default "";
    //资源路径:默认为空
    String resource() default "";
    //默认开启权限控制;
    boolean support() default true;
}