<?xml version="1.0" encoding="UTF-8" ?>  
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd"> 
<mapper namespace="${packageName}.repository.${ClassName}Mapper">
    <resultMap type="${packageName}.entity.${ClassName}" id="${className}Map">
${resultMap}
    </resultMap>
    
    <sql id="Example_Where_Clause" >
	  <trim prefix="where" prefixOverrides="and|or" >
	    ${whereColumnListStr}
	  </trim>
  	</sql>
	<sql id="Base_Column_List" >
	  ${columnListStr}
    </sql>
    
    <select id="get${ClassName}List" resultMap="${className}Map">
    	${selectListSql}
    </select>
    
    <select id="get${ClassName}PageList" resultMap="${className}Map" parameterType="${packageName}.entity.${ClassName}">
    	${selectListWhereSql}
    </select>
    
    <select id="get${ClassName}ByPrimaryKey" parameterType="${primaryKeyType}" resultMap="${className}Map">
    	${selectSql}
    </select>
    
    <insert id="create${ClassName}" parameterType="${packageName}.entity.${ClassName}">
        ${insertPk}
		${insertSql}
    </insert>
    
    <update id="update${ClassName}" parameterType="${packageName}.entity.${ClassName}">
		${updateSql}
    </update>
    
    <update id="update${ClassName}Selective" parameterType="${packageName}.entity.${ClassName}">
		${updateSelectiveSql}
    </update>
    
    <delete id="delete${ClassName}" parameterType="${primaryKeyType}">
    	${deleteSql}
    </delete>
</mapper>