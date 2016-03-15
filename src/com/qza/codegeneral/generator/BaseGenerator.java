package com.qza.codegeneral.generator;

import java.util.Map;

import com.qza.codegeneral.util.DBUtils;
import com.qza.codegeneral.util.FileUtils;
import com.qza.codegeneral.util.PropertiesUtils;
import com.qza.codegeneral.util.StringUtils;

public class BaseGenerator {
	public static String replaceTableName = "0085_";
	public static String replaceTableValue = "";
	public static String generate(String template, String tableName) {  
		String content = FileUtils.getTemplate(template); 
		Map<String,String> pMap = DBUtils.getPrimaryKey(tableName); 
		tableName = tableName.replace(replaceTableName, replaceTableValue);
		String replacedContent = null;
		String ClassName = StringUtils.firstUpperAndNoPrefix(tableName);
		String className = StringUtils.formatAndNoPrefix(tableName);
		String packageName = PropertiesUtils.getPackage();
		String primaryKeyType = pMap.get("primaryKeyType");
		String primaryKey = StringUtils.format(pMap.get("primaryKey"));
		String PrimaryKey = StringUtils.firstUpperNoFormat(primaryKey);
		if(primaryKey!=null){
			replacedContent = content.replaceAll("[$][{]ClassName}", ClassName)
					.replaceAll("[$][{]className}", className)
					.replaceAll("[$][{]packageName}", packageName)
					.replaceAll("[$][{]primaryKeyType}", primaryKeyType)
					.replaceAll("[$][{]}", primaryKeyType)
					.replaceAll("[$][{]primaryKey}", primaryKey)
					.replaceAll("[$][{]PrimaryKey}", PrimaryKey);
		}
			
		
		return replacedContent;
	}
}
