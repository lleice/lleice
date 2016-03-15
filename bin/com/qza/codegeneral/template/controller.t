package ${packageName}.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import ${packageName}.constant.Const;
import ${packageName}.entity.${ClassName};
import ${packageName}.service.${ClassName}Service;
import ${packageName}.util.StringUtil;

@RequestMapping(value="/admin/${className}")
@Controller
public class ${ClassName}AdminController {
	
	private static Logger logger = LoggerFactory.getLogger( ${ClassName}AdminController.class );
	
	@Autowired
	private ${ClassName}Service ${className}Service;
	
	
	@RequestMapping
    public String list(@RequestParam( value = "pageNo", defaultValue = "1" ) Integer pageNo,
	        @RequestParam( value = "pageSize", defaultValue = Const.PAGE_SIZE ) Integer pageSize, @ModelAttribute ${ClassName} ${className}, Model model ){
		try {
		    PageBounds pageBounds = new PageBounds( pageNo, pageSize, Order.formString( "${primaryKey}.desc" ) );
			PageList<${ClassName}> list = ${className}Service.get${ClassName}PageList( ${className}, pageBounds );
			model.addAttribute( "paginator", list != null ? list.getPaginator() : null );			
			model.addAttribute("list", list);		
			model.addAttribute("${className}", ${className});
		} catch (Exception e) {
			logger.error( e.getMessage(),e );
		}
        return "admin/${className}/list";
    }
	
	@RequestMapping(value="/detail/{${primaryKey}}", method = RequestMethod.GET )
    public String detail(@PathVariable ${primaryKeyType} ${primaryKey}, Model model ){
		try {
			${ClassName} ${className} = ${className}Service.get${ClassName}ByPrimaryKey(${primaryKey});
            model.addAttribute("${className}", ${className});
		} catch (Exception e) {
			logger.error( e.getMessage(),e );
		}
        return "admin/${className}/detail";
    }
    
	@RequestMapping(value="/update/{${primaryKey}}", method = RequestMethod.GET )
    public String update(@PathVariable ${primaryKeyType} ${primaryKey}, Model model ){
		try {
			${ClassName} ${className} = ${className}Service.get${ClassName}ByPrimaryKey(${primaryKey});
            model.addAttribute("${className}", ${className});
		} catch (Exception e) {
			logger.error( e.getMessage(),e );
		}
        return "admin/${className}/update";
    }
 
    @RequestMapping(value="/update", method = RequestMethod.POST , produces = MediaType.APPLICATION_JSON_VALUE )
	@ResponseBody
    public Map<String,Object> update(@ModelAttribute ${ClassName} ${className}){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			${ClassName} old${ClassName} = ${className}Service.get${ClassName}ByPrimaryKey(${className}.get${PrimaryKey}());
			${updateAssignValue}
			${className}Service.update${ClassName}Selective(old${ClassName});
			map.put("${className}", ${className});
			map.put(Const.STATUS, Const.SUCCESS);
		} catch (Exception e) {
			logger.error( e.getMessage(),e );
			map.put(Const.STATUS, Const.FAILURE);
			map.put(Const.ERROR_MESSAGE, Const.UPDATE_EXCEPTION);
		}
        return map;
    }
   
    @RequestMapping(value="/create", method = RequestMethod.GET )
    public String detail( Model model ){
        return "admin/${className}/create";
    }
    
    @RequestMapping(value="/create", method = RequestMethod.POST , produces = MediaType.APPLICATION_JSON_VALUE )
    @ResponseBody
    public Map<String,Object> create(@ModelAttribute ${ClassName} ${className}){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			${className}Service.create${ClassName}(${className});
			map.put("${className}", ${className});
			map.put(Const.STATUS, Const.SUCCESS);
		} catch (Exception e) {
			logger.error( e.getMessage(),e );
			map.put(Const.STATUS, Const.FAILURE);
			map.put(Const.ERROR_MESSAGE, Const.CREATE_EXCEPTION);
		}
        return map;
    }
    
    @RequestMapping(value="/delete/{${primaryKey}}", produces = MediaType.APPLICATION_JSON_VALUE )
	@ResponseBody
    public Map<String,Object> delete(@PathVariable ${primaryKeyType} ${primaryKey}){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			${className}Service.delete${ClassName}(${primaryKey});
			map.put(Const.STATUS, Const.SUCCESS);
		} catch (Exception e) {
			logger.error( e.getMessage(),e );
			map.put(Const.STATUS, Const.FAILURE);
			map.put(Const.ERROR_MESSAGE, Const.DELETE_EXCEPTION);
		}
        return map;
    }
    
    @RequestMapping(value="/deletes", method = RequestMethod.POST , produces = MediaType.APPLICATION_JSON_VALUE )
	@ResponseBody
    public Map<String,Object> deletes(String ${primaryKey}s){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
		    List<Integer> ${primaryKey}List = StringUtil.generateListInteger(${primaryKey}s);
			${className}Service.delete${ClassName}Bitch(${primaryKey}List);
			map.put(Const.STATUS, Const.SUCCESS);
		} catch (Exception e) {
			logger.error( e.getMessage(),e );
			map.put(Const.STATUS, Const.FAILURE);
			map.put(Const.ERROR_MESSAGE, Const.DELETE_EXCEPTION);
		}
        return map;
    }
}