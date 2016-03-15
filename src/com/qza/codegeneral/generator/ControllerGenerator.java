package com.qza.codegeneral.generator;

import java.util.Map;
import java.util.Set;

import com.qza.codegeneral.util.DBUtils;
import com.qza.codegeneral.util.FileUtils;
import com.qza.codegeneral.util.StringUtils;

public class ControllerGenerator extends BaseGenerator{

	public static void generateController(String tableName) {
		String template = "controller.t";
		String content = generate(template,tableName);
		
		Map<String,String> primaryKeyMap = DBUtils.getPrimaryKey(tableName);
		String primaryKey = primaryKeyMap.get("primaryKey");
		Map<String,String> fieldMap = DBUtils.getFormatedColumnNameTypeMap(tableName);  
		content = generateUpdateAssignValue(content, tableName.replace(replaceTableName, replaceTableValue), primaryKey, fieldMap);
		FileUtils.write(content, FileUtils.getPackageDirectory("controller")+StringUtils.firstUpperAndNoPrefix(tableName.replace(replaceTableName, replaceTableValue))+"AdminController.java");
		
		generateFrontController(tableName);
	}
	private static String generateUpdateAssignValue(String content, String tableName, String primaryKey, Map<String,String> fieldMap){
		StringBuilder sb = new StringBuilder().append("\n");
		Set<String> fieldNameSet = fieldMap.keySet();
		for(String name : fieldNameSet){
			if(!StringUtils.format(primaryKey).equals(name)&&!"createTime".equals(name)&&!"createBy".equals(name)&&!"updateTime".equals(name)&&!"updateBy".equals(name)){
				sb.append("\t\t\told").append(StringUtils.firstUpperAndNoPrefix(tableName)).append(".set").append(StringUtils.firstUpperNoFormat(name))
				.append("(").append(StringUtils.formatAndNoPrefix(tableName)).append(".get").append(StringUtils.firstUpperNoFormat(name)).append("());\n");
			}
			
		}
		
		String newContent = content.replaceAll("[$][{]updateAssignValue}", sb.toString()).replaceAll("[$][{]PrimaryKey}", StringUtils.firstUpperAndNoPrefix(primaryKey));
		return newContent;
	}
	
	public static void generateFrontController(String tableName) {
		String template = "frontcontroller.t";
		String content = generate(template,tableName); 
		Map<String,String> primaryKeyMap = DBUtils.getPrimaryKey(tableName);
		String primaryKey = primaryKeyMap.get("primaryKey");
		Map<String,String> fieldMap = DBUtils.getFormatedColumnNameTypeMap(tableName);

		tableName = tableName.replace(replaceTableName, replaceTableValue);
		content = generateUpdateAssignValue(content, tableName, primaryKey, fieldMap);
		FileUtils.write(content, FileUtils.getPackageDirectory("controller")+"front/"+StringUtils.firstUpperAndNoPrefix(tableName)+"Controller.java");
	}
}
