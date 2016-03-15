package com.qza.codegeneral.generator;

import java.util.List;

import com.qza.codegeneral.util.FileUtils;
import com.qza.codegeneral.util.PropertiesUtils;


public class ProjectGenerator extends BaseGenerator{

	public static void generateProject(String project,List<String> tableList) {
		try {
			FileUtils.unZip(PropertiesUtils.getLocation());
			//generate constant
			ConstGenerator.generateConst();
			//generate config files in Web-Inf
			ConfigGenerator.generateConfig(tableList);
			
			CacheControlHeaderFilterGenerator.generateCacheControlHeaderFilter( tableList );
			ShiroGenerator.generateShiro();
			LogbackGenerator.generateLogback( tableList );
			WebGenerator.generateWeb( tableList );
			
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		
	}
}
