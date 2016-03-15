package com.qza.codegeneral.generator;

import com.qza.codegeneral.util.FileUtils;
import com.qza.codegeneral.util.StringUtils;

public class ServiceGenerator extends BaseGenerator{
 
	public static void generateService(String tableName) {
		generateServices(tableName);
		generateServiceImpls(tableName);
	}
	
	public static void generateServices(String tableName) {
		String template = "service.t"; 
		String content = generate(template,tableName);
		tableName = tableName.replace(replaceTableName, replaceTableValue);
		FileUtils.write(content, FileUtils.getPackageDirectory("service")+StringUtils.firstUpperAndNoPrefix(tableName)+"Service.java");
	}
	
	public static void generateServiceImpls(String tableName) {
		String template = "serviceImpl.t"; 
		String content = generate(template,tableName);
		tableName = tableName.replace(replaceTableName, replaceTableValue);
		FileUtils.write(content, FileUtils.getPackageDirectory("service")+"impl/"+StringUtils.firstUpperAndNoPrefix(tableName)+"ServiceImpl.java");
	}
	
}
