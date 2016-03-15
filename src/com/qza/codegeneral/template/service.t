package ${packageName}.service;

import java.util.List;
 
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import ${packageName}.entity.${ClassName};

public interface ${ClassName}Service {

	public List<${ClassName}> get${ClassName}List();
	
	public PageList<${ClassName}> get${ClassName}List(PageBounds pageBounds);
	
	public List<${ClassName}> get${ClassName}PageList(${ClassName} ${className});
	
	public PageList<${ClassName}> get${ClassName}PageList(${ClassName} ${className}, PageBounds pageBounds);
	
	public ${ClassName} get${ClassName}ByPrimaryKey(${primaryKeyType} ${primaryKey});
	
	public void create${ClassName}(${ClassName} ${className});
	
	public void create${ClassName}Bitch(List<${ClassName}> ${className}List);
	
	public void update${ClassName}(${ClassName} ${className});
	
	public void update${ClassName}Bitch(List<${ClassName}> ${className}List);
	
	public void update${ClassName}Selective(${ClassName} ${className});
	
	public void update${ClassName}SelectiveBitch(List<${ClassName}> ${className}List);
	
	public void delete${ClassName}(${primaryKeyType} ${primaryKey});
	
	public void delete${ClassName}Bitch(List<${primaryKeyType}> ${primaryKey}List);

}
