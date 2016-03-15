package ${package}.shiro;

import org.apache.shiro.config.Ini;
import org.apache.shiro.config.Ini.Section;
import org.apache.shiro.util.CollectionUtils;
import org.apache.shiro.web.config.IniFilterChainResolverFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.FactoryBean;
import org.springframework.stereotype.Component;

/**
 * 借助spring {@link FactoryBean} 对apache shiro的premission进行动态创建
 * 
 * @author quan
 * 
 */
@Component
public class ChainDefinitionSectionMetaSource implements FactoryBean<Ini.Section> {

	private static Logger logger = LoggerFactory.getLogger( ChainDefinitionSectionMetaSource.class );
	
	// shiro默认的链接定义
	private String filterChainDefinitions;

	/**
	 * 通过filterChainDefinitions对默认的链接过滤定义
	 * 
	 * @param filterChainDefinitions 默认的接过滤定义
	 */
	public void setFilterChainDefinitions( String filterChainDefinitions ) {
		this.filterChainDefinitions = filterChainDefinitions;
	}

	@Override
	public Section getObject() throws Exception {
		// TODO Auto-generated method stub
		Ini ini = new Ini();
		// 加载默认的url
		ini.load( filterChainDefinitions );

		Ini.Section section = ini.getSection( IniFilterChainResolverFactory.URLS );
		if( CollectionUtils.isEmpty( section ) ) {
			section = ini.getSection( Ini.DEFAULT_SECTION_NAME );
		}
		logger.info( " resource loaded" );
		// section.put("/acct/scene","authc,user, perms[scene:*]");
		// test/* = role[admin],perms[test:view]

		// 循环数据库资源的url
//					section.put( cmlMenu.getActionUrl(), "role[" + cmlMenu.getAppRoleName() + "], perms[" + cmlMenu.getPermission() + "]" );
					/*
					 * System.out.println( "/" + cmlMenu.getActionUrl() + " = "
					 * + "role[" + cmlMenu.getAppRoleName() + "], perms[" +
					 * cmlMenu.getPermission() + "]" );
					 */

		return section;
	}

	@Override
	public Class<?> getObjectType() {
		// TODO Auto-generated method stub
		return Section.class;
	}

	@Override
	public boolean isSingleton() {
		// TODO Auto-generated method stub
		return true;
	}

}
