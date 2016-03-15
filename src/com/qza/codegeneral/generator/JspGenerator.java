package com.qza.codegeneral.generator;

import java.util.List;
import java.util.Map;

import com.qza.codegeneral.util.DBUtils;
import com.qza.codegeneral.util.FileUtils;
import com.qza.codegeneral.util.PropertiesUtils;
import com.qza.codegeneral.util.StringUtils;


public class JspGenerator extends BaseGenerator{

	public static void generateJsp(String tableName) {
//		String template = "jsp.t";
		DBUtils.getAllTables();
		Map<String,String> map = DBUtils.getPrimaryKey(tableName);
		List<String> colList = DBUtils.getFormatedColumnNameList(tableName);
		String primaryKey = map.get("primaryKey"); 
		generateAdminListJsp(tableName, primaryKey, colList);
		generateAdminAddJsp(tableName, primaryKey, colList);
		generateAdminUpdateJsp(tableName, primaryKey, colList);
		generateAdminDetailsJsp(tableName, primaryKey, colList);
		
//		String content = generate(template,tableName);
//		content = generateForm(content,primaryKey,colList);
//		content = generateHead(content,primaryKey,colList);
//		content = generateBody(content,primaryKey,colList);
//		String project = PropertiesUtils.getProject();
//		String jspDir = null;
//		if(project!=null && !"".equals(project)){
//			jspDir = PropertiesUtils.getLocation()+"/WebContent/WEB-INF/views/";
//		}else{
//			jspDir = PropertiesUtils.getLocation()+"/views/";
//		}
//		FileUtils.write(content, jspDir + StringUtils.formatAndNoPrefix(tableName)+".jsp");
	}
//	private static String generateForm(String content, String primaryKey, List<String> colList){
//		StringBuilder sb = new StringBuilder();
//		for(String str: colList){
//			if(!StringUtils.format(primaryKey).equals(str)&&!"createTime".equals(str)&&!"createBy".equals(str)&&!"updateTime".equals(str)&&!"updateBy".equals(str)){
//				sb.append("\t\t\t\t<div class=\"control-group\">\n");
//				sb.append("\t\t\t\t\t<label class=\"control-label\" for=\"").append(str).append("\">").append(str).append("</label>\n");
//				sb.append("\t\t\t\t\t<div class=\"controls\">\n");
//				sb.append("\t\t\t\t\t\t<input type=\"text\" id=\"").append(str).append("\" name=\"").append(str).append("\"/>\n");
//				sb.append("\t\t\t\t\t</div>\n");
//				sb.append("\t\t\t\t</div>\n");
//			}
//		}
//		String newContent = content.replaceAll("[$][{]cgForm}", sb.toString());
//		return newContent;
//	}
//	private static String generateHead(String content, String primaryKey, List<String> colList){
//		StringBuilder sb = new StringBuilder();
//		for(String str: colList){
//			if(!StringUtils.format(primaryKey).equals(str)&&!"createTime".equals(str)&&!"createBy".equals(str)&&!"updateTime".equals(str)&&!"updateBy".equals(str)){
//				sb.append("\t\t\t\t\t<th>").append(str).append("</th>\n");
//			}
//		}
//		String newContent = content.replaceAll("[$][{]cgHead}", sb.toString());
//		return newContent;
//	}
//	private static String generateBody(String content, String primaryKey, List<String> colList){
//		StringBuilder sb = new StringBuilder();
//		for(String str: colList){
//			if(!StringUtils.format(primaryKey).equals(str)&&!"createTime".equals(str)&&!"createBy".equals(str)&&!"updateTime".equals(str)&&!"updateBy".equals(str)){
//				sb.append("\t\t\t\t\t\t<td class=\"").append(str).append("\">\\${item.").append(str).append("}</td>\n");
//			}
//		}
//		String newContent = content.replaceAll("[$][{]cgBody}", sb.toString());
//		return newContent;
//	}
	
	
	/**************************** Admin *****************************/
	
	private static void generateAdminListJsp(String tableName, String primaryKey, List<String> colList) {
		String template = "jsp-list.t";
		String content = generate(template,tableName); 
		tableName = tableName.replace(replaceTableName, replaceTableValue);
		
		content = generateAdminHead(content,primaryKey,colList);
		content = generateAdminBody(content,primaryKey,colList);
		
		String project = PropertiesUtils.getProject();
		String jspDir = null;
		if(project!=null && !"".equals(project)){
			jspDir = PropertiesUtils.getLocation()+"/WebContent/WEB-INF/views/admin/";
		}else{
			jspDir = PropertiesUtils.getLocation()+"/views/admin/";
		}
		
		FileUtils.mkdir(jspDir + StringUtils.formatAndNoPrefix(tableName));
		
		FileUtils.write(content, jspDir + StringUtils.formatAndNoPrefix(tableName)+"/list.jsp");
	}
	
	private static String generateAdminHead(String content, String primaryKey, List<String> colList){
		StringBuilder sb = new StringBuilder();
		for(String str: colList){
			if(!StringUtils.format(primaryKey).equals(str)&&!"createTime".equals(str)&&!"createBy".equals(str)&&!"updateTime".equals(str)&&!"updateBy".equals(str)){
				sb.append("\t\t\t\t\t\t\t<th>").append(str).append("</th>\n");
			}
		}
		String newContent = content.replaceAll("[$][{]cgHead}", sb.toString());
		return newContent;
	}
	
	private static String generateAdminBody(String content, String primaryKey, List<String> colList){
		StringBuilder sb = new StringBuilder();
		for(String str: colList){
			if(!StringUtils.format(primaryKey).equals(str)&&!"createTime".equals(str)&&!"createBy".equals(str)&&!"updateTime".equals(str)&&!"updateBy".equals(str)){
				sb.append("\t\t\t\t\t\t\t\t<td class=\"").append(str).append("\">\\${item.").append(str).append("}</td>\n");
			}
		}
		String newContent = content.replaceAll("[$][{]cgBody}", sb.toString());
		return newContent;
	}

	
	/**************************** Add *****************************/

	private static void generateAdminAddJsp(String tableName, String primaryKey, List<String> colList) {

		String template = "jsp-create.t";
		String content = generate(template,tableName); 
		tableName = tableName.replace(replaceTableName, replaceTableValue); 
		content = generateAdminAddField(content,primaryKey,colList); 
		
		String project = PropertiesUtils.getProject();
		String jspDir = null;
		if(project!=null && !"".equals(project)){
			jspDir = PropertiesUtils.getLocation()+"/WebContent/WEB-INF/views/admin/";
		}else{
			jspDir = PropertiesUtils.getLocation()+"/views/admin/";
		}
		
		FileUtils.mkdir(jspDir + StringUtils.formatAndNoPrefix(tableName));
		
		FileUtils.write(content, jspDir + StringUtils.formatAndNoPrefix(tableName)+"/create.jsp"); 
	}

	private static String generateAdminAddField(String content, String primaryKey, List<String> colList){
		StringBuilder sb = new StringBuilder();
		for(String str: colList){
			if(!StringUtils.format(primaryKey).equals(str)&&!"createTime".equals(str)&&!"createBy".equals(str)&&!"updateTime".equals(str)&&!"updateBy".equals(str)){
				sb.append("\t\t\t\t<div class=\"am-g am-margin-top\">\n");  
				sb.append("\t\t\t\t\t<div class=\"am-u-sm-4 am-u-md-2 am-text-right\">").append(str).append("</div>\n");
				sb.append("\t\t\t\t\t<div class=\"am-u-sm-8 am-u-md-4\"><input type=\"text\" class=\"am-input-sm\" ").append("name=\""+str+"\" placeholder=\"必填，不可重复\">").append("</div>\n");
				sb.append("\t\t\t\t\t<div class=\"am-hide-sm-only am-u-md-6\"></div>\n");
				sb.append("\t\t\t\t</div>\n");  
			}
		}
		String newContent = content.replaceAll("[$][{]cgFieId}", sb.toString());
		return newContent;
	} 
	

	/**************************** Update *****************************/ 
	private static void generateAdminUpdateJsp(String tableName, String primaryKey, List<String> colList) {

		String template = "jsp-update.t";
		String content = generate(template,tableName); 
		tableName = tableName.replace(replaceTableName, replaceTableValue); 
		content = generateAdminUpdateField(tableName,content,primaryKey,colList); 
		
		String project = PropertiesUtils.getProject();
		String jspDir = null;
		if(project!=null && !"".equals(project)){
			jspDir = PropertiesUtils.getLocation()+"/WebContent/WEB-INF/views/admin/";
		}else{
			jspDir = PropertiesUtils.getLocation()+"/views/admin/";
		}
		
		FileUtils.mkdir(jspDir + StringUtils.formatAndNoPrefix(tableName));
		
		FileUtils.write(content, jspDir + StringUtils.formatAndNoPrefix(tableName)+"/update.jsp"); 
	}
	
	private static String generateAdminUpdateField(String tableName,String content, String primaryKey, List<String> colList){
		StringBuilder sb = new StringBuilder();
		for(String str: colList){
			if(!StringUtils.format(primaryKey).equals(str)&&!"createTime".equals(str)&&!"createBy".equals(str)&&!"updateTime".equals(str)&&!"updateBy".equals(str)){
				sb.append("\t\t\t\t<div class=\"am-g am-margin-top\">\n");  
				sb.append("\t\t\t\t\t<div class=\"am-u-sm-4 am-u-md-2 am-text-right\">").append(str).append("</div>\n");
				sb.append("\t\t\t\t\t<div class=\"am-u-sm-8 am-u-md-4\"><input type=\"text\" class=\"am-input-sm\" ").append("name=\""+str+"\" value=\"\\${"+tableName +"."+str+"}\" >").append("</div>\n");
				sb.append("\t\t\t\t\t<div class=\"am-hide-sm-only am-u-md-6\"></div>\n");
				sb.append("\t\t\t\t</div>\n"); 
			}
		}
		String newContent = content.replaceAll("[$][{]cgFieId}", sb.toString());
		return newContent;
	} 
	
	
	/**************************** Details *****************************/

	private static void generateAdminDetailsJsp(String tableName, String primaryKey, List<String> colList) {

		String template = "jsp-detail.t";
		String content = generate(template,tableName); 
		tableName = tableName.replace(replaceTableName, replaceTableValue); 
		content = generateAdminDetailsField(tableName,content,primaryKey,colList); 
		
		String project = PropertiesUtils.getProject();
		String jspDir = null;
		if(project!=null && !"".equals(project)){
			jspDir = PropertiesUtils.getLocation()+"/WebContent/WEB-INF/views/admin/";
		}else{
			jspDir = PropertiesUtils.getLocation()+"/views/admin/";
		}
		
		FileUtils.mkdir(jspDir + StringUtils.formatAndNoPrefix(tableName));
		
		FileUtils.write(content, jspDir + StringUtils.formatAndNoPrefix(tableName)+"/detail.jsp"); 
	}

	private static String generateAdminDetailsField(String tableName ,String content, String primaryKey, List<String> colList){
		StringBuilder sb = new StringBuilder();
		for(String str: colList){
			if(!StringUtils.format(primaryKey).equals(str)&&!"createTime".equals(str)&&!"createBy".equals(str)&&!"updateTime".equals(str)&&!"updateBy".equals(str)){
				sb.append("\t\t\t\t<div class=\"am-g am-margin-top\">\n");  
				sb.append("\t\t\t\t\t<div class=\"am-u-sm-4 am-u-md-2 am-text-right\">").append(str).append("</div>\n");
				sb.append("\t\t\t\t\t<div class=\"am-u-sm-8 am-u-md-4 am-u-end\">").append("\\${"+tableName +"."+str+"}").append("</div>\n");
				sb.append("\t\t\t\t</div>\n"); 
			}
		}
		String newContent = content.replaceAll("[$][{]cgFieId}", sb.toString());
		return newContent;
	} 
}
