package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.entity.User;
import com.example.demo.repo.UserRepo;


@Service
public class UserService {
    @Autowired
    private UserRepo repo;
    
    public boolean checkUniqueUser(User user) {
    	return repo.findByUsernameOrEmail(user.username, user.email)== null;
    }

    public String saveUser(User user) {

        repo.save(user);
        return "User registered Successfully";

    }	
    
    public Boolean validateUser(User user) {
//    	in this I am getting the username and pass now I have to 
    	//check whether they are present in the mysql database or not
    	return repo.findByUsernameAndPassword(user.username, user.password)!= null;
    }
    
    public String getEmail(User user) {
    	User u1= repo.findEmailByUsername(user.username);
    	String email= u1.email;
    	return email;
    }
}
