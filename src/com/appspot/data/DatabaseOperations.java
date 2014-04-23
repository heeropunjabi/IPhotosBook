package com.appspot.data;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import com.appspot.model.IndexAction;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.KeyFactory;

public class DatabaseOperations {
	
	DatastoreService datastore;
	private String userName;
	
	private static final Logger log = Logger.getLogger(IndexAction.class.getName());
	
	
	public DatabaseOperations(){
		
		log.info("inside data constructor");
		datastore = DatastoreServiceFactory.getDatastoreService();
		
	}
	
	
	public void addFavoritePage(String pageUrl){
		
		log.info("inside data constructor add");
		Entity user =null;
		List<String> listOfURL=null;
		
			try
			{
				log.info("for update condition");
				user=datastore.get(KeyFactory.createKey("Users",getUserName()));
				listOfURL=(List<String>) user.getProperty("listOfURLS");
				if(listOfURL==null)
					listOfURL=new ArrayList<String>();
			
			}
			catch(EntityNotFoundException e)
			{
				log.info("for New user condition");
				log.info("inside add mehtod entity not found");
				user = new Entity("Users",getUserName());
				listOfURL=new ArrayList<String>();
				
			}
			
			listOfURL.add(pageUrl);
			user.setProperty("listOfURLS", listOfURL);
			datastore.put(user);
		
		
	
		
		
		
		
	
		
	
		
		
	}
	
	
	public void deleteFavoritePage(String pageUrl){
		
		
		log.info("inside data constructor delete");
		log.info("inside data constructor delete getusername="+getUserName());
		
		Entity user=null;
		
		try {
			user = datastore.get(KeyFactory.createKey("Users",getUserName()));
		} catch (EntityNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		
		
		List<String> listOfURL =(List<String>) user.getProperty("listOfURLS");
		if(listOfURL!=null && listOfURL.size()>0)
		{
			
			listOfURL.remove(listOfURL.indexOf(pageUrl));

			user.setProperty("listOfURLS", listOfURL);
			
			datastore.put(user);
			
			log.info("inside data constructor delete done ");
		}
		
		
	}
	
	
	
	public List<String>  getListOFFavoritePages(){
		
		log.info("inside data constructor get page url");
		
		

		Entity user=null;
		
		try {
			user = datastore.get(KeyFactory.createKey("Users",getUserName()));
		} catch (EntityNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		
		try{
		List<String> listOfURL=(List<String>) user.getProperty("listOfURLS");
		log.info("inside data constructor get page url list="+listOfURL);
		
		
		return listOfURL;
			
		}
		catch(Exception e){
			System.out.println("Exception "+e.toString());
			log.info("inside catch get page url ");
			
			return null;
			
		}
		
	}
	
	
	
	
	

	public DatastoreService getDatastore() {
		return datastore;
	}

	public void setDatastore(DatastoreService datastore) {
		this.datastore = datastore;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	

}
