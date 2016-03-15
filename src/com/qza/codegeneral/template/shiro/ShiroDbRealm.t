/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements. See the NOTICE file distributed with this
 * work for additional information regarding copyright ownership. The ASF
 * licenses this file to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
package ${package}.shiro;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.PostConstruct;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.google.common.base.Objects;
import ${package}.shiro.HttpCredentialsMatcher;

@Component( "shiroDbRealm" )
public class ShiroDbRealm extends AuthorizingRealm {

	private static Logger logger = LoggerFactory.getLogger( ShiroDbRealm.class );

	/**
	 * 璁よ瘉鍥炶皟鍑芥暟,鐧诲綍鏃惰皟鐢�
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo( AuthenticationToken authcToken ) throws AuthenticationException {
		try{
//			String _name = getCheckName( loginName, name, mobile, email );
//			ShiroUser user1 = new ShiroUser( loginName, _name, userNo, parentNo, supplierType, role, type );
//			AuthenticationInfo ai = new HttpOAuthAuthenticationInfo( user1, loginName, true, user1.getName() );
//			return ai;
			return null;
		}
		catch( Exception e ) {
			logger.error( "楠岃瘉鐧诲綍閿欒: " + e.getMessage() );
			throw new AuthenticationException( e.getMessage() );
		}
	}

	/**
	 * 鎺堟潈鏌ヨ鍥炶皟鍑芥暟, 杩涜閴存潈浣嗙紦瀛樹腑鏃犵敤鎴风殑鎺堟潈淇℃伅鏃惰皟鐢�鍦ㄩ厤鏈夌紦瀛樼殑鎯呭喌涓嬶紝鍙姞杞戒竴娆�
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo( PrincipalCollection principalCollection ) {
		// 鑾峰彇鐧诲綍鏃惰緭鍏ョ殑鐢ㄦ埛鍚�
		ShiroUser shiroUser = (ShiroUser)principalCollection.getPrimaryPrincipal();

		// 鍒版暟鎹簱鏌ユ槸鍚︽湁姝ゅ璞�
		if( shiroUser != null ) {
			// 鏉冮檺淇℃伅瀵硅薄info,鐢ㄦ潵瀛樻斁鏌ュ嚭鐨勭敤鎴风殑鎵�湁鐨勮鑹诧紙role锛夊強鏉冮檺锛坧ermission锛�
			SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
			// 鐢ㄦ埛鐨勮鑹查泦鍚�
			Set<String> roles = new HashSet<String>();
			roles.add( shiroUser.role );
			info.setRoles( roles );
			// 鐢ㄦ埛鐨勮鑹插搴旂殑鎵�湁鏉冮檺锛屽鏋滃彧浣跨敤瑙掕壊瀹氫箟璁块棶鏉冮檺锛屼笅闈㈢殑鍥涜鍙互涓嶈
			List<String> perms = new ArrayList<String>();
			perms.add( "supplierAdmin:view" );
			info.addStringPermissions( perms );
			return info;
		}
		return null;
	}
	
	/**
	 * 鏇存柊鐢ㄦ埛鎺堟潈淇℃伅缂撳瓨.
	 */
	public void clearCachedAuthorizationInfo( Object principal ) {
		SimplePrincipalCollection principals = new SimplePrincipalCollection( principal, getName() );
		clearCachedAuthorizationInfo( principals );
	}

	/**
	 * 娓呴櫎鎵�湁鐢ㄦ埛鎺堟潈淇℃伅缂撳瓨.
	 */
	public void clearAllCachedAuthorizationInfo() {
		Cache<Object, AuthorizationInfo> cache = getAuthorizationCache();
		if( cache != null ) {
			for( Object key : cache.keys() ) {
				cache.remove( key );
			}
		}
	}

	/**
	 * 璁惧畾Password鏍￠獙鐨凥ash绠楁硶涓庤凯浠ｆ鏁�
	 */
	@PostConstruct
	public void initCredentialsMatcher() {
		// HashedCredentialsMatcher matcher = new
		// HashedCredentialsMatcher(AccountService.HASH_ALGORITHM);
		// matcher.setHashIterations(AccountService.HASH_INTERATIONS);
		// setCredentialsMatcher(matcher);
		HttpCredentialsMatcher matcher = new HttpCredentialsMatcher();
		setCredentialsMatcher( matcher );
	}

	/**
	 * 鑷畾涔堿uthentication瀵硅薄锛屼娇寰桽ubject闄や簡鎼哄甫鐢ㄦ埛鐨勭櫥褰曞悕澶栬繕鍙互鎼哄甫鏇村淇℃伅.
	 */
	public static class ShiroUser implements Serializable {
		private static final long serialVersionUID = -1373760761780840081L;

		public String loginName;

		public String name;

		public String userNo;

		public String role;

		public ShiroUser(String loginName, String name, String userNo,String role) {
			this.loginName = loginName;
			this.name = name;
			this.userNo = userNo;
			this.role = role;
		}

		public String getName() {
			return name;
		}

		public String getUserNo() {
			return userNo;
		}

		public String getRole() {
			return role;
		}

		/**
		 * 鏈嚱鏁拌緭鍑哄皢浣滀负榛樿鐨�shiro:principal/>杈撳嚭.
		 */
		@Override
		public String toString() {
			return name;
		}

		/**
		 * 閲嶈浇hashCode,鍙绠條oginName;
		 */
		@Override
		public int hashCode() {
			return Objects.hashCode( loginName );
		}

		/**
		 * 閲嶈浇equals,鍙绠條oginName;
		 */
		@Override
		public boolean equals( Object obj ) {
			if( this == obj ) {
				return true;
			}
			if( obj == null ) {
				return false;
			}
			if( getClass() != obj.getClass() ) {
				return false;
			}
			ShiroUser other = (ShiroUser)obj;
			if( loginName == null ) {
				if( other.loginName != null ) {
					return false;
				}
			}
			else if( !loginName.equals( other.loginName ) ) {
				return false;
			}
			return true;
		}
	}

	/**
	 * 寰楀埌褰撳墠鐧诲綍鐢ㄦ埛
	 * 
	 * @return
	 */
	public static ShiroUser getLoginUser() {
		return (ShiroUser)SecurityUtils.getSubject().getPrincipal();
	}

	/**
	 * 鍙栧嚭Shiro涓殑褰撳墠鐢ㄦ埛userNo.
	 */
	public static String getCurrentUserNo() {
		ShiroUser user = getLoginUser();
		if( user != null ) {
			return user.getUserNo();
		}
		return null;
	}

}
