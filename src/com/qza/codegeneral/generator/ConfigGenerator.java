package com.qza.codegeneral.generator;

import java.io.File;
import java.util.List;

import com.qza.codegeneral.util.FileUtils;
import com.qza.codegeneral.util.PropertiesUtils;


public class ConfigGenerator extends BaseGenerator{

	public static void generateConfig(List<String> tableList){
//		generateMybatisConfig(tableList);
//		generateSpringConfig();
//		generateSpringTestConfig();
		generateApplicationContextEhcacheConfig();
		generateApplicationContextMailConfig();
		generateApplicationContextSchedulerConfig();
		generateApplicationContextShiroConfig();
		generateApplicationContextConfig();
		generateSpringMVCConfig();
		generateJDBCConfig();
	}
//	private static void generateMybatisConfig(List<String> tableList) {
//		StringBuilder sb = new StringBuilder();
//		String template = "config/mybatis-config.t";
//		String content = FileUtils.getTemplate(template);
//		String mapperFilePath = PropertiesUtils.getPackage().replaceAll("[.]", "/")+"/dao/mapper/";
//		for(String tableName : tableList){
//			Map<String, String> pkMap = DBUtils.getPrimaryKey(tableName);
//			String primaryKey = pkMap.get("primaryKey");
//			if(primaryKey!=null){
//				sb.append("\t\t<mapper resource=\"").append(mapperFilePath).append(StringUtils.firstUpperAndNoPrefix(tableName))
//				.append("DaoMapper.xml\"/>\n");
//			}
//		}
//		content = content.replaceAll("[$][{]mapperResource}", sb.toString());
//		generateFile(content,template);
//		
//	}
	
	private static void generateApplicationContextEhcacheConfig() {
		String template = "config/applicationContext-ehcache.t";
		String content = FileUtils.getTemplate(template);
		content = content.replaceAll("[$][{]package}", PropertiesUtils.getPackage());
		generateFile(content,template);
	}
	
	private static void generateApplicationContextMailConfig() {
		String template = "config/applicationContext-mail.t";
		String content = FileUtils.getTemplate(template);
		content = content.replaceAll("[$][{]package}", PropertiesUtils.getPackage());
		generateFile(content,template);
	}
	
	private static void generateApplicationContextSchedulerConfig() {
		String template = "config/applicationContext-scheduler.t";
		String content = FileUtils.getTemplate(template);
		content = content.replaceAll("[$][{]package}", PropertiesUtils.getPackage());
		generateFile(content,template);
	}
	
	private static void generateApplicationContextShiroConfig() {
		String template = "config/applicationContext-shiro.t";
		String content = FileUtils.getTemplate(template);
		content = content.replaceAll("[$][{]package}", PropertiesUtils.getPackage());
		generateFile(content,template);
	}
	private static void generateApplicationContextConfig() {
		String template = "config/applicationContext.t";
		String content = FileUtils.getTemplate(template);
		content = content.replaceAll("[$][{]package}", PropertiesUtils.getPackage());
		generateFile(content,template);
	}
	private static void generateSpringMVCConfig() {
		String template = "config/spring-mvc.t";
		String content = FileUtils.getTemplate(template);
		content = content.replaceAll("[$][{]package}", PropertiesUtils.getPackage());
		generateFile(content,template);
	}
	private static void generateJDBCConfig(){
		String _url = ConfigGenerator.class.getClassLoader().getResource( "application.properties" ).getPath();
		File file = new File(_url);
		String content = FileUtils.read(file);
		FileUtils.write(content, PropertiesUtils.getLocation()+"/WebContent/WEB-INF/spring/application.properties");
	}
	private static void generateFile(String content, String template){
		String name = template.substring(template.indexOf("/")+1,template.indexOf("."));
		FileUtils.write(content, PropertiesUtils.getLocation()+"/WebContent/WEB-INF/spring/" + name + ".xml");
	}
	
}
