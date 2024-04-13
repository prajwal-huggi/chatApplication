package com.example.demo.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.entity.User;

public interface UserRepo extends JpaRepository<User,Integer> {
 //It is used for the CRUD operation
	User findByUsernameOrEmail(String username, String email);
	
	User findByUsernameAndPassword(String username, String password);
	
	User findEmailByUsername(String username);
}
