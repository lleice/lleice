package com.qza.codegeneral.generator;

import com.qza.codegeneral.util.FileUtils;
import com.qza.codegeneral.util.PropertiesUtils;


public class ConstGenerator extends BaseGenerator{

	public static void generateConst() {
		String template = "const.t";
		String content = FileUtils.getTemplate(template);
		content = content.replaceAll("[$][{]package}", PropertiesUtils.getPackage());
		FileUtils.write(content, FileUtils.getPackageDirectory("constant")+"Const.java");
	}

}
