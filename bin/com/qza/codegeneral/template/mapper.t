package ${packageName}.repository;

import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import ${packageName}.entity.${ClassName};

@MyBatisRepository
public interface ${ClassName}Mapper {

	public List<${ClassName}> get${ClassName}List();

	public PageList<${ClassName}> get${ClassName}List( PageBounds pageBounds );
	
	public List<${ClassName}> get${ClassName}PageList( ${ClassName} ${className} );
	
	public PageList<${ClassName}> get${ClassName}PageList(${ClassName} ${className}, PageBounds pageBounds );
	
	public ${ClassName} get${ClassName}ByPrimaryKey(${primaryKeyType} ${primaryKey});
	
	public void create${ClassName}(${ClassName} ${className});
	
	public void update${ClassName}(${ClassName} ${className});
	
	public void update${ClassName}Selective(${ClassName} ${className});
	
	public void delete${ClassName}(${primaryKeyType} ${primaryKey});
}