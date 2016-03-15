package com.qza.codegeneral.generator;

import com.qza.codegeneral.util.FileUtils;
import com.qza.codegeneral.util.PropertiesUtils;

public class ShiroGenerator extends BaseGenerator {

	public static void generateShiro() {
		generateChainDefinitionSectionMetaSource();
		generateHttpCredentialsMatcher();
		generateHttpOAuthAuthenticationInfo();
		generateShiroDbReam();
    }
	
	private static void generateChainDefinitionSectionMetaSource() {
		String template = "shiro/ChainDefinitionSectionMetaSource.t";
		String content = FileUtils.getTemplate(template);
		content = content.replaceAll("[$][{]package}", PropertiesUtils.getPackage());
		generateFile(content,template);
	}
	
	private static void generateHttpCredentialsMatcher() {
		String template = "shiro/HttpCredentialsMatcher.t";
		String content = FileUtils.getTemplate(template);
		content = content.replaceAll("[$][{]package}", PropertiesUtils.getPackage());
		generateFile(content,template);
	}
	
	private static void generateHttpOAuthAuthenticationInfo() {
		String template = "shiro/HttpOAuthAuthenticationInfo.t";
		String content = FileUtils.getTemplate(template);
		content = content.replaceAll("[$][{]package}", PropertiesUtils.getPackage());
		generateFile(content,template);
	}
	
	private static void generateShiroDbReam() {
		String template = "shiro/ShiroDbRealm.t";
		String content = FileUtils.getTemplate(template);
		content = content.replaceAll("[$][{]package}", PropertiesUtils.getPackage());
		generateFile(content,template);
	}
	
	private static void generateFile(String content, String template){
		String name = template.substring(template.indexOf("/")+1,template.indexOf("."));
		FileUtils.write(content, PropertiesUtils.getLocation()+"/src/"+PropertiesUtils.getPackage().replaceAll("[.]", "/")+"/shiro/" + name + ".java");
	}
	
}
