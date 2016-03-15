package ${packageName}.controller.front;

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

@RequestMapping(value="/${className}")
@Controller
public class ${ClassName}Controller {
	
	private static Logger logger = LoggerFactory.getLogger( ${ClassName}Controller.class );
	
	@Autowired
	private ${ClassName}Service ${className}Service;
	
	
	@RequestMapping( method = RequestMethod.GET )
    public String list(@RequestParam( value = "pageNo", defaultValue = "1" ) Integer pageNo,
	        @RequestParam( value = "pageSize", defaultValue = Const.PAGE_SIZE ) Integer pageSize, @ModelAttribute ${ClassName} ${className}, Model model ){
		try {
		    PageBounds pageBounds = new PageBounds( pageNo, pageSize, Order.formString( "${primaryKey}.desc" ) );
			PageList<${ClassName}> pageList = ${className}Service.get${ClassName}PageList( ${className}, pageBounds );
			model.addAttribute( "paginator", pageList != null ? pageList.getPaginator() : null );			
			model.addAttribute("list", pageList);
		} catch (Exception e) {
			logger.error( e.getMessage(),e );
		}
        return "front/${className}/list";
    }

    @RequestMapping( method = RequestMethod.POST , produces = MediaType.APPLICATION_JSON_VALUE )
	@ResponseBody
    public PageList<${ClassName}> list(@RequestParam( value = "pageNo", defaultValue = "1" ) Integer pageNo,
	        @RequestParam( value = "pageSize", defaultValue = Const.PAGE_SIZE ) Integer pageSize, @ModelAttribute ${ClassName} ${className} ){
	    PageList<${ClassName}> pageList = null;
		try {
		    PageBounds pageBounds = new PageBounds( pageNo, pageSize, Order.formString( "${primaryKey}.desc" ) );
			pageList = ${className}Service.get${ClassName}PageList( ${className}, pageBounds );
			return pageList;
		} catch (Exception e) {
			logger.error( e.getMessage(),e );
		}
        return pageList;
    }
	
	@RequestMapping(value="/detail/{${primaryKey}}", method = RequestMethod.GET )
    public String detail(@PathVariable ${primaryKeyType} ${primaryKey}, Model model ){
		try {
			${ClassName} ${className} = ${className}Service.get${ClassName}ByPrimaryKey(${primaryKey});
            model.addAttribute("${className}", ${className});
		} catch (Exception e) {
			logger.error( e.getMessage(),e );
		}
        return "front/${className}/form";
    }
    
}