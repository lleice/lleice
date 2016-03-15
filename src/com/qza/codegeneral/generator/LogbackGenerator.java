package com.qza.codegeneral.generator;

import java.util.List;

import com.qza.codegeneral.util.FileUtils;
import com.qza.codegeneral.util.PropertiesUtils;

public class LogbackGenerator extends BaseGenerator {

	public static void generateLogback(List<String> tableList){
		generateLogback();
	}
	
	private static void generateLogback() {
		String template = "logback.t";
		String content = FileUtils.getTemplate(template);
		content = content.replaceAll("[$][{]package}", PropertiesUtils.getPackage()).replaceAll( "[$][{]projectName}", PropertiesUtils.getProject() );
		generateFile(content,template);
	}
	
	private static void generateFile(String content, String template){
		String name = template.substring(template.indexOf("/")+1,template.indexOf("."));
		FileUtils.write(content, PropertiesUtils.getLocation()+"/resources/" + name + ".xml");
	}
	
	
}
