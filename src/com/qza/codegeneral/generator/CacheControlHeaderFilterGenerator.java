package com.qza.codegeneral.generator;

import java.util.List;

import com.qza.codegeneral.util.FileUtils;
import com.qza.codegeneral.util.PropertiesUtils;

public class CacheControlHeaderFilterGenerator extends BaseGenerator {

	public static void generateCacheControlHeaderFilter(List<String> tableList){
		generateCacheControlHeaderFilter();
	}
	
	private static void generateCacheControlHeaderFilter() {
		String template = "CacheControlHeaderFilter.t";
		String content = FileUtils.getTemplate(template);
		content = content.replaceAll("[$][{]package}", PropertiesUtils.getPackage());
		generateFile(content,template);
	}
	
	private static void generateFile(String content, String template){
		String name = template.substring(template.indexOf("/")+1,template.indexOf("."));
		FileUtils.write(content, PropertiesUtils.getLocation()+"/src/"+PropertiesUtils.getPackage().replaceAll("[.]", "/")+"/" + name + ".java");
	}
	
}
