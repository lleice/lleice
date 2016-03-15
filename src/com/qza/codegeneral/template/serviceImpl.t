package ${packageName}.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import ${packageName}.repository.${ClassName}Mapper;
import ${packageName}.entity.${ClassName};
import ${packageName}.service.${ClassName}Service;

@Service
@Transactional 
public class ${ClassName}ServiceImpl implements ${ClassName}Service { 

    @Autowired
	private ${ClassName}Mapper ${className}Mapper;
	
	public List<${ClassName}> get${ClassName}List(){
		return ${className}Mapper.get${ClassName}List();
	}
	
	public PageList<${ClassName}> get${ClassName}List(PageBounds pageBounds){
		return ${className}Mapper.get${ClassName}List(pageBounds);
	}
	
	public List<${ClassName}> get${ClassName}PageList(${ClassName} ${className}){
		return ${className}Mapper.get${ClassName}PageList(${className});
	}
	
	public PageList<${ClassName}> get${ClassName}PageList(${ClassName} ${className}, PageBounds pageBounds){
		return ${className}Mapper.get${ClassName}PageList(${className},pageBounds);
	}
	
	public ${ClassName} get${ClassName}ByPrimaryKey(${primaryKeyType} ${primaryKey}){
		return ${className}Mapper.get${ClassName}ByPrimaryKey(${primaryKey});
	}
	
	public void create${ClassName}(${ClassName} ${className}){
		${className}Mapper.create${ClassName}(${className});
	}
	
	public void create${ClassName}Bitch(List<${ClassName}> ${className}List){
		for( ${ClassName} ${className} : ${className}List ) {
			${className}Mapper.create${ClassName}(${className});
		}
	}
	
	public void update${ClassName}(${ClassName} ${className}){
		${className}Mapper.update${ClassName}(${className});
	}
	
	public void update${ClassName}Bitch(List<${ClassName}> ${className}List){
	    for( ${ClassName} ${className} : ${className}List ) {
		    ${className}Mapper.update${ClassName}(${className});
		}
	}
	
	public void update${ClassName}Selective(${ClassName} ${className}){
	    ${className}Mapper.update${ClassName}Selective(${className});
	}
	
	public void update${ClassName}SelectiveBitch(List<${ClassName}> ${className}List){
	    for( ${ClassName} ${className} : ${className}List ) {
		    ${className}Mapper.update${ClassName}Selective(${className});
		}
	}
	
	public void delete${ClassName}(${primaryKeyType} ${primaryKey}){
		${className}Mapper.delete${ClassName}(${primaryKey});
	}
	
	public void delete${ClassName}Bitch(List<${primaryKeyType}> ${primaryKey}List){
		for( ${primaryKeyType} ${primaryKey} : ${primaryKey}List ) {
			${className}Mapper.delete${ClassName}(${primaryKey});
		}
	}

}
