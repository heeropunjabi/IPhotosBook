package com.appspot.model;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import java.util.logging.Logger;

import com.appspot.data.DatabaseOperations;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.opensymphony.xwork2.ActionSupport;

public class IndexAction extends ActionSupport
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private boolean isLoggedIn=false;
	private List<String> listOfURLs=new ArrayList<String>();
	private String signInURL=new String();
	private String signOutURL=new String();
	
	private String userName=new String();
	
	private DatabaseOperations dbOperations=null;
	
	private String url=new String();
	
	
	
	public IndexAction() {
		// TODO Auto-generated constructor stub
	
	}

	public String getUrl() {
		return url;
	}



	public void setUrl(String url) {
		this.url = url;
	}



	private static final Logger log = Logger.getLogger(IndexAction.class.getName());
	
	public String execute() 
	{
		log.info("inside execute method");
		HttpServletRequest request = ServletActionContext.getRequest();
		
		UserService userService = UserServiceFactory.getUserService();
		
		String thisURL = request.getRequestURI();
		
		
		if(request.getUserPrincipal()!=null)
		{
			setUserName(request.getUserPrincipal().getName());
			
			setSignOutURL(userService.createLogoutURL(thisURL));
			signOutURL=userService.createLogoutURL(thisURL);
			System.out.println("sign out url"+getSignOutURL());
			
			
			log.info("sign out url="+getSignOutURL());
			log.info("sign out url service="+userService.createLogoutURL(thisURL));
			
			
			
			isLoggedIn=true;
			
			log.info("is loggin ="+isLoggedIn());
			
			log.info("username="+userName);
			
			
			setLoggedIn(true);
			
			dbOperations=new DatabaseOperations();
			dbOperations.setUserName(getUserName());
			getFavoritePages();
			
			
		}
		
		else
		{
			setUserName("");
			setSignInURL(userService.createLoginURL(thisURL));
			
			
			log.info("sign in url"+getSignInURL());
			log.info("sign in url service"+userService.createLoginURL(thisURL));
			
			isLoggedIn=false;
			
			setLoggedIn(false);
			
			
			log.info("is loggin ="+isLoggedIn());
			//dbOperations=null;
		}
		
		return "success";
		
	}
	
	
	
	public String getUserName() {
		return userName;
	}



	public void setUserName(String userName) {
		this.userName = userName;
	}



	public void addFavoritePage()
	{
		
		log.info("inside addFavoritePage");
		log.info("url"+url);
		execute();
		if(dbOperations!=null){
			dbOperations.addFavoritePage(url);
		}
	}
	
	public void deleteFavoritePage()
	{
		log.info("inside deleteFavoritePage");
		log.info("url"+url);
		
		execute();
		if(dbOperations!=null){
			dbOperations.deleteFavoritePage(url);
		}
	}
	
	public void getFavoritePages()
	{
		
		
		log.info("inside getListOFFavoritePages");
		log.info("url"+url);
		
		
		if(dbOperations!=null){
			listOfURLs = dbOperations.getListOFFavoritePages();
			if(listOfURLs!=null)
				Collections.reverse(listOfURLs);
			log.info("inside indexaction"+listOfURLs);
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public boolean isLoggedIn() {
		return isLoggedIn;
	}



	public void setLoggedIn(boolean isLoggedIn) {
		this.isLoggedIn = isLoggedIn;
	}



	public List<String> getListOfURLs() {
		return listOfURLs;
	}



	public void setListOfURLs(List<String> listOfURLs) {
		this.listOfURLs = listOfURLs;
	}



	public String getSignInURL() {
		return signInURL;
	}



	public void setSignInURL(String signInURL) {
		this.signInURL = signInURL;
	}



	public String getSignOutURL() {
		return signOutURL;
	}



	public void setSignOutURL(String signOutURL) {
		this.signOutURL = signOutURL;
	}



	public DatabaseOperations getDbOperations() {
		return dbOperations;
	}



	public void setDbOperations(DatabaseOperations dbOperations) {
		this.dbOperations = dbOperations;
	}



	
	
	

}



