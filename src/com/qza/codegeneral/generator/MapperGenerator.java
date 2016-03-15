package com.qza.codegeneral.generator;

import com.qza.codegeneral.util.FileUtils;
import com.qza.codegeneral.util.PropertiesUtils;
import com.qza.codegeneral.util.StringUtils;

public class MapperGenerator extends BaseGenerator{

	public static void generateMapper(String tableName) {
		generateMapperJava(tableName);
		generateMyBatisRepository(tableName);
	}
	
	public static void generateMapperJava(String tableName) {
		String template = "mapper.t";
		String content = generate(template,tableName);
		tableName = tableName.replace(replaceTableName, replaceTableValue);
		FileUtils.write(content, FileUtils.getPackageDirectory("repository")+StringUtils.firstUpperAndNoPrefix(tableName)+"Mapper.java");
	}
	
	public static void generateMyBatisRepository(String tableName) {
		String template = "MyBatisRepository.t";
		String content = FileUtils.getTemplate(template);
		content = content.replaceAll("[$][{]package}", PropertiesUtils.getPackage());
		FileUtils.write(content,FileUtils.getPackageDirectory("repository") + "MyBatisRepository.java");
		
	}
}
