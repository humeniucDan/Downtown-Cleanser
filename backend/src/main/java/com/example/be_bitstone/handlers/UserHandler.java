package com.example.be_bitstone.handlers;

import com.example.be_bitstone.entity.User;
import com.example.be_bitstone.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import java.util.Optional;

@Component
public class UserHandler {
    @Autowired
    private UserService userService;

    public ResponseEntity<?> signup(User user){
        try {
            return new ResponseEntity<>(userService.save(user), HttpStatus.OK);
        } catch (Exception e){
            System.out.println(e.getMessage());
            return new ResponseEntity<>("Error creating new user!", HttpStatus.BAD_REQUEST);
        }
    }

    public ResponseEntity<?> getById(Long id){
        try {
            Optional<User> optUser = userService.findById(id);
            if(optUser.isEmpty()){
                return new ResponseEntity<>("No such user!", HttpStatus.BAD_REQUEST);
            }
            return new ResponseEntity<>(optUser.get(), HttpStatus.OK);
        } catch (Exception e){
            System.out.println(e.getMessage());
            return new ResponseEntity<>("Error retrieving new user!", HttpStatus.BAD_REQUEST);
        }
    }

    public ResponseEntity<?> getAll(){
        try{
            return new ResponseEntity<>(userService.findAllUsers(), HttpStatus.OK);
        } catch (Exception e){
            System.out.println(e.getMessage());
            return new ResponseEntity<>("Error retrieving all users!", HttpStatus.BAD_REQUEST);
        }
    }
}
