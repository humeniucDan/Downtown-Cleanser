package com.example.be_bitstone.handlers;

import com.example.be_bitstone.entity.User;
import com.example.be_bitstone.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class UserHandler {
    @Autowired
    private UserService userService;

    public ResponseEntity<?> signup(User user){
        try {
            return new ResponseEntity<>(userService.save(user), HttpStatus.OK);
        } catch (Exception e){
            System.out.println(e.getMessage());
            return new ResponseEntity<>("Error creating new user!", HttpStatus.OK);
        }
    }
}
