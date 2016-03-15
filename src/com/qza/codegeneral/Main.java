package com.qza.codegeneral;

import java.util.List;
import java.util.Map;

import com.qza.codegeneral.generator.ControllerGenerator;
import com.qza.codegeneral.generator.EntityGenerator;
import com.qza.codegeneral.generator.JspGenerator;
import com.qza.codegeneral.generator.MapperGenerator;
import com.qza.codegeneral.generator.MapperXMLGenerator;
import com.qza.codegeneral.generator.ProjectGenerator;
import com.qza.codegeneral.generator.ServiceGenerator;
import com.qza.codegeneral.util.DBUtils;
import com.qza.codegeneral.util.FileUtils;
import com.qza.codegeneral.util.PropertiesUtils;

public class Main {

	public static void main(String[] args) {
		FileUtils.createPackageDirectory();
		String primaryKey = null;
		List<String> tableList = null;
		try {
			tableList = PropertiesUtils.getTableList();
			if (tableList.size() == 0) {
				tableList = DBUtils.getAllTables();
			}
		} catch (Exception e) {
			System.err.println("connection exception, please check it.");
			return;
		}
//		解压压缩包  暂屏蔽
//		String project = PropertiesUtils.getProject();
//		if (project != null && !"".equals(project)) {		
//			ProjectGenerator.generateProject(project,tableList);   
//			System.out.println(project + " framework has been generated.");
//		}
		for (String tableName : tableList) {   
			try {
				Map<String, String> pkMap = DBUtils.getPrimaryKey(tableName);
				primaryKey = pkMap.get("primaryKey");
			} catch (Exception e) {
				System.err.println(tableName + " doesn't exist or connection exception, please check it.");
				return;
			}
			if (primaryKey != null) {
				String layers = PropertiesUtils.getLayers();
				if(layers.contains("controller")){
					ControllerGenerator.generateController(tableName);
				}if(layers.contains("mapper")){
					MapperGenerator.generateMapper(tableName);
				}if(layers.contains("mapperxml")){
					MapperXMLGenerator.generateXMLMapper(tableName);
				}if(layers.contains("service")){
					ServiceGenerator.generateService(tableName);
				}if(layers.contains("entity")){
					EntityGenerator.generateEntity(tableName);
				}if(layers.contains("jsp")){
					JspGenerator.generateJsp(tableName);
				} 
				System.out.println(tableName + " has been generated.");
			} else {
				System.err.println(tableName + " has no pk, ignored.");
			}
		}
		
		System.out.println("All finished.");
	}
}
