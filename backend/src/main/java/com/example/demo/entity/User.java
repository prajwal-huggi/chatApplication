package com.example.demo.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data//for getter and setter method add lombok anotation
@AllArgsConstructor//lombok anno
@NoArgsConstructor
@Entity//to create the table
@Table(name = "user_tab")//for the table name

public class User {
	@Id//for id to be primary key
    //below annotation to auto increment the id value
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    public  String username;

    public  String email;

    public  String password;

}
